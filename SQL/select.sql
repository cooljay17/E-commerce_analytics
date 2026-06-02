SELECT COUNT(*) FROM customer;
SELECT COUNT(*) FROM fact_sales;

SELECT
    d.month,
    SUM(f.total_amount) AS revenue
FROM fact_sales f
JOIN dim_date d
    ON f.order_date = d.full_date
GROUP BY d.month
ORDER BY d.month;