#!/usr/bin/env python3
import argparse
import duckdb
import pandas as pd
import requests
import zipfile
from io import BytesIO
from pathlib import Path

def download_gtfs(url: str) -> BytesIO:
    """Download GTFS feed from URL and return as bytes."""
    response = requests.get(url)
    response.raise_for_status()
    return BytesIO(response.content)

def load_gtfs_table(conn: duckdb.DuckDBPyConnection, zip_data: BytesIO, table_name: str, append: bool = False):
    """Load a GTFS table from the zip file into DuckDB."""
    try:
        with zipfile.ZipFile(zip_data) as z:
            # Reset zip file pointer
            zip_data.seek(0)
            # Read CSV directly from zip
            # Load everything as strings and fill NAs to avoid issues with different data types between agencies (if loading multiple feeds)
            df = pd.read_csv(z.open(f"{table_name}.txt"), dtype=str).fillna("")
            if append:
                # Check if table exists and get its schema
                table_exists = conn.execute(f"""
                    SELECT EXISTS (
                        SELECT 1 
                        FROM information_schema.tables 
                        WHERE table_schema = 'raw' 
                        AND table_name = '{table_name}'
                    )
                """).fetchone()[0]
                
                if table_exists:
                    # Get existing columns
                    existing_cols = conn.execute(f"""
                        SELECT column_name 
                        FROM information_schema.columns 
                        WHERE table_schema = 'raw' 
                        AND table_name = '{table_name}'
                        ORDER BY ordinal_position
                    """).fetchall()
                    existing_cols = [col[0] for col in existing_cols]
                    
                    # Get new columns from DataFrame
                    new_cols = df.columns.tolist()
                    
                    # Find common columns
                    common_cols = list(set(existing_cols) & set(new_cols))
                    
                    if not common_cols:
                        raise Exception(f"No matching columns found between existing table and new data for {table_name}")
                    
                    # Create SQL for inserting only common columns
                    cols_sql = ", ".join(common_cols)
                    conn.execute(f"INSERT INTO raw.{table_name} ({cols_sql}) SELECT {cols_sql} FROM df")
                else:
                    # If table doesn't exist, create it
                    conn.execute(f"CREATE TABLE raw.{table_name} AS SELECT * FROM df")
            else:
                # Create or replace table
                conn.execute(f"CREATE OR REPLACE TABLE raw.{table_name} AS SELECT * FROM df")
            print(f"Loaded {len(df)} rows into raw.{table_name}")
    except KeyError:
        print(f"Warning: {table_name}.txt not found in GTFS feed")
    except Exception as e:
        print(f"Error loading {table_name}: {str(e)}")

def main():
    parser = argparse.ArgumentParser(description="Load GTFS feed into DuckDB")
    parser.add_argument("url", help="URL of GTFS feed zip file")
    parser.add_argument("--append", action="store_true", help="Append to existing tables instead of replacing them")
    args = parser.parse_args()

    # Connect to DuckDB
    conn = duckdb.connect("transit_dbt_sandbox.duckdb")
    
    try:
        # Create raw schema
        conn.execute("CREATE SCHEMA IF NOT EXISTS raw")
        
        # Download GTFS feed
        print(f"Downloading GTFS feed from {args.url}")
        zip_data = download_gtfs(args.url)
        
        # Load core GTFS tables
        tables = [
            "routes",
            "agency",
            "trips",
            "stops",
            "stop_times",
            "calendar",
            "calendar_dates"
        ]
        
        for table in tables:
            load_gtfs_table(conn, zip_data, table, args.append)
            
        print("GTFS data load complete")
        
    except Exception as e:
        print(f"Error: {str(e)}")
        raise
    finally:
        conn.close()

if __name__ == "__main__":
    main()
