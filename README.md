# SQL Business Reporting System

## 📌 Project Overview
This project focuses on transforming raw sales transaction data into a reusable business reporting system using SQL Server. The goal is to simulate how real-world analytics and BI teams prepare clean reporting datasets for dashboards, KPI tracking, and data-driven business decision-making.

Instead of querying raw transactional tables repeatedly, this project builds reusable reporting views that centralize critical business calculations, including:
* **Customer Analytics:** Customer segmentation, recency analysis, and customer lifetime value.
* **Product Analytics:** Product performance analysis and product revenue segmentation.
* **Sales Analysis:** Revenue KPIs, average order metrics, running totals, and Year-over-Year (YoY) performance.

The project follows a warehouse-style approach using Fact and Dimension tables organized in a Star Schema structure.

---

## 🎯 Business Problems Solved

### 👥 Customer Analytics
* **Value Identification:** Who are the highest-value customers?
* **Behavioral Grouping:** Which customers are new, regular, or VIP?
* **Activity Tracking:** How recently has a customer purchased?
* **Spend Patterns:** What is the average customer spend over time?

### 📦 Product Analytics
* **Performance Tracking:** Which products generate the highest revenue and which are underperforming?
* **Customer Reach:** How many unique customers buy each product?
* **Order Valuation:** What is the average revenue generated per order?

### 📈 Sales & Revenue Analysis
* **Trend Analysis:** Monthly and yearly sales trends.
* **Growth Tracking:** Running total sales analysis and Year-over-Year (YoY) product performance.
* **Market Share:** Category contribution to overall sales.

---

## 🏗️ Data Architecture
The project utilizes a centralized **Star Schema** data warehouse design optimized for analytical query performance:



*   **Fact Table (`fact_sales`):** Stores core transactional metrics including orders, revenue, quantities, customer keys, product keys, and order dates.
*   **Dimension Tables:**
    *   `dim_customers`: Contains customer profiles, names, and demographic information.
    *   `dim_products`: Contains product details, names, categories, subcategories, and product costs.

---

## 📁 Repository Structure

```text
sql-business-reporting-system/
│
├── datasets/
│   ├── fact_sales.csv
│   ├── dim_customers.csv
│   └── dim_products.csv
│
├── scripts/
│   ├── database_setup.sql
│   ├── customer_report.sql
│   ├── product_report.sql
│   ├── sales_analysis.sql
│   ├── segmentation_analysis.sql
│   └── yoy_analysis.sql
│
├── screenshots/
├── insights/
└── README.md
