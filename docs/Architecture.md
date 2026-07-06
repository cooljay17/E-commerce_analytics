# AI-Powered Natural Language to SQL System Architecture

## Overview

This project demonstrates how **Artificial Intelligence (AI)** enables non-technical users to retrieve business insights from a database using plain English instead of writing SQL queries.

The system translates natural language questions into SQL, executes them against a PostgreSQL data warehouse, and returns meaningful business results.

---

# Business Problem

Many business users need data to make informed decisions, but they often lack SQL knowledge.

Common users include:

- Business Analysts
- Sales Managers
- Finance Teams
- Marketing Teams
- Operations Managers
- Executives

Typical questions they ask include:

- "What was our revenue last month?"
- "Who are our top customers?"
- "Which product category is performing best?"
- "Show me sales by city."
- "What is the average order value this month?"

Traditionally, answering these questions requires:

1. Understanding the database schema
2. Writing SQL queries
3. Joining multiple tables
4. Aggregating and filtering data

This dependency on technical teams can slow down decision-making.

---

# Proposed Solution

The solution is an **AI-powered Natural Language to SQL system**.

Instead of writing SQL, users simply ask questions in plain English.

The AI model:

1. Understands the user's intent.
2. Identifies the relevant business entities.
3. Generates the appropriate SQL query.
4. Executes the query on the PostgreSQL data warehouse.
5. Returns the results in an easy-to-understand format.

This approach allows business users to access data independently without SQL expertise.

---

# System Architecture

```text
                 Business User
                       │
                       │
        Natural Language Question
                       │
                       ▼
        AI Natural Language Processor
        (Python + Large Language Model)
                       │
                       │
             Generates SQL Query
                       │
                       ▼
               PostgreSQL Database
                (Star Schema)
                       │
                       ▼
              Query Execution Engine
                       │
                       ▼
               Business Results
                       │
                       ▼
          Tables • Charts • Dashboards
```

---

# Technology Stack

## Database

**PostgreSQL**

PostgreSQL stores both the transactional (OLTP) data and the analytical Star Schema used for reporting.

Responsibilities:

- Store business data
- Execute SQL queries
- Return query results efficiently

---

## Programming Language

**Python**

Python serves as the application's backend.

Responsibilities include:

- Accepting user input
- Connecting to PostgreSQL
- Sending prompts to the AI model
- Executing generated SQL
- Formatting and returning results
- Handling errors and validation

---

## AI Layer

The AI component converts natural language into SQL by leveraging the database schema and business context.

Example:

**User Prompt**

> Show me the top five customers by revenue.

**Generated SQL**

```sql
SELECT
    c.customer_name,
    SUM(f.total_amount) AS revenue
FROM fact_sales f
JOIN dim_customer c
    ON f.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY revenue DESC
LIMIT 5;
```

The user never needs to see or write SQL.

---

# Database Architecture

The project follows a two-layer database architecture.

```text
          OLTP Database
─────────────────────────────────

customer
products
orders
order_items

        │
        │ ETL
        ▼

     Star Schema
─────────────────────────────────

dim_customer
dim_products
dim_date
fact_sales
```

### OLTP Layer

The OLTP database captures day-to-day business transactions.

Examples:

- Customer registration
- Product management
- Order creation
- Order item details

---

### Data Warehouse Layer

The Star Schema organizes data for analytics.

It is optimized for:

- Reporting
- Dashboards
- Aggregations
- AI-generated SQL

---

# Supported Business Queries

The system can answer questions such as:

| Business Question | Example Insight |
|-------------------|-----------------|
| What is the monthly revenue? | Revenue trend by month |
| Who are our top customers? | Highest revenue-generating customers |
| Which product category performs best? | Category-wise revenue |
| Which products sell the most? | Top-selling products |
| What is the average order value? | Customer spending trends |
| Which city generates the most revenue? | Regional performance |
| What is our quarterly revenue? | Quarterly financial summary |
| How fast is revenue growing? | Month-over-month growth |
| Which customer is the best in each city? | Top customer by region |
| How is each product performing? | Product performance dashboard |

These questions correspond to predefined analytical SQL queries but can be asked naturally through the AI interface.

---

# End-to-End Workflow

```text
Business User
      │
      ▼
Ask Question in English
      │
      ▼
Python Backend
      │
      ▼
AI Generates SQL
      │
      ▼
Execute SQL in PostgreSQL
      │
      ▼
Retrieve Results
      │
      ▼
Display Business Insights
```

---

# Benefits

The architecture provides several advantages:

- Eliminates the need for SQL knowledge.
- Empowers business users with self-service analytics.
- Reduces dependency on technical teams.
- Accelerates decision-making.
- Leverages an optimized Star Schema for fast analytical queries.
- Provides a scalable foundation for future AI-driven reporting.

---

# Future Enhancements

The next phase of the project will introduce a **Streamlit** frontend to improve usability.

Planned features include:

- User-friendly web interface
- Natural language input box
- AI-generated SQL display (optional)
- Interactive result tables
- Charts and visualizations
- Downloadable reports (CSV/Excel)
- Query history
- Authentication and user roles
- Support for additional AI models

---

# Conclusion

This architecture combines **PostgreSQL**, **Python**, and **Artificial Intelligence** to create a Natural Language to SQL solution that bridges the gap between business users and data.

By enabling users to ask questions in plain English and receive accurate analytical insights, the system simplifies data access, improves productivity, and supports faster, data-driven decision-making.
