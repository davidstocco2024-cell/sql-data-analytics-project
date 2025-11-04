/*
===============================================================================
Database Exploration
===============================================================================
Purpose:
    - To explore the overall structure of the database and understand its schema.
    - To identify all available tables, their types, and key metadata.
    - To inspect detailed column information (data types, nullability, length) 
      for specific dimension or fact tables.

Tables Used:
    - INFORMATION_SCHEMA.TABLES
    - INFORMATION_SCHEMA.COLUMNS

SQL Functions Used:
    - Basic SELECT filtering
===============================================================================
*/

-- ========================================
-- Retrieve a list of all tables 
-- within the current database
-- ========================================
SELECT 
    TABLE_CATALOG, 
    TABLE_SCHEMA, 
    TABLE_NAME, 
    TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES;


-- ========================================
-- Retrieve column metadata for a specific table
-- Example: gold.dim_customers
-- ========================================
SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    IS_NULLABLE, 
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';


/*
===============================================================================
Summary:
    - Enables data engineers and analysts to audit database structures quickly.
    - Useful for validating schema definitions and column configurations.
    - Supports documentation and data governance processes.
===============================================================================
*/
