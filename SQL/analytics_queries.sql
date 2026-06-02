-- =====================================================
-- 1. Revenue by Month
-- =====================================================

SELECT
    d.year,
    d.month,
    SUM(f.total_amount) AS revenue
FROM fact_sales f
JOIN dim_date d
    ON f.order_date = d.full_date
GROUP BY d.year, d.month
ORDER BY d.year, d.month;

-- =====================================================
-- 2. Top 5 Customers by Revenue
-- =====================================================

SELECT
    c.customer_name,
    SUM(f.total_amount) AS revenue
FROM fact_sales f
JOIN dim_customer c
    ON f.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY revenue DESC
LIMIT 5;

-- =====================================================
-- 3. Sales by Product Category
-- =====================================================

SELECT
    p.category,
    SUM(f.total_amount) AS revenue
FROM fact_sales f
JOIN dim_products p
    ON f.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;

-- =====================================================
-- 4. Daily Sales Trend
-- =====================================================

SELECT
    d.full_date,
    SUM(f.total_amount) AS revenue
FROM fact_sales f
JOIN dim_date d
    ON f.order_date = d.full_date
GROUP BY d.full_date
ORDER BY d.full_date;

-- =====================================================
-- 5. Top 10 Products by Revenue
-- =====================================================

SELECT
    p.product_name,
    SUM(f.total_amount) AS revenue
FROM fact_sales f
JOIN dim_products p
    ON f.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 10;

-- =====================================================
-- 6. Top Selling Products by Quantity
-- =====================================================

SELECT
    p.product_name,
    SUM(f.quantity) AS total_quantity
FROM fact_sales f
JOIN dim_products p
    ON f.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC
LIMIT 10;

-- =====================================================
-- 7. Average Order Value by Month
-- =====================================================

SELECT
    d.year,
    d.month,
    ROUND(AVG(f.total_amount),2) AS avg_order_value
FROM fact_sales f
JOIN dim_date d
    ON f.order_date = d.full_date
GROUP BY d.year, d.month
ORDER BY d.year, d.month;

-- =====================================================
-- 8. Customer Count by City
-- =====================================================

SELECT
    city,
    COUNT(*) AS customer_count
FROM dim_customer
GROUP BY city
ORDER BY customer_count DESC;

-- =====================================================
-- 9. Revenue by City
-- =====================================================

SELECT
    c.city,
    SUM(f.total_amount) AS revenue
FROM fact_sales f
JOIN dim_customer c
    ON f.customer_id = c.customer_id
GROUP BY c.city
ORDER BY revenue DESC;

-- =====================================================
-- 10. Quarterly Revenue
-- =====================================================

SELECT
    d.year,
    d.quarter,
    SUM(f.total_amount) AS revenue
FROM fact_sales f
JOIN dim_date d
    ON f.order_date = d.full_date
GROUP BY d.year, d.quarter
ORDER BY d.year, d.quarter;

-- =====================================================
-- 11. Revenue Contribution by Category (%)
-- =====================================================

SELECT
    p.category,
    ROUND(
        SUM(f.total_amount) * 100.0 /
        SUM(SUM(f.total_amount)) OVER (),
        2
    ) AS revenue_percentage
FROM fact_sales f
JOIN dim_products p
    ON f.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue_percentage DESC;

-- =====================================================
-- 12. Month-over-Month Revenue Growth
-- =====================================================

WITH monthly_sales AS (
    SELECT
        d.year,
        d.month,
        SUM(f.total_amount) AS revenue
    FROM fact_sales f
    JOIN dim_date d
        ON f.order_date = d.full_date
    GROUP BY d.year, d.month
)
SELECT
    year,
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY year, month) AS prev_month_revenue,
    ROUND(
        ((revenue - LAG(revenue) OVER (ORDER BY year, month))
        / NULLIF(LAG(revenue) OVER (ORDER BY year, month),0))*100,
        2
    ) AS growth_pct
FROM monthly_sales;

-- =====================================================
-- 13. Running Revenue Trend
-- =====================================================

SELECT
    d.full_date,
    SUM(f.total_amount) AS daily_revenue,
    SUM(SUM(f.total_amount))
        OVER (ORDER BY d.full_date)
        AS running_revenue
FROM fact_sales f
JOIN dim_date d
    ON f.order_date = d.full_date
GROUP BY d.full_date
ORDER BY d.full_date;

-- =====================================================
-- 14. Best Customer per City
-- =====================================================

WITH customer_revenue AS (
    SELECT
        c.city,
        c.customer_name,
        SUM(f.total_amount) AS revenue,
        ROW_NUMBER() OVER (
            PARTITION BY c.city
            ORDER BY SUM(f.total_amount) DESC
        ) AS rn
    FROM fact_sales f
    JOIN dim_customer c
        ON f.customer_id = c.customer_id
    GROUP BY c.city, c.customer_name
)
SELECT *
FROM customer_revenue
WHERE rn = 1;

-- =====================================================
-- 15. Product Performance Dashboard Query
-- =====================================================

SELECT
    p.product_name,
    p.category,
    SUM(f.quantity) AS units_sold,
    SUM(f.total_amount) AS revenue,
    ROUND(AVG(f.total_amount),2) AS avg_sale_value
FROM fact_sales f
JOIN dim_products p
    ON f.product_id = p.product_id
GROUP BY
    p.product_name,
    p.category
ORDER BY revenue DESC;