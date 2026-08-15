# NorthStar Raw Layer

## Purpose

The RAW layer is the landing layer for source data. Data is loaded from
the Olist CSV source files into Snowflake with minimal transformation.

-   **Database:** `NORTHSTAR`
-   **Schema:** `RAW`

## Source Data

The Olist e-commerce dataset is stored locally under:

``` text
data/raw/olist/
```

The source files are CSV files.

## Snowflake File Format

A Snowflake CSV file format named `CSV_FORMAT` was created to define how
the source CSV files are interpreted during ingestion.

## Snowflake Internal Stage

An internal stage named `RAW_OLIST_STAGE` was created in the `RAW`
schema.

The ingestion flow is:

``` text
Local CSV
   ↓
RAW_OLIST_STAGE
   ↓
COPY INTO
   ↓
NORTHSTAR.RAW table
```

## Raw Tables

  Table                                   Row Count
  ------------------------------------- -----------
  `OLIST_CUSTOMERS`                          99,441
  `OLIST_GEOLOCATION`                     1,000,163
  `OLIST_ORDER_ITEMS`                       112,650
  `OLIST_ORDER_PAYMENTS`                    103,886
  `OLIST_ORDER_REVIEWS`                      99,224
  `OLIST_ORDERS`                             99,441
  `OLIST_PRODUCTS`                           32,951
  `OLIST_SELLERS`                             3,095
  `PRODUCT_CATEGORY_NAME_TRANSLATION`            71

## Table Creation Approaches

### 1. Manual DDL

`OLIST_CUSTOMERS` was created manually to understand explicit table
definitions and Snowflake data types.

### 2. Snowflake Schema Inference

`OLIST_ORDERS` and `OLIST_PRODUCTS` were created using Snowflake schema
inference. The inferred schemas were reviewed before loading the data.

### 3. Metadata-Driven Python DDL Generation

The remaining six tables were created using:

``` text
scripts/generate_ddl.py
```

The utility:

1.  Reads CSV headers from `data/raw/olist/`.
2.  Applies metadata-based data type rules.
3.  Generates `CREATE TABLE` statements.
4.  Writes one `.sql` file per table under `sql/ddl/`.

The generated DDL was reviewed before execution.

DDL execution was automated using:

``` text
scripts/execute_ddl.py
```

This script reads the generated SQL files and executes them against the
`NORTHSTAR.RAW` schema.

## Data Loading

The source CSV files were uploaded to the internal stage and loaded into
their corresponding RAW tables using `COPY INTO`.

Example:

``` sql
COPY INTO RAW.olist_customers
FROM @raw_olist_stage
FILES = ('olist_customers_dataset.csv');
```

Load results were checked for successful status, rows parsed, rows
loaded, and errors.

## Validation

The RAW layer was validated by checking:

-   All nine expected tables exist.
-   All nine tables contain data.
-   Load operations completed successfully.
-   Row counts were checked against the staged source files.

## Engineering Notes

The RAW layer is kept close to the source data. Transformations and
business logic should be handled downstream rather than during
ingestion.

The ingestion architecture is:

``` text
Source files
    ↓
Internal stage
    ↓
RAW tables
    ↓
dbt transformations
```

DDL generation and execution are also separated:

``` text
CSV metadata
    ↓
generate_ddl.py
    ↓
SQL files
    ↓
execute_ddl.py
    ↓
Snowflake
```
