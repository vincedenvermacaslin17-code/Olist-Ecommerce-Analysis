-- Session 13 — S10Q3: Delivery Time Impact on Review Score
-- Dataset: Brazilian E-Commerce (Olist)
-- Date: 2026-05-29

SELECT
    ROUND(AVG(TIMESTAMPDIFF(DAY, order_purchase_timestamp, order_delivered_customer_date)), 2) AS delivery_days,
    order_reviews.review_score
FROM orders
JOIN order_reviews ON orders.order_id = order_reviews.order_id
WHERE order_status = 'delivered'
GROUP BY order_reviews.review_score
ORDER BY order_reviews.review_score DESC;
