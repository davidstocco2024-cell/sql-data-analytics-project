/*
===============================================================================
Cumulative Analysis
===============================================================================

Purpose:
    - Calculate running totals or moving averages for key metrics.
    - Track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()

===============================================================================
*/

-- =============================================================================
-- 1. Running Total and Moving Average of Sales Over Time
-- =============================================================================
SELECT
    t.[order_date],
    t.[total_sales],
    SUM(t.[total_sales]) OVER (ORDER BY t.[order_date]) AS [running_total_sales],
    AVG(t.[avg_price]) OVER (ORDER BY t.[order_date]) AS [moving_average_price]
FROM (
    SELECT 
        DATETRUNC(YEAR, [order_date]) AS [order_date],
        SUM([sales_amount]) AS [total_sales],
        AVG([price]) AS [avg_price]
    FROM [gold].[fact_sales]
    WHERE [order_date] IS NOT NULL
    GROUP BY 
        DATETRUNC(YEAR, [order_date])
) AS t
ORDER BY 
    t.[order_date] ASC;
