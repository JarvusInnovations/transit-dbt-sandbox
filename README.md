# Transit dbt Sandbox

This repo contains an example dbt project that can be run locally using public transit GTFS data from a specified agency. 

## Project Structure

```
models/
├── staging/          # Clean & standardize raw data
├── intermediate/     # Join and prepare staging models
└── marts/           # Business-level transformations
```

### Layers

- **Staging**: One-to-one with source tables, light transformations
- **Intermediate**: Complex transformations, joining multiple staging models
- **Marts**: Business-level aggregations and final models

## Getting Started

### Prerequisites

- Python 3.11+
- uv (package manager)
- DuckDB CLI (install from https://duckdb.org/docs/installation or via Homebrew: `brew install duckdb`)
- dbt 1.9+

Note: The DuckDB CLI is required for running database commands directly in the terminal. This is separate from the Python duckdb package used by the load script.

### Installation

1. Clone this repository
2. Set up a Python virtual environment:
```bash
uv venv .venv
source .venv/bin/activate
```

3. Install dependencies:
```bash
uv pip install dbt-core dbt-duckdb
```

4. Install dbt packages:
```bash
dbt deps
```

### Configuration

The project is configured to use a local DuckDB database file. No additional database configuration is required.

To verify your setup:
```bash
dbt debug
```

## Loading GTFS Data

Before running dbt models, you need to load GTFS data into your local DuckDB database:

1. Ensure you have the required Python packages:
```bash
uv pip install requests pandas duckdb
```

2. Run the load_gtfs.py script with a GTFS feed URL:
```bash
python load_gtfs.py [your GTFS feed URL]
```

This will:
- Download the GTFS feed
- Create a local DuckDB database file (transit_dbt_sandbox.duckdb)
- Load core GTFS tables (routes, agency, trips, stops, etc.) into the 'raw' schema

3. Verify the data load:
```bash
duckdb transit_dbt_sandbox.duckdb -c "SELECT count(*) FROM raw.routes;"
```

## Development

### Running Models

- Run all models:
```bash
dbt run
```

- Run specific models:
```bash
dbt run --select staging
dbt run --select marts
```

### Testing

```bash
dbt test
```

## Resources

- [dbt Documentation](https://docs.getdbt.com/)
- [dbt Discourse](https://discourse.getdbt.com/)
- [dbt Slack](https://community.getdbt.com/)
