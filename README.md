🧹 Advanced SQL Data Cleaning: Customer Orders
This project demonstrates advanced data engineering techniques using Google BigQuery to transform a highly "noisy" raw dataset into a clean, analysis-ready source of truth.

📌 Project Overview
The raw customer_orders table contained significant data integrity issues, including inconsistent data types, manual entry errors, and systemic "Pseudo-NULLs" (text strings posing as null values).

🛠️ Challenges & Technical Solutions
1. Data Type & Schema Enforcement
Pseudo-NULL Resolution: Developed logic to identify and convert the string 'NULL' (text) into actual System NULLs, ensuring accurate counts and aggregate calculations.

Type Casting:

Converted order_date from STRING to DATE after standardizing inconsistent date formats.

Fixed "Human-Entry" errors (e.g., converting the word "two" to the integer 2) and casted the quantity column to INT.

2. String Manipulation & Normalization
Entity Standardization: Used INITCAP and TRIM functions to consolidate duplicates caused by casing (e.g., "john smith" vs. "John Smith") and branding inconsistencies (e.g., "Iphone 14" vs. "iPhone 14").

Email Validation: Cleaned broken email formats (fixing issues like @@) and normalized the email field to lowercase for consistent user identification.

3. De-duplication & Integrity
Row-Level De-duplication: Implemented logic to identify and remove redundant order entries based on unique transaction keys, ensuring the final dataset reflects actual sales volume.

📂 Project Structure
cleaning_script.sql: The full BigQuery SQL script.

raw_data_sample.csv: A sample of the messy data before cleaning.

clean_data_sample.csv: The final output after script execution.
