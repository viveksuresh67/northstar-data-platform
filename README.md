# NorthStar Data Platform

A production-style analytics engineering project built with Snowflake and dbt, transforming raw e-commerce data into tested, documented, analytics-ready models.

## Project Overview

NorthStar addresses a common analytics problem: raw operational data can be difficult to use consistently across Finance, Sales, and Operations.

The platform transforms raw e-commerce data through a layered ELT architecture:

**Raw Data → Staging → Intermediate → Marts**

The final marts provide a trusted analytical layer for reporting and business analysis.

## Architecture

NorthStar follows a layered ELT architecture designed to separate raw data ingestion, transformation, business logic, and analytics consumption.

```text
Raw E-commerce Data
        │
        ▼
Snowflake RAW
        │
        ▼
dbt Staging
        │
        ▼
dbt Intermediate
        │
        ▼
dbt Marts
        │
        ▼
Analytics / BI
```

## Technology Stack

- **Snowflake** — Cloud data warehouse
- **dbt** — Data transformation, testing, documentation, and lineage
- **SQL** — Data transformation and analytical modeling
- **Python** — Data loading and supporting automation
- **Git / GitHub** — Version control and collaborative development

## Data Models

The final analytics layer is organized as a star schema.

### Fact Tables

- `fct_orders` — Order-level information including status, payment, and delivery SLA metrics.
- `fct_sales` — Order-item level sales transactions including product, seller, customer, pricing, and freight information.

### Dimension Tables

- `dim_customers` — Customer-level order history and activity metrics.
- `dim_products` — Product attributes and aggregated sales metrics.
- `dim_sellers` — Seller attributes and aggregated sales performance.
- `dim_dates` — Calendar attributes for time-based analysis.

## Data Quality & Validation

Data quality was validated throughout the transformation pipeline using dbt tests and targeted SQL reconciliation checks.

### dbt Tests

- Primary and business keys tested for `unique` and `not_null` where appropriate.
- Required foreign keys tested for `not_null`.
- Source freshness configured for raw data.
- All dbt tests passed successfully.

### Analytical Validation

The final models were validated against their upstream sources and dimensions:

- `fct_sales` contains **112,650** order-item records.
- `fct_sales` contains **112,650** unique `order_id + order_item_id` combinations.
- Product, seller, customer, and date relationships were validated with **0 orphan records**.
- Product sales reconciled exactly to the source order-item data.
- Freight totals reconciled exactly to the source order-item data.
- Full `dbt build` completed successfully.

## Documentation & Lineage

The project uses dbt documentation to provide a centralized view of the analytics layer.

The generated documentation includes:

- Model and column descriptions
- Data types and metadata
- Source definitions
- Data quality tests
- Model dependencies
- End-to-end lineage across the transformation layers

The dbt lineage graph makes it possible to trace how raw source data flows through staging and intermediate models into the final analytical marts.

## Development Workflow

Development followed a feature-branch and pull-request workflow:

1. Create a feature branch from `main`.
2. Develop and validate a logical unit of work.
3. Run dbt builds and data quality tests.
4. Commit changes with a meaningful commit message.
5. Push the feature branch to GitHub.
6. Open a pull request against `main`.
7. Review and merge the pull request.
8. Synchronize the local `main` branch before starting the next feature.

This workflow keeps the production branch stable while allowing individual transformations and improvements to be developed independently.

## Project Structure

```text
northstar-data-platform/
│
├── data/
│   └── raw/                    # Raw source data files
│
├── models/
│   ├── staging/
│   │   └── olist/              # Source-level standardization
│   │
│   ├── intermediate/
│   │   └── olist/              # Reusable transformation logic
│   │
│   ├── marts/
│   │   └── olist/              # Analytics-ready fact and dimension tables
│   │
│   └── sources/                # dbt source definitions
│
├── macros/                     # Custom dbt macros
├── scripts/                    # Python data-loading and utility scripts
├── dbt_project.yml             # dbt project configuration
├── packages.yml                # dbt package configuration
├── README.md
└── .gitignore
```

## Setup

### Prerequisites

- Python 3.12+
- Snowflake account
- dbt Core
- Git

### Clone the Repository

```bash
git clone https://github.com/viveksuresh67/northstar-data-platform.git
cd northstar-data-platform
```

### Configure dbt

Create a local `profiles.yml` file containing your Snowflake connection details.

The Snowflake password should be provided through the `SNOWFLAKE_PASSWORD` environment variable.

Connection credentials and environment-specific configuration are excluded from version control.

### Run the Project

Activate the Python virtual environment:

```bash
source .venv/bin/activate
```

Verify the dbt connection:

```bash
dbt debug
```

Build the complete transformation pipeline:

```bash
dbt build
```

Generate and serve the dbt documentation:

```bash
dbt docs generate
dbt docs serve
```