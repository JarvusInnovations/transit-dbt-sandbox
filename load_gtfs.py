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

def load_gtfs_table(conn: duckdb.DuckDBPyConnection, zip_data: BytesIO, table_name: str):
    """Load a GTFS table from the zip file into DuckDB."""
    try:
        with zipfile.ZipFile(zip_data) as z:
            # Reset zip file pointer
            zip_data.seek(0)
            # Read CSV directly from zip
            df = pd.read_csv(z.open(f"{table_name}.txt"))
            # Create table in raw schema
            conn.execute(f"CREATE TABLE IF NOT EXISTS raw.{table_name} AS SELECT * FROM df")
            print(f"Loaded {len(df)} rows into raw.{table_name}")
    except KeyError:
        print(f"Warning: {table_name}.txt not found in GTFS feed")
    except Exception as e:
        print(f"Error loading {table_name}: {str(e)}")

def main():
    parser = argparse.ArgumentParser(description="Load GTFS feed into DuckDB")
    parser.add_argument("url", help="URL of GTFS feed zip file")
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
            load_gtfs_table(conn, zip_data, table)
            
        print("GTFS data load complete")
        
    except Exception as e:
        print(f"Error: {str(e)}")
        raise
    finally:
        conn.close()

if __name__ == "__main__":
    main()
