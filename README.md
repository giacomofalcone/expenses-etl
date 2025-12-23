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
*(Qui devi inserire il link alla tua immagine caricata, es: ![Overview](dashboard_overview.png))*

### Key Insights
* **Drill-down capability:** From Macro-categories (Home, Food) to single transaction lines.
* **Temporal Analysis:** Monthly trends and Quarter-over-Quarter comparison.

## Key Technical Components (Talend Jobs)
* `jCategorie_FILE_ODS`: Master data ingestion for categories.
* `jDepense_FILE_ODS`: Incremental loading of expense transactions.
* `jFaitDepense_ODS_DWH`: Populating the Fact Table.
