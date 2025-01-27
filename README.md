# Transit dbt Sandbox

This repo contains an example dbt project that can be run locally using public transit GTFS data, to help people accustomed to working with transit data become familiar with dbt. The functionality in this repo is designed to run entirely locally, without needing any cloud infrastructure, to focus specifically on learning dbt. 

## Project Structure

The project generally follows dbt's [guide on how to structure a dbt project](https://docs.getdbt.com/best-practices/how-we-structure/1-guide-overview).

## Getting Started

### Prerequisites

- Python 3.11+ (see [Python Beginner's Guide](https://wiki.python.org/moin/BeginnersGuide/Download))
- uv package and virtual environment manager (see [uv instructions](https://docs.astral.sh/uv/getting-started/installation/))
- dbt 1.9+ (see [dbt instructions](https://docs.getdbt.com/docs/core/installation-overview#install-dbt-core))
- DuckDB CLI (see [DuckDB instructions](https://duckdb.org/docs/installation))

### Installation

1. Clone this repository

2. Initialize virtual environment and install dependencies from lockfile:
```bash
uv venv
uv pip sync
```

3. Install dbt packages:
```bash
uv run dbt deps
```

### Configuration

The project is configured to use a local DuckDB database file. No additional database configuration is required.

To verify your setup:
```bash
uv run dbt debug
```

## Loading GTFS Data

Before running dbt models, you need to load GTFS data into your local DuckDB database:

1. Run the load_gtfs.py script with a GTFS feed URL or local filepath (to the zipped GTFS feed):
```bash
uv run python load_gtfs.py "[your GTFS feed URL or filepath]"
```

You can optionally include a `feed_name` for labeling purposes:

```bash
uv run python load_gtfs.py "[your GTFS feed URL or filepath]" --feed_name "my_feed"
```

This will:
- Download the GTFS feed
- Create a local DuckDB database file (transit_dbt_sandbox.duckdb)
- Load core GTFS tables (routes, agency, trips, stops, etc.) into the 'raw' schema in that DuckDB database

### Loading more than one feed

By default, the load script will overwrite the raw data tables if they already exist and the entire DuckDB database will be dropped, so any dbt-created views and tables will be removed.

If you want to append new data into the database, use the `--append` flag: `uv run python load_gtfs.py --append [your additional GTFS feed URL or filepath]`.

If you run with `--append`, the new feed will be loaded into the `raw` schema but dbt will not be run automatically, so your raw schema and any dbt-created tables will be out of sync. 

Loaded feeds are listed in the `raw.feed_metadata` table in the DuckDB database. 

2. Verify the data load using DuckDB CLI:
```bash
duckdb transit_dbt_sandbox.duckdb -c "SELECT count(*) FROM raw.routes;"
```

## Development and Testing

Once you have the project set up, please use it as your sandbox! Make changes to models, add tests, etc. Below are some handy commands you can use to test your work. 

### dbt 

See the [dbt CLI reference](https://docs.getdbt.com/reference/dbt-commands) for a guide to available dbt commands. Preface commands with `uv run` to use the uv virtual environment in the repo. For example, you can:

- Run all models:
```bash
uv run dbt run
```
- Run specific models:
```bash
uv run dbt run --select staging
uv run dbt run --select marts
```
- Test your models:
```bash
uv run dbt test
```

### DuckDB 

You can query the DuckDB database as follows:

```bash
duckdb transit_dbt_sandbox.duckdb -c "[your query here, ex: SELECT * FROM raw.agency;]"
```