/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore and validate the structure and content of dimension tables.
    - To ensure data consistency and identify available categorical hierarchies.
    - Useful for data profiling and quality checks before analysis.

SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/

-- ========================================
-- Retrieve a list of unique countries 
-- from which customers originate
-- ========================================
SELECT DISTINCT 
    country 
FROM gold.dim_customers
ORDER BY country;


-- ========================================
-- Retrieve a list of unique categories, 
-- subcategories, and products
-- ========================================
SELECT DISTINCT 
    category, 
    subcategory, 
    product_name 
FROM gold.dim_products
ORDER BY category, subcategory, product_name;


/*
===============================================================================
Summary:
    - Provides an overview of categorical dimensions for customers and products.
    - Supports the creation of filters, hierarchies, and dimensions in analytics.
    - Ensures data completeness and helps detect potential duplicates.
===============================================================================
*/
