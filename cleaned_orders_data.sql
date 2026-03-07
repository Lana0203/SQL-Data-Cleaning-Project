-- Final Cleaned Data

-- Step 1: Fix the names using email & customer_name as a unique identifier

WITH name_fixing AS (
  SELECT 
    REPLACE(LOWER(email), '@@', '@') AS ref_email,
    customer_name AS original_name, 
    STRING_AGG(
      CONCAT(UPPER(LEFT(word, 1)), 
      LOWER(SUBSTR(word, 2))), 
      ' ' ORDER BY offset
    ) AS fixed_name
  FROM (
    -- Get unique pairs of email and name to avoid "John John Smith Smith"
    SELECT DISTINCT email, customer_name 
    FROM `data-cleaning-sql-488109.cust_orders.orders`
  )
  CROSS JOIN
    UNNEST(SPLIT(customer_name, ' ')) AS word 
      WITH OFFSET AS offset
  GROUP BY email, customer_name
),

-- Step 2: Standardize the rest of the data

clean_data AS (
SELECT
  o.order_id,
  -- Use COALESCE to keep the original name if the join fails
  COALESCE(n.fixed_name, INITCAP(o.customer_name)) AS fixed_name,
  -- Use COALESCE to keep the original email (even if it's NULL) if the join fails
  COALESCE(n.ref_email, REPLACE(LOWER(o.email), '@@', '@')) AS ref_email,
  o.price,
  
  -- standardize order_status
  CASE 
    WHEN LOWER(TRIM(order_status)) LIKE "%delivered%" THEN "Delivered"
    WHEN LOWER(TRIM(order_status)) LIKE "%pending%" THEN "Pending"
    WHEN LOWER(TRIM(order_status)) LIKE "%shipped%" THEN "Shipped"
    WHEN LOWER(TRIM(order_status)) LIKE "%returned%" THEN "Returned"
    WHEN LOWER(TRIM(order_status)) LIKE "%refunded%" THEN "Refunded"
  END AS order_status,

  -- standardize product_name
  CASE 
    WHEN LOWER(TRIM(product_name)) LIKE "%samsung galaxy s22%" THEN "Samsung Galaxy S22"
    WHEN LOWER(TRIM(product_name)) LIKE "%apple watch%" THEN "Apple Watch"
    WHEN LOWER(TRIM(product_name)) LIKE "%google pixel%" THEN "Google Pixel"
    WHEN LOWER(TRIM(product_name)) LIKE "%iphone 14%" THEN "iPhone 14"
    WHEN LOWER(TRIM(product_name)) LIKE "%macbook pro%" THEN "MacBook Pro"
  END AS product_name,

  -- standardize quantity
  CASE
    WHEN LOWER(CAST(quantity AS STRING)) = 'two' THEN 2
    ELSE CAST(quantity AS INT64)
  END AS quantity,

  -- standardize order_date
  CAST(
    CASE
      WHEN order_date LIKE '%/20__' THEN 
        CONCAT(SUBSTR(order_date, 7,4), '-', SUBSTR(order_date,1,2), '-', SUBSTR(order_date,4,2))
      WHEN order_date LIKE '20__/%' THEN REPLACE(order_date, '/', '-')
    ELSE order_date
    END AS DATE) AS order_date,

  -- standardize country
  CASE 
    WHEN LOWER(country) IN ('usa', 'us') THEN 'United States'
    WHEN LOWER(country) IN ('united kingdom', 'uk') THEN 'United Kingdom'
  ELSE CONCAT(UPPER(LEFT(country,1)), LOWER(SUBSTR(country,2)))
  END AS country

FROM `data-cleaning-sql-488109.cust_orders.orders` AS o
-- Joining using both email and customer name for a secure connection
LEFT JOIN name_fixing AS n 
  ON REPLACE(LOWER(o.email), '@@', '@') = n.ref_email 
  AND o.customer_name = n.original_name
),

-- Identify duplicate rows
deduplicated_data AS (
SELECT 
  *,
  ROW_NUMBER() OVER 
  (
    PARTITION BY 
      order_date, 
      product_name, 
      ref_email
      ORDER BY order_id
  ) AS rn
FROM clean_data
)

-- Final output
SELECT 
  order_id,
-- Convert string 'NULL' into a real NULL
  CASE WHEN LOWER(fixed_name) = 'null' 
    THEN NULL ELSE fixed_name END AS customer_name,
  CASE WHEN LOWER(ref_email) = 'null' 
    THEN NULL ELSE ref_email END AS email,
  order_date,
  CASE WHEN LOWER(product_name) = 'null' 
    THEN NULL ELSE product_name END AS product_name,
  quantity,
  price,
  CASE WHEN LOWER(country) = 'null' 
    THEN NULL ELSE country END AS country,
  CASE WHEN LOWER(order_status) = 'null' 
    THEN NULL ELSE order_status END AS order_status
FROM deduplicated_data
WHERE rn = 1;
