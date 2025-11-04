
# 🧠 SQL Data Analytics Project

A comprehensive collection of **SQL scripts** designed for **data exploration, analysis, and reporting**.  
This repository includes end-to-end queries to analyze dimensions, measures, trends, cumulative metrics, segmentation, and performance indicators in a **data warehouse environment**.

Each SQL file focuses on a **specific analytical objective** and adheres to **best practices** for performance, structure, and clarity — making it ideal for **data analysts, business intelligence developers, and SQL learners**.

---

## 📊 Project Overview

This project simulates a **Data Warehouse** built on SQL Server and follows a structured analytical workflow:

1. **Database Creation & Schemas**
   - Builds the `DataWarehouseAnalytics` database and `gold` schema.
   - Includes dimension and fact tables for products, customers, and sales.

2. **Exploration & Profiling**
   - Database, dimension, and date range exploration scripts.
   - Identifies key characteristics, unique values, and temporal ranges.

3. **Measures & KPIs**
   - Calculates key business metrics:
     - Total sales
     - Total quantity
     - Average price
     - Active customers
     - Average order revenue

4. **Advanced Analysis**
   - Year-over-year product performance.
   - Category contribution to overall sales.
   - Product segmentation and revenue ranking.
   - Monthly trends and cumulative performance analysis.

Each query has been **documented with professional headers**, **step-by-step logic**, and **inline comments** to ensure readability and compliance with **international SQL Server standards**.

---

## ⚙️ Technologies Used

| Tool | Description |
|------|--------------|
| **SQL Server** | Main database engine used for querying and data analysis |
| **T-SQL** | Query language following Microsoft SQL Server standards |
| **CSV Datasets** | Used for bulk loading dimension and fact tables |
| **GitHub** | Repository hosting for version control and collaboration |

---

## 🧩 Folder Structure

sql-data-analytics-project/
│
├── 01_create_database.sql
├── 02_database_exploration.sql
├── 03_dimensions_exploration.sql
├── 04_date_range_exploration.sql
├── 05_measures_exploration.sql
├── 06_category_sales_analysis.sql
├── 07_product_performance.sql
├── 08_yearly_product_sales.sql
│
└── datasets/
├── gold.dim_customers.csv
├── gold.dim_products.csv
└── gold.fact_sales.csv


---

## 🚀 Getting Started

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/<your-username>/sql-data-analytics-project.git

2️⃣ Open SQL Server Management Studio (SSMS)

Run the script 01_create_database.sql to create the database and load data.

Execute the other scripts in order to explore and analyze the data.

3️⃣ Review Outputs

Each script includes a clear analytical outcome (tables, aggregations, or KPIs).

🧠 Learning Goals

This project strengthens the following data analytics skills:

Data modeling (fact & dimension design)

Analytical SQL (window functions, CTEs, aggregations)

Data profiling and quality checks

Performance optimization and reporting logic

Real-world business insights extraction

👤 Author

David Stocco
Data Analyst | SQL | Python | Tableau | Data-Driven Mindset

🛡️ License

This project is licensed under the MIT License
.
You are free to use, modify, and share it with proper attribution.

🌟 Acknowledgments

This project was inspired by Data With Baraa’s SQL Data Analytics Project and adapted with enhanced documentation, structure, and compliance for professional portfolio use.




