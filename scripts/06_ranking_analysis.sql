/*
===============================================================================
Ranking Analysis
===============================================================================

Purpose:
    - Rank items (e.g., products, customers) based on performance or other metrics.
    - Identify top performers and underperformers.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY

===============================================================================
*/

-- =============================================================================
-- 1. Top 5 Products Generating the Highest Revenue (Simple Ranking)
-- =============================================================================
SELECT TOP (5)
    p.[product_name],
    SUM(f.[sales_amount]) AS [total_revenue]
FROM [gold].[fact_sales] AS f
LEFT JOIN [gold].[dim_products] AS p
    ON p.[product_key] = f.[product_key]
GROUP BY 
    p.[product_name]
ORDER BY 
    [total_revenue] DESC;


-- =============================================================================
-- 2. Top 5 Subcategories Generating the Highest Revenue
-- =============================================================================
SELECT TOP (5)
    p.[subcategory],
    SUM(f.[sales_amount]) AS [total_revenue]
FROM [gold].[fact_sales] AS f
LEFT JOIN [gold].[dim_products] AS p
    ON p.[product_key] = f.[product_key]
GROUP BY 
    p.[subcategory]
ORDER BY 
    [total_revenue] DESC;


-- =============================================================================
-- 3. Top 5 Products by Revenue Using Window Functions
-- =============================================================================
SELECT 
    t.[product_name],
    t.[total_revenue],
    t.[rank_products]
FROM (
    SELECT  
        p.[product_name],
        SUM(f.[sales_amount]) AS [total_revenue],
        ROW_NUMBER() OVER (ORDER BY SUM(f.[sales_amount]) DESC) AS [rank_products]
    FROM [gold].[fact_sales] AS f
    LEFT JOIN [gold].[dim_products] AS p
        ON p.[product_key] = f.[product_key]
    GROUP BY 
        p.[product_name]
) AS t
WHERE 
    t.[rank_products] <= 5
ORDER BY 
    t.[rank_products];


-- =============================================================================
-- 4. 5 Worst-Performing Products by Revenue
-- =============================================================================
SELECT TOP (5)
    p.[product_name],
    SUM(f.[sales_amount]) AS [total_revenue]
FROM [gold].[fact_sales] AS f
LEFT JOIN [gold].[dim_products] AS p
    ON p.[product_key] = f.[product_key]
GROUP BY 
    p.[product_name]
ORDER BY 
    [total_revenue] ASC;


-- =============================================================================
-- 5. Top 10 Customers Generating the Highest Revenue
-- =============================================================================
SELECT TOP (10)
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
-- 6. 3 Customers with the Fewest Orders Placed
-- =============================================================================
SELECT TOP (3)
    c.[customer_key],
    c.[first_name],
    c.[last_name],
    COUNT(DISTINCT f.[order_number]) AS [total_orders]
FROM [gold].[fact_sales] AS f
LEFT JOIN [gold].[dim_customers] AS c
    ON c.[customer_key] = f.[customer_key]
GROUP BY 
    c.[customer_key],
    c.[first_name],
    c.[last_name]
ORDER BY 
    [total_orders] ASC;
