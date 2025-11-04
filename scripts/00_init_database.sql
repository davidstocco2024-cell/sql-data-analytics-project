/*
===============================================================================
Create Database and Schemas
===============================================================================
Purpose:
    - To initialize the foundational database environment for analytics.
    - Creates the database [DataWarehouseAnalytics] and its core schema [gold].
    - Builds the primary dimension and fact tables.
    - Loads data from external CSV files using BULK INSERT.

Key Operations:
    1. Checks if the target database exists — if it does, drops and recreates it.
    2. Defines the 'gold' schema to store curated analytical tables.
    3. Creates and structures dimension and fact tables:
        - gold.dim_customers
        - gold.dim_products
        - gold.fact_sales
    4. Populates each table with data from CSV sources.

WARNING:
    ⚠️ Running this script will completely remove and recreate the 
    'DataWarehouseAnalytics' database. All existing data will be permanently lost.
    Ensure proper backups exist before execution.
===============================================================================
*/

USE master;
GO

-- ========================================
-- Step 1: Drop existing database if it exists
-- ========================================
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouseAnalytics')
BEGIN
    ALTER DATABASE DataWarehouseAnalytics SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouseAnalytics;
END;
GO

-- ========================================
-- Step 2: Create a fresh database
-- ========================================
CREATE DATABASE DataWarehouseAnalytics;
GO

USE DataWarehouseAnalytics;
GO

-- ========================================
-- Step 3: Create Schemas
-- ========================================
CREATE SCHEMA gold;
GO


-- ========================================
-- Step 4: Create Dimension and Fact Tables
-- ========================================

-- Customers Dimension
CREATE TABLE gold.dim_customers(
	customer_key INT,
	customer_id INT,
	customer_number NVARCHAR(50),
	first_name NVARCHAR(50),
	last_name NVARCHAR(50),
	country NVARCHAR(50),
	marital_status NVARCHAR(50),
	gender NVARCHAR(50),
	birthdate DATE,
	create_date DATE
);
GO

-- Products Dimension
CREATE TABLE gold.dim_products(
	product_key INT,
	product_id INT,
	product_number NVARCHAR(50),
	product_name NVARCHAR(50),
	category_id NVARCHAR(50),
	category NVARCHAR(50),
	subcategory NVARCHAR(50),
	maintenance NVARCHAR(50),
	cost INT,
	product_line NVARCHAR(50),
	start_date DATE
);
GO

-- Sales Fact Table
CREATE TABLE gold.fact_sales(
	order_number NVARCHAR(50),
	product_key INT,
	customer_key INT,
	order_date DATE,
	shipping_date DATE,
	due_date DATE,
	sales_amount INT,
	quantity TINYINT,
	price INT
);
GO


-- ========================================
-- Step 5: Load Data into Tables (from CSV)
-- ========================================

-- Load Customers
TRUNCATE TABLE gold.dim_customers;
GO
BULK INSERT gold.dim_customers
FROM 'C:\sql\sql-data-analytics-project\datasets\csv-files\gold.dim_customers.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO

-- Load Products
TRUNCATE TABLE gold.dim_products;
GO
BULK INSERT gold.dim_products
FROM 'C:\sql\sql-data-analytics-project\datasets\csv-files\gold.dim_products.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO

-- Load Fact Sales
TRUNCATE TABLE gold.fact_sales;
GO
BULK INSERT gold.fact_sales
FROM 'C:\sql\sql-data-analytics-project\datasets\csv-files\gold.fact_sales.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO


/*
===============================================================================
Summary:
    - Establishes a clean and structured Data Warehouse foundation.
    - Creates standardized schema and data loading pipeline.
    - Enables immediate analytical exploration upon completion.
===============================================================================
*/
