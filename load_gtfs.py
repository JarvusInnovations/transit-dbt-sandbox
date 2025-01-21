#!/usr/bin/env python3
import argparse
import base64
import duckdb
import pandas as pd
import pendulum
import requests
import zipfile
from io import BytesIO
from pathlib import Path

# Column definitions for each GTFS table
# Only load a few core tables, this is not comprehensive 
GTFS_COLUMNS = {
    "agency": [
        "feed_id",
        "agency_id",
        "agency_name",
        "agency_url",
        "agency_timezone",
        "agency_lang",
        "agency_phone",
        "agency_fare_url",
        "agency_email"
    ],
    "stops": [
        "feed_id",
        "stop_id",
        "stop_code",
        "stop_name",
        "tts_stop_name",
        "stop_desc",
        "stop_lat",
        "stop_lon",
        "zone_id",
        "stop_url",
        "location_type",
        "parent_station",
        "stop_timezone",
        "wheelchair_boarding",
        "level_id",
        "platform_code"
    ],
    "routes": [
        "feed_id",
        "route_id",
        "agency_id",
        "route_short_name",
        "route_long_name",
        "route_desc",
        "route_type",
        "route_url",
        "route_color",
        "route_text_color",
        "route_sort_order",
        "continuous_pickup",
        "continuous_drop_off",
        "network_id"
    ],
    "trips": [
        "feed_id",
        "route_id",
        "service_id",
        "trip_id",
        "trip_headsign",
        "trip_short_name",
        "direction_id",
        "block_id",
        "shape_id",
        "wheelchair_accessible",
        "bikes_allowed"
    ],
    "stop_times": [
        "feed_id",
        "trip_id",
        "arrival_time",
        "departure_time",
        "stop_id",
        "stop_sequence",
        "stop_headsign",
        "pickup_type",
        "drop_off_type",
        "shape_dist_traveled",
        "timepoint",
        "start_pickup_drop_off_window",
        "end_pickup_drop_off_window",
        "continuous_pickup",
        "continuous_drop_off",
        "pickup_booking_rule_id",
        "drop_off_booking_rule_id"
    ],
    "calendar": [
        "feed_id",
        "service_id",
        "monday",
        "tuesday",
        "wednesday",
        "thursday",
        "friday",
        "saturday",
        "sunday",
        "start_date",
        "end_date"
    ],
    "calendar_dates": [
        "feed_id",
        "service_id",
        "date",
        "exception_type"
    ]
}

def download_gtfs(url: str) -> BytesIO:
    """Download GTFS feed from URL and return as bytes."""
    response = requests.get(url)
    response.raise_for_status()
    return BytesIO(response.content)

def load_gtfs_table(conn: duckdb.DuckDBPyConnection, zip_data: BytesIO, table_name: str, feed_id, append: bool = False):
    """Load a GTFS table from the zip file into DuckDB."""
    try:
        with zipfile.ZipFile(zip_data) as z:
            # Reset zip file pointer
            zip_data.seek(0)
            # Read CSV directly from zip
            # Load everything as strings and fill NAs to avoid issues with different data types between agencies (if loading multiple feeds)    
            df = pd.read_csv(z.open(f"{table_name}.txt"), dtype=str).fillna("")
            df['feed_id'] = feed_id

            # Get columns for this table
            table_columns = GTFS_COLUMNS.get(table_name, [])
            if not table_columns:
                raise Exception(f"No column definitions found for {table_name}")

            # Create table if it doesn't exist or if we're not appending
            columns_sql = ", ".join([f"{col} VARCHAR" for col in table_columns])
            create_sql = "CREATE TABLE" if append else "CREATE OR REPLACE TABLE"
            
            # Check if table exists when appending
            if append:
                table_exists = conn.execute(f"""
                    SELECT EXISTS (
                        SELECT 1 
                        FROM information_schema.tables 
                        WHERE table_schema = 'raw' 
                        AND table_name = '{table_name}'
                    )
                """).fetchone()[0]
                
                if not table_exists:
                    conn.execute(f"{create_sql} raw.{table_name} ({columns_sql})")
            else:
                conn.execute(f"{create_sql} raw.{table_name} ({columns_sql})")

            # Get common columns between DataFrame and table definition
            df_cols = set(df.columns)
            common_cols = [col for col in table_columns if col in df_cols]
            
            if not common_cols:
                raise Exception(f"No matching columns found between table definition and input data for {table_name}")
            
            # Insert data using common columns
            cols_sql = ", ".join(common_cols)
            conn.execute(f"INSERT INTO raw.{table_name} ({cols_sql}) SELECT {cols_sql} FROM df")

            print(f"Loaded {len(df)} rows into raw.{table_name}")
    except KeyError:
        print(f"Warning: {table_name}.txt not found in GTFS feed")
    except Exception as e:
        print(f"Error loading {table_name}: {str(e)}")

def main():
    parser = argparse.ArgumentParser(description="Load GTFS feed into DuckDB")
    parser.add_argument("url", help="URL of GTFS feed zip file")
    parser.add_argument("--append", action="store_true", help="Append to existing tables instead of replacing them")
    parser.add_argument("--feed_name", default='', help="A name for the feed to be stored as a label in DuckDB")
    args = parser.parse_args()

    # Connect to DuckDB
    conn = duckdb.connect("transit_dbt_sandbox.duckdb")
    
    try:
        # Create raw schema
        conn.execute("CREATE SCHEMA IF NOT EXISTS raw")

        # Create an identifying timestamp
        load_time = pendulum.now('UTC')
        feed_id = base64.urlsafe_b64encode((str(load_time) + args.feed_name).encode()).decode()

        # Download GTFS feed
        print(f"Downloading GTFS feed from {args.url}")
        zip_data = download_gtfs(args.url)

        # Load an identifying table 
        if not args.append:
            # Create or replace table
            conn.execute(f"CREATE OR REPLACE TABLE raw.feed_metadata (load_time TIMESTAMPTZ, name VARCHAR, id VARCHAR)") 

        # Follow example from Cal-ITP -- make a string based on base64 encoding as ID
        # Use import time instead of URL to avoid encoding credentials 
        conn.execute(f"INSERT INTO raw.feed_metadata VALUES ('{load_time}', '{args.feed_name}', '{feed_id}')")       
        
        # Load core GTFS tables
        tables = list(GTFS_COLUMNS.keys())
        
        for table in tables:
            load_gtfs_table(conn, zip_data, table, feed_id, args.append)
            
        print("GTFS data load complete")
        
    except Exception as e:
        print(f"Error: {str(e)}")
        raise
    finally:
        conn.close()

if __name__ == "__main__":
    main()
