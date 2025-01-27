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

### Loading GTFS Data

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
- Load core GTFS tables (routes, agency, trips, stops, stop_times, calendar, and calendar_dates) into the 'raw' schema in that DuckDB database

2. Verify the data load using DuckDB CLI:
```bash
duckdb transit_dbt_sandbox.duckdb -c "SELECT count(*) FROM raw.routes;"
```

3. Build dbt to run and test all the defined models:
```bash
uv run dbt build
```

4. To explore the models that exist, use the dbt docs, which you can generate and serve locally as follows:

```bash
uv run dbt docs generate && uv run dbt docs serve
```

#### Loading more than one feed

By default, the load script will overwrite the raw data tables if they already exist and the entire DuckDB database will be dropped, so any dbt-created views and tables will be removed.

If you want to append new data into the database while keeping the data you've already loaded, use the `--append` flag: `uv run python load_gtfs.py --append [your additional GTFS feed URL or filepath]`.

If you run with `--append`, the new feed will be loaded into the `raw` schema but dbt will not be run automatically, so your raw schema and any dbt-created tables will be out of sync. 

Loaded feeds are listed in the `raw.feed_metadata` table in the DuckDB database. 

## Development and Testing

Once you have the project set up, please use it as your sandbox! Make changes to models, add tests, etc. Below are some handy commands you can use to test your work and some concepts you may want to test out. 

### dbt Commands

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

### Querying DuckDB

You can query the DuckDB database as follows:

```bash
duckdb transit_dbt_sandbox.duckdb -c "[your query here, ex: SELECT * FROM raw.agency;]"
```

### Example tasks

Some things you could try out: 

* Add some additional [tests](https://docs.getdbt.com/docs/build/data-tests): What are some data integrity guarantees that are not tested yet? 
* Create new models (tables/views): For example, try making a new mart model that summarizes number of trips per service date per route with first and last arrival times.
* Enhance the functionality: For example, the repo does not actually correctly implement the use of `agency.agency_timezone` to localize the dates and times in the feed. 
* Test out [incremental logic](https://docs.getdbt.com/docs/build/incremental-models): The `fct_service_stops` and `fct_service_stops_incremental` models are identical, except that the second one is incremental and has an `_insert_time` column recording the time when records were inserted. You can use these models to try out different approaches to making a model incremental.

> [!NOTE]  
> At time of writing, the [DuckDB dbt adapter](https://github.com/duckdb/dbt-duckdb) only supports the `append` and `delete+insert` [incremental strategies](https://medium.com/refined-and-refactored/dbt-incremental-choosing-the-right-strategy-p1-6113d51898ec).
