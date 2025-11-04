/*
===============================================================================
Yearly Product Performance Analysis
===============================================================================

Purpose:
    - Analyze the yearly performance of each product.
    - Compare yearly sales against the product’s average sales performance.
    - Perform year-over-year (YoY) comparison to detect growth or decline.

SQL Functions Used:
    - Window Functions: AVG() OVER(), LAG() OVER()
    - Conditional Logic: CASE WHEN
    - Aggregate Function: SUM()
===============================================================================
*/

-- =============================================================================
-- 1. Calculate Yearly Product Sales
-- =============================================================================
WITH yearly_product_sales AS (
    SELECT 
        YEAR(f.[order_date]) AS [order_year],
        p.[product_name],
        SUM(f.[sales_amount]) AS [current_sales]
    FROM [gold].[fact_sales] AS f
    LEFT JOIN [gold].[dim_products] AS p
        ON f.[product_key] = p.[product_key]
    WHERE f.[order_date] IS NOT NULL
    GROUP BY 
        YEAR(f.[order_date]),
        p.[product_name]
)

-- =============================================================================
-- 2. Compare Sales vs. Product Average and Previous Year
-- =============================================================================
SELECT 
    yps.[order_year],
    yps.[product_name],
    yps.[current_sales],

    -- Compare with average sales for this product
    AVG(yps.[current_sales]) OVER (PARTITION BY yps.[product_name]) AS [avg_sales],
    yps.[current_sales] - AVG(yps.[current_sales]) OVER (PARTITION BY yps.[product_name]) AS [diff_avg],
    CASE 
        WHEN yps.[current_sales] - AVG(yps.[current_sales]) OVER (PARTITION BY yps.[product_name]) > 0 THEN 'Above Avg'
        WHEN yps.[current_sales] - AVG(yps.[current_sales]) OVER (PARTITION BY yps.[product_name]) < 0 THEN 'Below Avg'
        ELSE 'Avg'
    END AS [avg_change],

    -- Year-over-Year Analysis
    LAG(yps.[current_sales]) OVER (PARTITION BY yps.[product_name] ORDER BY yps.[order_year]) AS [py_sales],
    yps.[current_sales] - LAG(yps.[current_sales]) OVER (PARTITION BY yps.[product_name] ORDER BY yps.[order_year]) AS [diff_py],
    CASE 
        WHEN yps.[current_sales] - LAG(yps.[current_sales]) OVER (PARTITION BY yps.[product_name] ORDER BY yps.[order_year]) > 0 THEN 'Increase'
        WHEN yps.[current_sales] - LAG(yps.[current_sales]) OVER (PARTITION BY yps.[product_name] ORDER BY yps.[order_year]) < 0 THEN 'Decrease'
        ELSE 'No Change'
    END AS [py_change]

FROM [yearly_product_sales] AS yps
ORDER BY 
    yps.[product_name],
    yps.[order_year];
