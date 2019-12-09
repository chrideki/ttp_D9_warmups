--find the total sales ($$) and number of orders per month in the database (northwind).
-- don't worry about months with no sales.

SELECT
    to_char(order_date, 'Month') AS month,
    SUM(unit_price * quantity * (1-discount)) || ' $' AS tot_sales,
    COUNT(DISTINCT order_id) AS tot_orders
FROM orders
JOIN order_details USING(order_id)
GROUP BY month
ORDER BY tot_sales;



-- Which month has the highest average sales ($$) over every year of the database?
--(hint you can either start from scratch or make use of the previous answer)

WITH month_sales AS(
    SELECT
        to_char(order_date, 'Month') AS month,
        SUM(unit_price * quantity * (1-discount)) AS tot_sales,
        COUNT(DISTINCT order_id) AS tot_orders
    FROM orders
    JOIN order_details USING(order_id)
    GROUP BY month
    ORDER BY tot_sales
) SELECT
        month,
        tot_sales / tot_orders || ' $' AS avg_sales
    FROM month_sales
    ORDER BY avg_sales DESC;
