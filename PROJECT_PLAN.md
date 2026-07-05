# AI-Powered Natural Language to SQL Query System

## 📌 Project Overview

This project is designed for **non-technical users** who need information from a database but have little or no knowledge of SQL or database concepts.

The application enables users to ask questions in **natural language**, and AI automatically converts those questions into SQL queries, executes them on the database, and returns the results—all without requiring any SQL skills.

## 🎯 Project Goal

Enable business users to retrieve data from a relational database using **Natural Language Processing (NLP)** powered by AI.

Instead of writing SQL queries, users simply ask questions in plain English, and the application generates and executes the appropriate SQL query.

## 👥 Target Audience

- Business Professionals
- Sales Teams
- Finance Teams
- Operations Teams
- Non-Technical End Users

## 🚀 Tech Stack

| Technology | Purpose |
|------------|---------|
| PostgreSQL | Database |
| Python | Backend Logic |
| SQL | Query Language |
| FastAPI *(or another LLM framework later)* | API Layer |
| Streamlit | Front-End UI |
| VS Code | Development Environment |
| GitHub | Version Control |

## 🔄 Execution Flow

```text
User Question
      │
      ▼
Python Backend
      │
      ▼
AI Generates SQL Query
      │
      ▼
PostgreSQL Executes SQL
      │
      ▼
Results Returned to User
```

## ✨ Key Features

- Ask questions in plain English
- AI-generated SQL queries
- No SQL knowledge required
- Fast and interactive user interface
- Secure database access
- Easy to extend with other LLMs in the future

## 🎯 Example

**User asks:**

> Show the top 10 customers by total sales this year.

**AI generates:**

```sql
SELECT customer_name,
       SUM(total_amount) AS total_sales
FROM fact_sales
WHERE order_date >= DATE_TRUNC('year', CURRENT_DATE)
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;
```

**Result:**

A table displaying the top 10 customers and their total sales.
