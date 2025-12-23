# Expense Tracking ETL Pipeline

**Project Type:** Data Engineering Lab / Showcase  
**Tech Stack:** Talend Open Studio, Snowflake, Power BI, SQL.

## Overview
This repository hosts an end-to-end data pipeline designed to ingest personal expense data, transform it into a dimensional model, and visualize it. It demonstrates a full ETL lifecycle from raw file ingestion to BI reporting.

**Note:** The source code in this repo consists of Talend-generated Java/XML configuration files. The logic is defined in the ETL jobs described below.

## Architecture

1.  **Ingestion (Extract):**
    * Retrieves raw excel files (`SAISIE_DEPENSE.xlsx`) from Google Drive.
    * Loads data into **Snowflake** staging tables (ODS Layer).

2.  **Transformation (Transform):**
    * Cleans and structures data into a **Star Schema** (DWH Layer).
    * **Fact Table:** `Fact_Expense` (Transactions).
    * **Dimensions:** `Dim_Category`, `Dim_Time`, `Dim_Description`.

3.  **Visualization (Load/Serve):**
    * Power BI connected to Snowflake DWH.
    * Key metrics: Monthly burn rate, Fixed vs. Variable split, Category drill-down.

## Visual Output (Power BI)

### Dashboard Overview
![Home Page](assets/PowerBI/home.png)

### Key Insights
* **Drill-down capability:** From Macro-categories (Home, Food) to single transaction lines.
* **Temporal Analysis:** Monthly trends and Quarter-over-Quarter comparison.

## Key Technical Components (Talend Jobs)

## Entity-Relationship Diagram (ERD)

```mermaid
erDiagram
    %% Fact Table
    FAIT_DEPENSE {
        VARCHAR(6) SK_DEPENSE PK
        DATE SK_DATE FK
        NUMBER SK_SOUS_CATEGORIE FK
        NUMBER SK_DESCRIPTION FK
        NUMBER(10_2) MONTANT_DEPENSE
    }

    %% Dimensions
    DIM_TEMPS {
        DATE date_calendar PK
        INTEGER num_year
        INTEGER num_month
        VARCHAR lib_month
        VARCHAR lib_quater
    }

    DIM_SOUS_CATEGORIE_DEPENSE {
        NUMBER SK_SOUS_CATEGORIE PK
        VARCHAR SOUS_CATEGORIE
        VARCHAR CATEGORIE
    }

    DIM_DESCRIPTION_DEPENSE {
        NUMBER SK_DESCRIPTION PK
        VARCHAR DESCRIPTION_DEPENSE
    }

    %% Relationships
    FAIT_DEPENSE }|..|| DIM_TEMPS : "occurs on"
    FAIT_DEPENSE }|..|| DIM_SOUS_CATEGORIE_DEPENSE : "categorized as"
    FAIT_DEPENSE }|..|| DIM_DESCRIPTION_DEPENSE : "described as"

### 1. Data Modeling (Snowflake)
The database schema uses a **Star Schema** optimized for analytics.
* **Source Code:** [View SQL DDL Script](./sql/init_warehouse.sql)
* **Fact Table:** `FAIT_DEPENSE` connects transactions to dimensions via surrogate keys.
* **Dimensions:**
    * `DIM_TEMPS`: Custom Calendar table with quarters and semesters (`lib_quater`, `lib_semester`).
    * `DIM_SOUS_CATEGORIE_DEPENSE`: Denormalized dimension containing both Category and Sub-Category logic.
    * `DIM_DESCRIPTION_DEPENSE`: Isolates transaction descriptions to reduce redundancy.
