/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - Calculates high-level business metrics for performance assessment.
    - Provides a quick overview of sales, orders, products, and customers.
    - Identifies key aggregates to track company-wide performance trends.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/

-- =============================================================================
-- 1) Total Sales
-- =============================================================================
SELECT 
    SUM(sales_amount) AS total_sales
FROM gold.fact_sales;
GO

-- =============================================================================
-- 2) Total Quantity of Items Sold
-- =============================================================================
SELECT 
    SUM(quantity) AS total_quantity
FROM gold.fact_sales;
GO

-- =============================================================================
-- 3) Average Selling Price
-- =============================================================================
SELECT 
    AVG(price) AS avg_price
FROM gold.fact_sales;
GO

-- =============================================================================
-- 4) Total Number of Orders
-- =============================================================================
SELECT 
    COUNT(order_number) AS total_orders -- Includes duplicates
FROM gold.fact_sales;
GO

-- Use DISTINCT to ensure unique order count
SELECT 
    COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales;
GO

-- =============================================================================
-- 5) Total Number of Products
-- =============================================================================
SELECT 
    COUNT(DISTINCT product_name) AS total_products
FROM gold.dim_products;
GO

-- =============================================================================
-- 6) Total Number of Customers
-- =============================================================================
SELECT 
    COUNT(customer_key) AS total_customers
FROM gold.dim_customers;
GO

-- =============================================================================
-- 7) Total Number of Customers Who Placed an Order
-- =============================================================================
SELECT 
    COUNT(DISTINCT customer_key) AS total_customers
FROM gold.fact_sales;
GO

-- =============================================================================
-- 8) Consolidated Metrics Report
-- =============================================================================
-- This query unifies all the above measures into a single result set.
-- Ideal for dashboards, executive summaries, or data validation.
SELECT 
    'Total Sales' AS measure_name, 
    SUM(sales_amount) AS measure_value 
FROM gold.fact_sales

UNION ALL

SELECT 
    'Total Quantity', 
    SUM(quantity) 
FROM gold.fact_sales

UNION ALL

SELECT 
    'Average Price', 
    AVG(price) 
FROM gold.fact_sales

UNION ALL

SELECT 
    'Total Orders', 
    COUNT(DISTINCT order_number) 
FROM gold.fact_sales

UNION ALL

SELECT 
    'Total Products', 
    COUNT(DISTINCT product_name) 
FROM gold.dim_products

UNION ALL

SELECT 
    'Total Customers', 
    COUNT(DISTINCT customer_key) 
FROM gold.fact_sales;
GO
