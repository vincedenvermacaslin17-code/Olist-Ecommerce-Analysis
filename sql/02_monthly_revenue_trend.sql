-- Session 11 — S10Q1: Monthly Revenue Trend with Month-over-Month Growth Rate
-- Dataset: Brazilian E-Commerce (Olist)
-- Date: 2026-05-28

WITH total_price_and_freight AS
(
    SELECT
        SUM(order_items.price)    AS total_price,
        SUM(freight_value)        AS total_freight,
        DATE_FORMAT(orders.order_purchase_timestamp, '%Y-%m') AS `Year-Month`
    FROM order_items
    JOIN orders ON order_items.order_id = orders.order_id
    WHERE order_status = 'delivered'
    GROUP BY `Year-Month`
),
revenue_per_month AS
(
    SELECT
        `Year-Month`,
        ROUND((total_price + total_freight), 2) AS revenue
    FROM total_price_and_freight
)
SELECT
    `Year-Month`,
    revenue,
    LAG(revenue) OVER (ORDER BY `Year-Month`)                                                                                AS last_month_revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY `Year-Month`))
        / LAG(revenue) OVER (ORDER BY `Year-Month`) * 100,
    2)                                                                                                                       AS growth_rate
FROM revenue_per_month
ORDER BY `Year-Month`;
