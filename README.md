# 🧹 SQL Data Cleaning: Customer Orders
This project focuses on cleaning and standardizing a messy customer orders dataset using **Google BigQuery**. The goal was to transform inconsistent, manual-entry data into a structured format suitable for analysis.

---

## 🛠️ Key Cleaning Tasks
* **Advanced Name Standardization**: Used a **CTE** with `STRING_AGG` and `UNNEST` to fix casing and remove duplicate words in customer names.
* **Email Normalization**: Resolved syntax errors (like **'@@'**) and standardized all emails to lowercase.
* **Inconsistent Entry Resolution**: Converted text-based numbers (e.g., **'two'**) into integers and standardized country variations like **'USA/US'** to **'United States'**.
* **Date Parsing & Casting**: Transformed multiple string date formats into a single, consistent **DATE** column.
* **Handling 'Pseudo-NULLs'**: Used `CASE` statements to convert the literal string **'NULL'** into actual system **NULL** values across all columns.
* **Deduplication**: Implemented `ROW_NUMBER()` with `PARTITION BY` to identify and remove redundant order records.

---

## 📂 Project Structure
* **`cleaning_script.sql`**: The full BigQuery script containing the cleaning logic.
* **`data/`**: Folder containing the raw messy CSV and the final cleaned output.
