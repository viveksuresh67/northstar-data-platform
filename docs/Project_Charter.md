# NorthStar Data Platform

> **Project Charter**

This document defines the vision, scope, architecture, and
implementation plan for the **NorthStar Data Platform**. It is the
single source of truth for this project.

------------------------------------------------------------------------

# 1. Vision

## Project Goal

Design and build a **production-style data platform** that transforms
raw operational data into trusted, analytics-ready data models using
modern analytics engineering practices.

## Recruiter Takeaway

I want recruiters to see that I can **design, build, test, document, and
maintain a modern data platform** using industry-standard engineering
practices. This project demonstrates data modeling, ELT pipelines, data
quality, version control, and analytics engineering principles while
solving a real business problem.

------------------------------------------------------------------------

# 2. Company

## Company Name

**NorthStar Retail**

## Company Description

NorthStar Retail is a fictional mid-sized Canadian retailer with stores
across multiple provinces and a growing e-commerce business. It sells
clothing, home goods, and seasonal products.

------------------------------------------------------------------------

# 3. Business Problem

Finance, Sales, and Operations all calculate key business metrics
differently, resulting in inconsistent KPIs and a lack of trust in
reporting.

The company relies on manually maintained Excel reports and
department-specific SQL queries, creating duplicated business logic and
delayed reporting.

**Objective:** Build a centralized data platform that provides a single
source of truth for business data.

------------------------------------------------------------------------

# 4. Dataset

## Selected Dataset

**Olist E-Commerce Dataset**

This project uses the publicly available Olist e-commerce dataset to
simulate the operational systems of NorthStar Retail.

------------------------------------------------------------------------

# 5. Source Systems

-   Customer Management
-   Order Management
-   Product Catalog
-   Payments
-   Reviews
-   Sellers
-   Geolocation

------------------------------------------------------------------------

# 6. Business Questions

-   Which products generate the highest revenue?
-   Which regions generate the most sales?
-   Which customers have the highest lifetime value?
-   Which product categories have the highest return rates?
-   How has revenue changed month-over-month?
-   Which sellers consistently underperform?
-   Which products receive poor customer reviews?

------------------------------------------------------------------------

# 7. KPIs

-   Revenue
-   Profit
-   Average Order Value
-   Customer Lifetime Value
-   Top Products
-   Regional Sales
-   Monthly Growth
-   Return Rate
-   Inventory Turnover

------------------------------------------------------------------------

# 8. Technical Architecture

    Raw Files
        ↓
    Snowflake (Raw Layer)
        ↓
    dbt Staging
        ↓
    dbt Intermediate
        ↓
    dbt Marts
        ↓
    Data Quality Tests
        ↓
    Source Freshness
        ↓
    dbt Documentation

**Phase 2**

    Databricks Migration

------------------------------------------------------------------------

# 9. Project Scope

## In Scope

-   Snowflake
-   dbt
-   SQL
-   Git
-   GitHub
-   Data Modeling
-   Data Quality
-   Source Freshness
-   Documentation

## Out of Scope

-   Dashboard development
-   Streaming pipelines
-   Real-time processing
-   Kubernetes
-   Spark (until Databricks phase)

------------------------------------------------------------------------

# 10. dbt Models

## Staging

-   stg_customers
-   stg_orders
-   stg_order_items
-   stg_products
-   stg_payments
-   stg_reviews
-   stg_sellers

## Intermediate

-   int_customer_orders
-   int_order_payments
-   int_product_sales

## Marts

-   dim_customers
-   dim_products
-   dim_dates
-   dim_sellers
-   fct_orders
-   fct_sales

These models form the trusted semantic layer of the data platform.

------------------------------------------------------------------------

# 11. Deliverables

-   Production-style dbt project
-   Layered data models
-   Source definitions
-   Source freshness monitoring
-   Generic and custom data quality tests
-   dbt documentation
-   Architecture diagrams
-   Professional README
-   Professional Git history
-   Deployment instructions
-   Databricks migration plan (Phase 2)

------------------------------------------------------------------------

# 12. Git Workflow

    main
    │
    ├── feature/project-setup
    ├── feature/source-definitions
    ├── feature/staging-models
    ├── feature/tests
    ├── feature/intermediate-models
    ├── feature/marts
    └── feature/documentation

Each feature branch will:

-   Contain one logical unit of work.
-   Include meaningful commits.
-   Be merged into `main` using a Pull Request.
-   Be deleted after merging.

------------------------------------------------------------------------

# 13. Stretch Goals

1.  Databricks migration
2.  Incremental dbt models
3.  CI/CD
4.  AI-assisted analytics
5.  Forecasting

------------------------------------------------------------------------

# 14. Success Criteria

The project is complete when:

-   The platform provides a trusted single source of truth.
-   All dbt models pass testing.
-   Source freshness monitoring is configured.
-   Business-ready data models answer business questions consistently.
-   The repository is fully documented.
-   Another developer can clone the repository and run the project.
-   The platform can be migrated to Databricks with minimal redesign.

------------------------------------------------------------------------

# Notes

Capture future ideas, assumptions, and design decisions here. Once a
design decision is finalized, it should only change if there is a strong
technical reason.
