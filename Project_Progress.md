# 🛒 AI-Powered E-Commerce Data Warehouse

An end-to-end mini data warehouse project that combines:

- 📊 Data Modeling  
- 🗄️ PostgreSQL  
- ⭐ Star Schema Design  
- 🤖 AI-generated SQL Queries  
- ⚡ FastAPI Backend  
- 🖥️ Streamlit Frontend  

This project simulates a real-world analytics platform where users can ask business questions in natural language and receive data-driven insights from a warehouse model.

---

# 🚀 Project Goal

The goal of this project is to build an:

> **AI-powered analytics system using a Star Schema data warehouse**

Users can ask questions like:

- "Top 5 products by revenue"
- "Monthly sales trend"
- "Top customers by sales"

The system converts natural language into SQL queries and retrieves results from PostgreSQL.

---

# 🧠 Day 1 — Problem Framing + Schema Design

## 🎯 Objective

Think like a **Data Modeler** instead of only a developer.

---

## 📌 Business Scenario

Designed an **E-commerce Analytics System** for analyzing:

- Customer purchases
- Product sales
- Revenue trends
- Business performance

---

# ❓ Business Questions

The schema was designed to support queries such as:

- Top 5 products by revenue
- Monthly revenue trends
- Top customers by spend
- Sales by category
- Orders per day

---

# 🧱 OLTP Schema (Normalized Design)

Created a transactional schema using normalization principles (3NF).

## Tables

### 👤 customers
Stores customer details.

### 📦 products
Stores product information and pricing.

### 🧾 orders
Stores order header details.

### 🛒 order_items
Stores product-level transaction details.

---

# 🔗 OLTP Relationships

- customer → orders (1:M)
- orders → order_items (1:M)
- products → order_items (1:M)

---

# ⭐ Star Schema Design

Converted the normalized schema into a dimensional warehouse model optimized for analytics.

---

## 📊 Fact Table

### fact_sales
Stores measurable business metrics.

Columns include:
- quantity
- total_amount

---

## 📐 Dimension Tables

### dim_customer
Customer descriptive attributes.

### dim_product
Product descriptive attributes.

### dim_date
Date hierarchy for reporting and aggregation.

---

# 🔄 OLTP to Star Schema Mapping

| OLTP Table  | Star Schema |
|-------------|-------------|
| order_items | fact_sales |
| customers   | dim_customer |
| products    | dim_product |
| orders      | dim_date |

---

# 💡 Design Decisions

- Used normalization to reduce redundancy
- Used star schema for analytical query performance
- Designed dimensions for filtering and grouping
- Designed fact table for aggregations and metrics

---

# 🗓️ Day 2 — Database Setup + Table Creation

## 🎯 Objective

Transform the schema design into a working PostgreSQL database.

---

# 🛠️ Technology Stack

| Tool | Purpose |
|------|---------|
| PostgreSQL | Database |
| SQL | Schema creation |
| GitHub | Version control |
| draw.io / dbdiagram | Data modeling |

---

# 🗄️ Database Setup

Created database:

```sql
CREATE DATABASE ecommerce_ai_dw;
```

---

# 🧱 Tables Created

## OLTP Tables
- customer
- products
- orders
- order_items

## Star Schema Tables
- dim_customer
- dim_products
- dim_date
- fact_sales

---

# 🔐 Constraints Added

Implemented:

- Primary Keys
- Foreign Keys
- Referential Integrity

Examples:
- orders.customer_id → customers.customer_id
- fact_sales.product_id → dim_product.product_id

---

# 📂 Project Structure

```text
E-commerce_analytics/
│
├── sql/
│   ├── oltp_tables.sql
│   ├── star_schema.sql
│
├── diagrams/
│   ├── oltp.png
│   ├── olap.png
│
├── ER_Files/
│   ├── Analytical.drawio
│   ├── oltp.drawio
|
├── README.md
```

---

# 📚 Key Learnings

## Day 1
- Business-driven schema design
- Normalization concepts
- Star schema modeling
- OLTP vs OLAP understanding

## Day 2
- PostgreSQL setup
- Table creation
- PK/FK relationships
- Warehouse table implementation

---

# 🗓️ Day 3 — Data Generation & Warehouse Loading

## 🎯 Objective

Populate the E-commerce Data Warehouse with realistic sample data and prepare the environment for analytical querying.

---

# 🛠️ Data Generation

Generated realistic sample data to simulate an e-commerce business environment.

## Dataset Coverage

### 👤 customer

Generated customer information including:

* Customer ID
* Customer Name
* Email Address
* City

### 📦 products

Generated product catalog containing:

* Product ID
* Product Name
* Category
* Price

### 🧾 orders

Generated order transactions with:

* Customer References
* Order Dates

### 🛒 order_items

Generated detailed sales transactions:

* Product References
* Quantity
* Unit Price

---

# 📊 Dataset Statistics

| Entity      | Approximate Records |
| ----------- | ------------------- |
| Customers   | 1,000               |
| Products    | 100                 |
| Orders      | 5,000               |
| Order Items | 10,000+             |

---

# 🔄 ETL & Data Warehouse Loading

Performed transformation from OLTP tables into the dimensional model.

## Dimension Population

Loaded:

* dim_customer
* dim_products
* dim_date

## Fact Population

Loaded:

* fact_sales

Calculated metrics:

* Quantity Sold
* Total Revenue

---

# 🔗 Data Flow

```text
customer      ──► dim_customer

products       ──► dim_products

orders         ──► dim_date

order_items    ──► fact_sales
```

---

# 📚 Key Learnings

* Sample data generation
* Data validation
* ETL fundamentals
* OLTP to OLAP transformation
* Fact and Dimension loading strategies

---

# 🗓️ Day 4 — Analytics SQL Development

## 🎯 Objective

Develop analytical SQL queries on the Star Schema to answer business questions and generate actionable insights.

---

# 📊 Analytics Layer

Built reporting queries using:

* fact_sales
* dim_customer
* dim_products
* dim_date

---

# 💰 Revenue Analytics

Implemented queries for:

* Total Revenue
* Revenue by Month
* Revenue by Quarter
* Revenue by Year

---

# 👤 Customer Analytics

Implemented queries for:

* Top Customers by Revenue
* Customer Purchase Frequency
* Average Customer Spend

---

# 📦 Product Analytics

Implemented queries for:

* Top Selling Products
* Revenue by Category
* Product Performance Analysis

---

# 📅 Sales Trend Analytics

Implemented queries for:

* Daily Sales Trends
* Monthly Sales Trends
* Seasonal Sales Patterns

---

# ❓ Business Questions Answered

### Revenue

* What is the monthly revenue trend?
* Which quarter generated the highest revenue?

### Customer

* Who are the top customers by spend?
* Which customers place the most orders?

### Product

* Which products generate the highest revenue?
* Which product categories perform best?

### Operations

* How many orders are placed daily?
* What are the seasonal sales trends?

---

# 📂 Repository Enhancements

Added:

```text
sql/
│
├── oltp_tables.sql
├── star_schema.sql
├── warehouse_load.sql
├── analytics_queries.sql
```

---

# 📚 Key Learnings

## Day 3

* Data generation techniques
* ETL design fundamentals
* Data warehouse loading process
* Fact and dimension population

## Day 4

* Dimensional query design
* Aggregation techniques
* Business intelligence reporting
* Star schema optimization
* Analytical SQL development

---

