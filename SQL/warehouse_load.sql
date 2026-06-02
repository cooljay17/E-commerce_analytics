-- Insert data into dimension and fact tables

INSERT INTO dim_customer (
    customer_id,
    customer_name,
    city
)
SELECT
    customer_id,
    customer_name,
    city
FROM customer;

-----------
INSERT INTO dim_products (
    product_id,
    product_name,
    category,
    price
)
SELECT
    product_id,
    product_name,
    category,
    price
FROM products;

---
INSERT INTO dim_date (
    full_date,
    day,
    month,
    year,
    quarter
)
SELECT DISTINCT
    order_date,
    EXTRACT(DAY FROM order_date),
    EXTRACT(MONTH FROM order_date),
    EXTRACT(YEAR FROM order_date),
    EXTRACT(QUARTER FROM order_date)
FROM orders;

----

INSERT INTO fact_sales (
    customer_id,
    product_id,
    order_date,
    quantity,
    total_amount
)
SELECT
    dc.customer_id,
    dp.product_id,
    dd.full_date,
    oi.quantity,
    oi.quantity * oi.price
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
JOIN dim_customer dc
    ON o.customer_id = dc.customer_id
JOIN dim_products dp
    ON oi.product_id = dp.product_id
JOIN dim_date dd
    ON o.order_date = dd.full_date;