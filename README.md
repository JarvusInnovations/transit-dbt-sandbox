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
- DuckDB
- dbt 1.9+

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
