/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - Segment products into cost ranges and count how many products fall into each segment.
    - Group customers based on spending behavior and purchasing history.
    - Provide insights for pricing strategy and customer relationship management.

SQL Techniques Used:
    - Common Table Expressions (CTEs)
    - CASE expressions for conditional grouping
    - Aggregate functions: SUM(), COUNT(), MIN(), MAX()
    - DATEDIFF() for calculating customer lifespan
===============================================================================
*/

-- =========================
-- Product Segmentation
-- =========================
WITH product_segments AS (
    SELECT 
        product_key,
        product_name,
        cost,
        CASE
            WHEN cost < 100 THEN 'Below 100'
            WHEN cost BETWEEN 100 AND 500 THEN '100-500'
            WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
            ELSE 'Above 1000'
        END AS cost_range
    FROM gold.dim_products
)
SELECT 
    cost_range,
    COUNT(product_key) AS total_products
FROM product_segments
GROUP BY cost_range
ORDER BY total_products DESC;


-- =========================
-- Customer Segmentation
-- =========================
/*
Segments:
    - VIP: Customers with at least 12 months of history and total spending > 5000
    - Regular: Customers with at least 12 months of history and total spending <= 5000
    - New: Customers with less than 12 months of history
*/
WITH customer_spending AS (
    SELECT 
        c.customer_key,
        SUM(f.sales_amount) AS total_spending,
        MIN(f.order_date) AS first_order,
        MAX(f.order_date) AS last_order,
        DATEDIFF(MONTH, MIN(f.order_date), MAX(f.order_date)) AS lifespan
    FROM gold.fact_sales AS f
    LEFT JOIN gold.dim_customers AS c
        ON f.customer_key = c.customer_key
    WHERE f.order_date IS NOT NULL
    GROUP BY c.customer_key
)
SELECT 
    customer_segment,
    COUNT(customer_key) AS total_customers
FROM (
    SELECT 
        customer_key,
        CASE 
            WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
            WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'Regular'
            ELSE 'New'
        END AS customer_segment
    FROM customer_spending
) AS t
GROUP BY customer_segment
ORDER BY total_customers DESC;
