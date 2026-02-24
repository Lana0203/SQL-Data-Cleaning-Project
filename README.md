# SQL Data Cleaning Project
Advanced SQL orders data cleaning in BigQuery, handling duplicate logic, string manipulation, and system NULL vs. text NULL resolution.

## Challenges Resolved:
- Identified and converted the string 'NULL' (text) into actual system NULLs.
- Standardized customer and product names that were accidentally duplicated or formatted inconsistently (e.g., john smith=John Smith, Iphone 14=iPhone 14 ).
- Email Normalization: Cleaned broken email formats (like the @@ in row 2) and handled missing email values.
- Fixed date format on the order_date column to one consistent format and casted column type from STRING to DATE.
- Fixed one string for a number ("two") on the quantity column to the actual number 2 and casted column type from STRING to INT.
- Removed duplicate orders.
