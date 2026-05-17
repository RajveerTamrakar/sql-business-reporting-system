# Project Datasets

This directory contains the raw source files used to build the data warehouse pipeline. The data is structured around a core transactional table and its corresponding lookup tables.

## 📋 Data Sources

1. **Facts File (`fact_sales`)**
   - Contains core business transactions and measurable numbers.
   - Includes metrics like sales amounts, quantities ordered, keys for linking, and order dates.

2. **Customers File (`dim_customers`)**
   - A descriptive lookup table containing unique customer attributes.
   - Includes customer names, IDs, regions, and demographic details.

3. **Products File (`dim_products`)**
   - A descriptive lookup table containing product details.
   - Includes product names, categories, and manufacturing keys.

## 📐 Data Architecture (Star Schema)
These files are engineered into a Star Schema design. The Central Fact table connects directly to the Customer and Product Dimension tables using unique key columns to enable fast, optimized business intelligence reporting.
