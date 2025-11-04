/*
===============================================================================
Category Sales Contribution Analysis
===============================================================================
Purpose:
    - Identify which product categories contribute the most to total sales.
    - Calculate each category's share of overall sales.
    - Provide insights for strategic product and marketing decisions.

SQL Techniques Used:
    - Common Table Expression (CTE)
    - Aggregate functions: SUM(), ROUND(), CAST()
    - Window function for total sales calculation
    - CONCAT() for formatted percentage output
===============================================================================
*/

-- =========================
-- Category Sales Analysis
-- =========================
WITH category_sales AS (
    SELECT 
        p.category,
        SUM(f.sales_amount) AS total_sales
    FROM gold.fact_sales AS f
    LEFT JOIN gold.dim_products AS p 
        ON p.product_key = f.product_key
    WHERE f.sales_amount IS NOT NULL
    GROUP BY p.category
)
SELECT 
    category,
    total_sales,
    SUM(total_sales) OVER () AS overall_sales,
    CONCAT(
        ROUND(
            (CAST(total_sales AS FLOAT) / SUM(total_sales) OVER()) * 100, 2 ), '%') AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC;
