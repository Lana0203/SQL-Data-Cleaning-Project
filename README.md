# 🧹 SQL Data Cleaning: Customer Orders
This project focuses on cleaning and standardizing a messy customer orders dataset using **Google BigQuery**. The goal was to transform inconsistent, manual-entry data into a structured format suitable for analysis.

---

## 🛠️ Key Cleaning Tasks

* **`Granular Name Standardization`**: Implemented a **custom Title Case logic** using a **CTE** with `STRING_AGG` and `UNNEST`.
  
* **`1NF Transformation`**: Temporarily flattened full name strings into **First Normal Form (1NF)** to isolate and fix individual words (handling casing and special characters) before re-aggregating them into a clean, standardized format.

* **`Email Domain Correction`**: Standardized all emails to **lowercase** and used `REPLACE` to resolve specific syntax errors like **'@@'**.
  
* **`Data Type Harmonization`**: Converted **text-based numbers** (e.g., 'two') into integers and unified geographical variations like **'USA/US'** into the standard **'United States'**.
  
* **`Conditional Date Reformatting`**: Used a `CASE` statement with `SUBSTR` and `CONCAT` to manually restructure inconsistent date strings (e.g., MM/DD/YYYY to YYYY-MM-DD) before performing a final `CAST` to **DATE** type.
  
* **`Handling 'Pseudo-NULLs'`**: Applied `CASE` statement logic to identify and convert the literal string **'NULL'** into **true system NULL values** to ensure accurate analytical results.
  
* **`Advanced Deduplication`**: Utilized the `ROW_NUMBER()` **window function** with `PARTITION BY` to identify and remove redundant records, ensuring a unique **"Source of Truth"** for every order.
---

### **📁 Repository Files**

* **`cleaned_orders_data.sql`**: The full BigQuery script containing the cleaning logic.
* **`orders_dataset`**: The raw orders csv file
