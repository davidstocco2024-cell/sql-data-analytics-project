/*
===============================================================================
Change Over Time Analysis
===============================================================================

Purpose:
    - Track trends, growth, and changes in key metrics over time.
    - Perform time-series analysis and identify seasonality.
    - Measure growth or decline across specific periods.

SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()

===============================================================================
*/

-- =============================================================================
-- 1. Annual Sales Performance
-- =============================================================================
SELECT 
    YEAR([order_date]) AS [order_year],
    SUM([sales_amount]) AS [total_sales],
    COUNT(DISTINCT [customer_key]) AS [total_customers],
    SUM([quantity]) AS [total_quantity]
FROM [gold].[fact_sales]
WHERE [order_date] IS NOT NULL
GROUP BY 
    YEAR([order_date])
ORDER BY 
    [order_year] ASC;


-- =============================================================================
-- 2. Monthly Sales Performance by Year
-- =============================================================================
SELECT 
    YEAR([order_date]) AS [order_year],
    MONTH([order_date]) AS [order_month],
    SUM([sales_amount]) AS [total_sales],
    COUNT(DISTINCT [customer_key]) AS [total_customers],
    SUM([quantity]) AS [total_quantity]
FROM [gold].[fact_sales]
WHERE [order_date] IS NOT NULL
GROUP BY 
    YEAR([order_date]), 
    MONTH([order_date])
ORDER BY 
    [order_year], 
    [order_month];


-- =============================================================================
-- 3. Monthly Aggregation Using DATETRUNC()
-- =============================================================================
SELECT 
    DATETRUNC(MONTH, [order_date]) AS [order_date],
    SUM([sales_amount]) AS [total_sales],
    COUNT(DISTINCT [customer_key]) AS [total_customers],
    SUM([quantity]) AS [total_quantity]
FROM [gold].[fact_sales]
WHERE [order_date] IS NOT NULL
GROUP BY 
    DATETRUNC(MONTH, [order_date])
ORDER BY 
    [order_date] ASC;


-- =============================================================================
-- 4. Annual Aggregation Using DATETRUNC()
-- =============================================================================
SELECT 
    DATETRUNC(YEAR, [order_date]) AS [order_date],
    SUM([sales_amount]) AS [total_sales],
    COUNT(DISTINCT [customer_key]) AS [total_customers],
    SUM([quantity]) AS [total_quantity]
FROM [gold].[fact_sales]
WHERE [order_date] IS NOT NULL
GROUP BY 
    DATETRUNC(YEAR, [order_date])
ORDER BY 
    [order_date] ASC;


-- =============================================================================
-- 5. Monthly Trends Using FORMAT()
-- =============================================================================
SELECT 
    FORMAT([order_date], 'yyyy-MMM') AS [order_period],
    SUM([sales_amount]) AS [total_sales],
    COUNT(DISTINCT [customer_key]) AS [total_customers],
    SUM([quantity]) AS [total_quantity]
FROM [gold].[fact_sales]
WHERE [order_date] IS NOT NULL
GROUP BY 
    FORMAT([order_date], 'yyyy-MMM')
ORDER BY 
    [order_period] ASC;
