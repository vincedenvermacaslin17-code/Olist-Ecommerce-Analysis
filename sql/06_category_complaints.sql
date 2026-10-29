-- Session 15 — S10Q5: Product Category Profitability vs. Complaint Rate
-- Dataset: Brazilian E-Commerce (Olist)
-- Date: 2026-05-31

SELECT
    product_category_name,
    ROUND(SUM(price) + SUM(freight_value), 2) AS revenue,
    ROUND(SUM(CASE WHEN review_score <= 2 THEN 1 ELSE 0 END) / COUNT(review_score) * 100, 2) AS complaint_rate
FROM order_items
JOIN products ON order_items.product_id = products.product_id
JOIN order_reviews ON order_items.order_id = order_reviews.order_id
GROUP BY product_category_name
ORDER BY complaint_rate DESC;

-- correlation between revenue and complaint_rate = -0.044 (Excel CORR function)
-- near-zero: no meaningful linear relationship between revenue and complaint rate
