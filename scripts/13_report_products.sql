/*
===============================================================================
Product Report
===============================================================================
Purpose:
    - Consolidates key product metrics and performance indicators.

Highlights:
    1. Retrieves essential product attributes such as name, category, subcategory, and cost.
    2. Segments products by revenue into High-Performer, Mid-Range, and Low-Performer tiers.
    3. Aggregates product-level metrics:
        - Total orders
        - Total sales
        - Total quantity sold
        - Total unique customers
        - Lifespan (in months)
    4. Calculates KPIs:
        - Recency (months since last sale)
        - Average Order Revenue (AOR)
        - Average Monthly Revenue
===============================================================================
*/

-- =============================================================================
-- Create Report View: gold.report_products
-- =============================================================================

IF OBJECT_ID('gold.report_products', 'V') IS NOT NULL
    DROP VIEW gold.report_products;
GO

CREATE VIEW gold.report_products AS

/* ============================================================================
1) Base Query: Retrieve core columns from fact_sales and dim_products
============================================================================ */
WITH base_query AS (
    SELECT
        f.order_number,
        f.order_date,
        f.customer_key,
        f.sales_amount,
        f.quantity,
        p.product_key,
        p.product_name,
        p.category,
        p.subcategory,
        p.cost
    FROM gold.fact_sales AS f
    LEFT JOIN gold.dim_products AS p
        ON f.product_key = p.product_key
    WHERE f.order_date IS NOT NULL
),

/* ============================================================================
2) Product Aggregation: Summarize key metrics at the product level
============================================================================ */
product_aggregations AS (
    SELECT
        product_key,
        product_name,
        category,
        subcategory,
        cost,
        DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan,
        MAX(order_date) AS last_sale_date,
        COUNT(DISTINCT order_number) AS total_orders,
        COUNT(DISTINCT customer_key) AS total_customers,
        SUM(sales_amount) AS total_sales,
        SUM(quantity) AS total_quantity,
        ROUND(AVG(CAST(sales_amount AS FLOAT) / NULLIF(quantity, 0)), 1) AS avg_selling_price
    FROM base_query
    GROUP BY
        product_key,
        product_name,
        category,
        subcategory,
        cost
)

/* ============================================================================
3) Final Output: Combine aggregated data and calculate KPIs
============================================================================ */
SELECT 
    product_key,
    product_name,
    category,
    subcategory,
    cost,
    last_sale_date,
    DATEDIFF(MONTH, last_sale_date, GETDATE()) AS recency_in_months,
    CASE
        WHEN total_sales > 50000 THEN 'High-Performer'
        WHEN total_sales >= 10000 THEN 'Mid-Range'
        ELSE 'Low-Performer'
    END AS product_segment,
    lifespan,
    total_orders,
    total_sales,
    total_quantity,
    total_customers,
    avg_selling_price,
    CASE 
        WHEN total_orders = 0 THEN 0
        ELSE total_sales / total_orders
    END AS avg_order_revenue, -- Average Order Revenue (AOR)
    CASE
        WHEN lifespan = 0 THEN total_sales
        ELSE total_sales / lifespan
    END AS avg_monthly_revenue  -- Average Monthly Revenue
FROM product_aggregations;
GO
