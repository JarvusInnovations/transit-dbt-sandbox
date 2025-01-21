# Transit dbt Sandbox

This repo contains an example dbt project that can be run locally using public transit GTFS data from a specified agency. 

## Project Structure

The project generally follows dbt's [guide on how to structure a dbt project](https://docs.getdbt.com/best-practices/how-we-structure/1-guide-overview).

## Getting Started

### Prerequisites

- Python 3.11+
- uv (install with `pip install uv`)
- dbt 1.9+
- DuckDB CLI (install from https://duckdb.org/docs/installation or via Homebrew: `brew install duckdb`)

Note: The DuckDB CLI is required for running database commands directly in the terminal. This is separate from the Python duckdb package used by the load script.

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

1. Run the load_gtfs.py script with a GTFS feed URL:
```bash
uv run python load_gtfs.py [your GTFS feed URL]
```

This will:
- Download the GTFS feed
- Create a local DuckDB database file (transit_dbt_sandbox.duckdb)
- Load core GTFS tables (routes, agency, trips, stops, etc.) into the 'raw' 

> [!NOTE]  
> By default, this script will overwrite the tables if they already exist. If you want to append new data into the database, use the `--append` flag: `uv run python load_gtfs.py --append [your GTFS feed URL]`.

2. Verify the data load using DuckDB CLI:
```bash
duckdb transit_dbt_sandbox.duckdb -c "SELECT count(*) FROM raw.routes;"
```

## Development

### Running Models

- Run all models:
```bash
uv run dbt run
```

- Run specific models:
```bash
uv run dbt run --select staging
uv run dbt run --select marts
```

### Testing

```bash
uv run dbt test
```

## Resources

- [dbt Documentation](https://docs.getdbt.com/)
- [dbt Discourse](https://discourse.getdbt.com/)
- [dbt Slack](https://community.getdbt.com/)
