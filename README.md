# SQL Data Cleaning Project
Advanced SQL orders data cleaning in BigQuery, handling duplicate logic, string manipulation, and system NULL vs. text NULL resolution.

## Challenges Resolved:
- The "Fake" NULL: Identified and converted the string 'NULL' (text) into actual system NULLs using NULLIF().
- Name Stuttering: Cleaned names that were accidentally duplicated or formatted inconsistently (e.g., Ankit Patel, john smith, SARAH THOMPSON).
- Email Normalization: Cleaned broken email formats (like the @@ in row 2) and handled missing email values.
