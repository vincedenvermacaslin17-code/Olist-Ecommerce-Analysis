-- Session 12 — S10Q2: Seller Performance Tiering
-- Dataset: Brazilian E-Commerce (Olist)
-- Date: 2026-05-28

-- run before query if timeout occurs
-- SET SESSION net_read_timeout = 600;
-- SET SESSION net_write_timeout = 600;

WITH revenue_per_seller AS (
    SELECT
        order_items.seller_id AS seller_id,
        ROUND(SUM(order_items.price) + SUM(order_items.freight_value), 2) AS revenue
    FROM order_items
    JOIN orders ON orders.order_id = order_items.order_id
    WHERE orders.order_status = 'delivered'
    GROUP BY order_items.seller_id
),
revenue_tiles AS (
    SELECT
        seller_id,
        revenue,
        NTILE(4) OVER (ORDER BY revenue) AS revenue_tiles
    FROM revenue_per_seller
),
average_review_score AS (
    SELECT
        sellers.seller_id AS seller_id,
        ROUND(AVG(review_score), 2) AS avg_score
    FROM order_reviews
    JOIN order_items ON order_reviews.order_id = order_items.order_id
    JOIN sellers ON order_items.seller_id = sellers.seller_id
    GROUP BY sellers.seller_id
)
SELECT
    average_review_score.seller_id,
    avg_score,
    revenue,
    CASE
        WHEN revenue_tiles = 4 THEN 'high_revenue'
        WHEN revenue_tiles = 3 THEN 'medium_revenue'
        WHEN revenue_tiles = 2 THEN 'medium_revenue'
        ELSE 'low_revenue'
    END AS revenue_tiers
FROM revenue_tiles
JOIN average_review_score ON revenue_tiles.seller_id = average_review_score.seller_id
ORDER BY revenue_tiers, avg_score DESC;
