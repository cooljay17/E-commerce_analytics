# Business Logic Documentation

This document explains the **business purpose** behind the SQL scripts used in the project.

The SQL scripts are divided into two categories:

1. **warehouse_load.sql** – Loads transactional data from the OLTP database into the Data Warehouse (Star Schema).
2. **analytics_queries.sql** – Business Intelligence (BI) queries used for reporting, dashboards, and AI-generated insights.

---

# 1. warehouse_load.sql

## Purpose

The operational (OLTP) database is optimized for processing customer transactions. However, it is not ideal for analytical reporting because it requires multiple joins and stores highly normalized data.

The **warehouse_load.sql** script performs the ETL (Extract, Transform, Load) process by moving cleaned and transformed data into the Star Schema. This enables faster reporting and simplifies analytical queries.

---

## Business Process

```text
Customer Places Orders
           │
           ▼
   OLTP Database
(Customer, Orders,
 Products, Order_Items)
           │
           │
   ETL / Warehouse Load
           │
           ▼
 Star Schema Warehouse
           │
           ▼
 Analytics & AI Queries
```

---

## Step 1 – Load Customer Dimension

### Business Purpose

Customer information is copied into the **Customer Dimension** so customer attributes can be analyzed independently of transactional data.

### Business Value

Enables analysis such as:

- Revenue by customer
- Customer segmentation
- City-wise customer analysis
- Customer purchase behavior

---

## Step 2 – Load Product Dimension

### Business Purpose

Product master data is loaded into the Product Dimension.

### Business Value

Supports reporting like:

- Product performance
- Category-wise sales
- Best-selling products
- Product profitability

---

## Step 3 – Build Date Dimension

### Business Purpose

Instead of storing raw timestamps in reports, the ETL process creates a reusable calendar dimension containing:

- Day
- Month
- Year
- Quarter

### Business Value

Enables users to easily answer questions such as:

- Monthly sales
- Quarterly growth
- Year-over-year comparisons
- Seasonal trends

---

## Step 4 – Populate Fact Sales

### Business Purpose

The Fact table combines information from multiple operational tables into a single analytical dataset.

The ETL joins:

- Customers
- Orders
- Products
- Order Items
- Date Dimension

It also calculates the business metric:

```text
Total Amount = Quantity × Price
```

### Business Value

The Fact table becomes the central source for all sales analytics and dashboards.

---

## Overall ETL Flow

```text
Customer
      │
Orders
      │
Order Items
      │
Products
      │
───────────────
       │
 ETL Transformation
       │
       ▼
Fact Sales
```

---

# 2. analytics_queries.sql

## Purpose

This script contains analytical SQL queries used by business users, management teams, dashboards, and AI assistants to answer common business questions.

---

# Query 1 – Revenue by Month

### Business Question

**How much revenue did the company generate each month?**

### Business Value

Used by:

- Finance Team
- Executive Dashboard
- Monthly Business Reviews

Helps identify:

- Revenue trends
- Seasonal demand
- Growth patterns

---

# Query 2 – Top 5 Customers by Revenue

### Business Question

**Who are the company's highest-value customers?**

### Business Value

Supports:

- Customer loyalty programs
- VIP customer identification
- Account management
- Personalized marketing

---

# Query 3 – Sales by Product Category

### Business Question

**Which product categories generate the highest revenue?**

### Business Value

Helps management decide:

- Inventory planning
- Marketing priorities
- Product expansion
- Category investments

---

# Query 4 – Daily Sales Trend

### Business Question

**How does revenue change day by day?**

### Business Value

Useful for monitoring:

- Daily business performance
- Promotional campaigns
- Holiday sales
- Operational planning

---

# Query 5 – Top 10 Products by Revenue

### Business Question

**Which products generate the highest sales revenue?**

### Business Value

Supports:

- Product ranking
- Inventory optimization
- Pricing decisions
- Marketing focus

---

# Query 6 – Top Selling Products by Quantity

### Business Question

**Which products sell the most units?**

### Business Value

Identifies:

- Fast-moving inventory
- High-demand products
- Stock replenishment priorities

Note that the highest-selling products by quantity are not always the highest-revenue products.

---

# Query 7 – Average Order Value by Month

### Business Question

**What is the average customer spending per order each month?**

### Business Value

Measures customer purchasing behavior.

Useful for:

- Upselling strategies
- Cross-selling effectiveness
- Marketing campaign evaluation

---

# Query 8 – Customer Count by City

### Business Question

**Which cities have the most customers?**

### Business Value

Supports:

- Regional marketing
- Store expansion planning
- Customer distribution analysis

---

# Query 9 – Revenue by City

### Business Question

**Which cities contribute the most revenue?**

### Business Value

Helps determine:

- High-performing markets
- Sales territory performance
- Regional investment opportunities

---

# Query 10 – Quarterly Revenue

### Business Question

**How much revenue was generated each quarter?**

### Business Value

Used in:

- Quarterly Business Reviews (QBRs)
- Executive reporting
- Financial planning

---

# Query 11 – Revenue Contribution by Category

### Business Question

**What percentage of total revenue comes from each product category?**

### Business Value

Shows the importance of each product category in the overall business.

Useful for:

- Portfolio analysis
- Strategic planning
- Product diversification

---

# Query 12 – Month-over-Month Revenue Growth

### Business Question

**How much did revenue grow or decline compared to the previous month?**

### Business Value

Measures business growth.

Positive values indicate growth, while negative values indicate declining performance.

Useful for:

- KPI dashboards
- Executive reporting
- Trend analysis

---

# Query 13 – Running Revenue Trend

### Business Question

**How much cumulative revenue has the business generated over time?**

### Business Value

Provides a running total of revenue.

Useful for:

- Annual targets
- Revenue milestones
- Performance tracking

---

# Query 14 – Best Customer per City

### Business Question

**Who is the highest-revenue customer in each city?**

### Business Value

Supports:

- Regional customer engagement
- Premium customer recognition
- Sales team planning

---

# Query 15 – Product Performance Dashboard

### Business Question

**How is each product performing overall?**

The query combines multiple business metrics:

- Units Sold
- Total Revenue
- Average Sale Value

### Business Value

This query is ideal for executive dashboards because it provides a complete performance summary for every product.

It supports:

- Product lifecycle management
- Inventory planning
- Sales optimization
- Pricing strategy

---

# Business KPIs Covered

The analytics script calculates several key performance indicators (KPIs), including:

| KPI | Business Purpose |
|------|------------------|
| Total Revenue | Overall business performance |
| Monthly Revenue | Revenue trends over time |
| Quarterly Revenue | Financial reporting |
| Daily Revenue | Operational monitoring |
| Top Customers | Customer relationship management |
| Product Revenue | Product performance |
| Units Sold | Inventory planning |
| Average Order Value | Customer spending analysis |
| Revenue by Category | Product portfolio analysis |
| Revenue by City | Regional performance |
| Customer Distribution | Market analysis |
| Revenue Growth | Business growth measurement |
| Running Revenue | Progress toward sales targets |

---

# Overall Business Workflow

```text
Customer Purchases Products
            │
            ▼
      OLTP Database
            │
            ▼
   ETL (warehouse_load.sql)
            │
            ▼
     Star Schema Warehouse
            │
            ▼
 analytics_queries.sql
            │
            ▼
Business Dashboards
Management Reports
AI Natural Language Queries
Executive Decision Making
```

---

# Summary

The project follows a complete analytics pipeline:

1. **Operational Data Capture** – Customer orders are recorded in the normalized OLTP database.
2. **Data Warehouse Loading** – The ETL process transforms and loads transactional data into a Star Schema optimized for analytics.
3. **Business Analytics** – SQL queries generate meaningful KPIs, trends, and performance metrics.
4. **AI-Powered Insights** – These analytical queries form the foundation for Natural Language to SQL systems, enabling non-technical users to retrieve business insights using plain English.
