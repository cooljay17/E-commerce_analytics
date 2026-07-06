# Tables Documentation

This document explains the database schema used in the **AI-Powered Natural Language to SQL Query System**.

The project consists of two database designs:

1. **OLTP (Online Transaction Processing) Schema**
2. **Star Schema (Data Warehouse)**

The OLTP schema stores normalized transactional data, while the Star Schema is optimized for analytical reporting and AI-generated SQL queries.

---

# Project Database Architecture

```text
                    Source Database (OLTP)
                  ──────────────────────────

        customer ─────┐
                      │
                      │
        orders ───────┼────── order_items ───── products
                      │
                      │
               Transactional Data


                        │
                        │ ETL / ELT
                        ▼


                Data Warehouse (Star Schema)
             ─────────────────────────────────

          dim_customer
                │
                │
dim_products ─ fact_sales ─ dim_date

```

---

# 1. OLTP Schema (`oltp_tables.sql`)

## Purpose

The OLTP schema is designed for **day-to-day business operations**.

It stores normalized transactional data including:

- Customers
- Products
- Orders
- Order Items

This schema minimizes data redundancy and ensures data consistency.

---

## Database

```
ecommerce_ai_dw
```

Database Encoding:

- UTF-8

Owner:

- postgres

---

# Tables

## Customer Table

Stores customer information.

| Column | Type | Description |
|---------|------|-------------|
| customer_id | BIGSERIAL | Primary Key |
| customer_name | VARCHAR(100) | Customer Name |
| email | VARCHAR(150) | Unique Email Address |
| city | VARCHAR(100) | Customer City |

### Constraints

- Primary Key
- Unique Email
- NOT NULL on name and email

---

## Products Table

Stores product details.

| Column | Type | Description |
|---------|------|-------------|
| product_id | BIGSERIAL | Primary Key |
| product_name | VARCHAR(150) | Product Name |
| category | VARCHAR(100) | Product Category |
| price | NUMERIC(10,2) | Product Price |

### Constraints

- Price cannot be negative

---

## Orders Table

Stores customer orders.

| Column | Type | Description |
|---------|------|-------------|
| order_id | BIGSERIAL | Primary Key |
| customer_id | BIGINT | Customer Reference |
| order_date | TIMESTAMP | Order Timestamp |

### Relationships

```
Customer
    │
    └────── Orders
```

### Foreign Key

```
customer_id
    ↓
customer.customer_id
```

### Cascade Rule

If a customer is deleted,

➡️ All their orders are automatically deleted.

---

## Order Items Table

Stores products purchased in each order.

| Column | Type | Description |
|---------|------|-------------|
| order_id | BIGINT | Order Reference |
| product_id | BIGINT | Product Reference |
| quantity | INTEGER | Number of Items |
| price | NUMERIC(10,2) | Price at Purchase |

### Composite Primary Key

```
(order_id, product_id)
```

### Relationships

```
Orders
   │
   └──── Order Items ───── Products
```

### Foreign Keys

- order_id → orders
- product_id → products

### Delete Rules

Orders

```
ON DELETE CASCADE
```

Deleting an order automatically removes its order items.

Products

```
ON DELETE RESTRICT
```

A product cannot be deleted if it exists in any order.

---

# OLTP Relationships

```text
customer
   │
   │ 1
   │
   ▼
orders
   │
   │ 1
   │
   ▼
order_items
   ▲
   │
   │ Many
products
```

---

# OLTP Indexes

| Index | Table | Purpose |
|--------|-------|----------|
| idx_orders_customer_id | orders | Faster customer order lookup |
| idx_orderitems_product_id | order_items | Faster product searches |

---

# Why Normalized?

The OLTP schema is normalized to:

- Reduce duplicate data
- Improve consistency
- Simplify updates
- Support transactional workloads
- Maintain referential integrity

---

# 2. Star Schema (`star_schema.sql`)

## Purpose

The Star Schema is designed for:

- Business Intelligence
- Reporting
- Dashboarding
- AI-generated SQL queries
- Data Analytics

Unlike the OLTP schema, it is **denormalized** for faster analytical queries.

---

# Star Schema Design

```text
              dim_customer
             +-------------+
             | customer_id |
             | customer    |
             | city        |
             +------+------+
                    |
                    |
                    |
+-------------+  +--v--------+  +-------------+
|dim_products |  |fact_sales |  | dim_date    |
+-------------+  +-----------+  +-------------+
|product_id   |  |customer_id|  |date_id      |
|product_name |  |product_id |  |full_date    |
|category     |  |date_id    |  |month        |
+-------------+  |quantity   |  |year         |
                 |amount     |  |quarter      |
                 +-----------+  +-------------+
```

---

# Dimension Tables

Dimension tables provide descriptive information for business analysis.

---

## dim_customer

Stores customer details.

| Column | Description |
|---------|-------------|
| customer_id | Customer Identifier |
| customer_name | Customer Name |
| city | Customer City |

---

## dim_products

Stores product information.

| Column | Description |
|---------|-------------|
| product_id | Product Identifier |
| product_name | Product Name |
| category | Product Category |

---

## dim_date

Stores calendar information.

| Column | Description |
|---------|-------------|
| date_id | Date Key |
| full_date | Actual Date |
| month | Month Number |
| year | Year |
| quarter | Quarter |

### Constraints

- Month must be between 1 and 12
- Quarter must be between 1 and 4
- full_date must be unique

---

# Fact Table

## fact_sales

Stores measurable business data.

| Column | Description |
|---------|-------------|
| customer_id | Customer Reference |
| product_id | Product Reference |
| date_id | Date Reference |
| quantity | Items Sold |
| total_amount | Sales Revenue |

### Measures

- Quantity Sold
- Total Revenue

### Foreign Keys

- dim_customer
- dim_products
- dim_date

---

# Star Schema Relationships

```text
             dim_customer
                    │
                    │
                    ▼
               fact_sales
              ▲     │     ▲
              │     │     │
              │     │     │
      dim_products   dim_date
```

Each dimension has a **one-to-many** relationship with the fact table.

---

# Star Schema Indexes

| Index | Purpose |
|--------|----------|
| idx_fact_sales_customer | Customer analytics |
| idx_fact_sales_product | Product analytics |
| idx_fact_sales_date | Time-based queries |
| idx_dim_date_year_month | Monthly & yearly reporting |

---

# Why Use a Star Schema?

Compared to the OLTP schema, the Star Schema offers:

- Faster aggregation queries
- Simpler SQL joins
- Optimized reporting
- Better dashboard performance
- Improved AI-generated SQL accuracy
- Efficient OLAP workloads

---

# OLTP vs Star Schema

| Feature | OLTP | Star Schema |
|---------|------|-------------|
| Purpose | Transaction Processing | Analytics & Reporting |
| Design | Normalized | Denormalized |
| Data | Operational | Historical & Analytical |
| Query Type | Insert, Update, Delete | Read-Heavy |
| Joins | Multiple | Minimal |
| Performance | Optimized for Transactions | Optimized for Aggregations |
| Users | Applications | Business Users, Analysts, AI Systems |

---

# Data Flow

```text
Customer places an Order
            │
            ▼
      OLTP Database
            │
            ▼
      ETL / ELT Process
            │
            ▼
     Star Schema Warehouse
            │
            ▼
 AI Natural Language → SQL
            │
            ▼
 Business Reports & Dashboards
```

---

# Summary

This project follows a modern data warehousing architecture:

- **OLTP Schema** captures transactional business operations in a normalized structure.
- **Star Schema** transforms the operational data into an analytics-friendly model optimized for reporting, dashboards, and AI-powered Natural Language to SQL applications.

This layered architecture mirrors real-world enterprise data platforms and provides a scalable foundation for business intelligence and advanced analytics.
