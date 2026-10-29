-- Session 14 — S10Q4: Repeat Customer Revenue Share
-- Dataset: Brazilian E-Commerce (Olist)
-- Date: 2026-05-30

-- repeat customers (2+ orders): revenue = 3,053,841.92 AUD
WITH repeat_customers AS (
    SELECT
        customer_unique_id,
        COUNT(customer_unique_id) AS order_count,
        ROUND(SUM(price) + SUM(freight_value), 2) AS revenue
    FROM customers
    JOIN orders ON customers.customer_id = orders.customer_id
    JOIN order_items ON orders.order_id = order_items.order_id
    WHERE order_status = 'delivered'
    GROUP BY customer_unique_id
    HAVING COUNT(*) > 1
)
SELECT ROUND(SUM(revenue), 2) AS total_repeat_revenue
FROM repeat_customers;

-- one-time customers (1 order): revenue = 12,365,931.83 AUD
WITH one_time_customers AS (
    SELECT
        customer_unique_id,
        COUNT(customer_unique_id) AS order_count,
        ROUND(SUM(price) + SUM(freight_value), 2) AS revenue
    FROM customers
    JOIN orders ON customers.customer_id = orders.customer_id
    JOIN order_items ON orders.order_id = order_items.order_id
    WHERE order_status = 'delivered'
    GROUP BY customer_unique_id
    HAVING COUNT(*) = 1
)
SELECT ROUND(SUM(revenue), 2) AS total_one_time_revenue
FROM one_time_customers;

-- total revenue (all delivered orders): 15,843,553.24 AUD
SELECT ROUND(SUM(price) + SUM(freight_value), 2) AS total_revenue
FROM order_items;

-- percentages (calculated manually):
-- repeat:   (3,053,841.92  / 15,843,553.24) * 100 = 19.27%
-- one-time: (12,365,931.83 / 15,843,553.24) * 100 = 78.05%
-- gap:      2.68% (edge-case customer data mismatches)
