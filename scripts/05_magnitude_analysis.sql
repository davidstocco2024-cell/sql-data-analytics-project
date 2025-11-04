/*
===============================================================================
Magnitude Analysis
===============================================================================

Purpose:
    - Quantify data and group results by specific dimensions.
    - Understand data distribution across key categories.

SQL Functions Used:
    - Aggregate Functions: SUM(), COUNT(), AVG()
    - GROUP BY, ORDER BY

===============================================================================
*/

-- =============================================================================
-- 1. Total Customers by Country
-- =============================================================================
SELECT 
    c.[country],
    COUNT(c.[customer_key]) AS [total_customers]
FROM [gold].[dim_customers] AS c
GROUP BY 
    c.[country]
ORDER BY 
    [total_customers] DESC;


-- =============================================================================
-- 2. Total Customers by Gender
-- =============================================================================
SELECT 
    c.[gender],
    COUNT(c.[customer_key]) AS [total_customers]
FROM [gold].[dim_customers] AS c
GROUP BY 
    c.[gender]
ORDER BY 
    [total_customers] DESC;


-- =============================================================================
-- 3. Total Products by Category
-- =============================================================================
SELECT 
    p.[category],
    COUNT(p.[product_key]) AS [total_products]
FROM [gold].[dim_products] AS p
GROUP BY 
    p.[category]
ORDER BY 
    [total_products] DESC;


-- =============================================================================
-- 4. Average Product Cost per Category
-- =============================================================================
SELECT 
    p.[category],
    AVG(p.[cost]) AS [avg_cost]
FROM [gold].[dim_products] AS p
GROUP BY 
    p.[category]
ORDER BY 
    [avg_cost] DESC;


-- =============================================================================
-- 5. Total Revenue per Product Category
-- =============================================================================
SELECT 
    p.[category],
    SUM(f.[sales_amount]) AS [total_revenue]
FROM [gold].[fact_sales] AS f
LEFT JOIN [gold].[dim_products] AS p 
    ON p.[product_key] = f.[product_key]
GROUP BY 
    p.[category]
ORDER BY 
    [total_revenue] DESC;


-- =============================================================================
-- 6. Total Revenue by Customer
-- =============================================================================
SELECT 
    c.[customer_key],
    c.[first_name],
    c.[last_name],
    SUM(f.[sales_amount]) AS [total_revenue]
FROM [gold].[fact_sales] AS f
LEFT JOIN [gold].[dim_customers] AS c 
    ON c.[customer_key] = f.[customer_key]
GROUP BY 
    c.[customer_key],
    c.[first_name],
    c.[last_name]
ORDER BY 
    [total_revenue] DESC;


-- =============================================================================
-- 7. Distribution of Sold Items by Country
-- =============================================================================
SELECT 
    c.[country],
    SUM(f.[quantity]) AS [total_sold_items]
FROM [gold].[fact_sales] AS f
LEFT JOIN [gold].[dim_customers] AS c 
    ON c.[customer_key] = f.[customer_key]
GROUP BY 
    c.[country]
ORDER BY 
    [total_sold_items] DESC;
