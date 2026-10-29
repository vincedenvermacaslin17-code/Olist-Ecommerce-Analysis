-- Session 10 — Brazilian E-Commerce: Data Cleaning
-- Date: 2026-05-25
-- Dataset: Olist (9 tables)

-- ============================================================
-- 1. ROW COUNTS
-- ============================================================
SELECT COUNT(*) FROM customers;                         -- 99441
SELECT COUNT(*) FROM geolocation;                       -- 1000163
SELECT COUNT(*) FROM order_items;                       -- 112650
SELECT COUNT(*) FROM order_payments;                    -- 103886
SELECT COUNT(*) FROM order_reviews;                     -- 99224
SELECT COUNT(*) FROM orders;                            -- 99224
SELECT COUNT(*) FROM product_category_name_translation; -- 71
SELECT COUNT(*) FROM products;                          -- 32951
SELECT COUNT(*) FROM sellers;                           -- 3095

-- ============================================================
-- 2. NULL CHECKS
-- ============================================================

# customers
SELECT
	SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) customer_id_nulls,
	SUM(CASE WHEN customer_unique_id IS NULL THEN 1 ELSE 0 END) customer_unique_id_nulls,
	SUM(CASE WHEN customer_zip_code_prefix IS NULL THEN 1 ELSE 0 END) customer_zip_code_prefix_nulls,
    SUM(CASE WHEN customer_city IS NULL THEN 1 ELSE 0 END) customer_city_nulls,
    SUM(CASE WHEN customer_state IS NULL THEN 1 ELSE 0 END) customer_state_nulls
FROM customers;
-- all 0

# geolocation
SELECT
	SUM(CASE WHEN geolocation_zip_code_prefix IS NULL THEN 1 ELSE 0 END) geolocation_zip_code_prefix_nulls,
    SUM(CASE WHEN geolocation_lat IS NULL THEN 1 ELSE 0 END) geolocation_lat_nulls,
    SUM(CASE WHEN geolocation_lng IS NULL THEN 1 ELSE 0 END) geolocation_lng_nulls,
    SUM(CASE WHEN geolocation_city IS NULL THEN 1 ELSE 0 END) geolocation_city_nulls,
    SUM(CASE WHEN geolocation_state IS NULL THEN 1 ELSE 0 END) geolocation_state_nulls
FROM geolocation;
-- all 0

# order_items
SELECT
	SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) order_id_nulls,
    SUM(CASE WHEN order_item_id IS NULL THEN 1 ELSE 0 END) order_item_id_nulls,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) product_id_nulls,
    SUM(CASE WHEN seller_id IS NULL THEN 1 ELSE 0 END) seller_id_nulls,
    SUM(CASE WHEN shipping_limit_date IS NULL THEN 1 ELSE 0 END) shipping_limit_date_nulls,
    SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) price_nulls,
    SUM(CASE WHEN freight_value IS NULL THEN 1 ELSE 0 END) freight_value_nulls
FROM order_items;
-- all 0

# order_payments
SELECT
	SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) order_id_nulls,
    SUM(CASE WHEN payment_sequential IS NULL THEN 1 ELSE 0 END) payment_sequential_nulls,
    SUM(CASE WHEN payment_type IS NULL THEN 1 ELSE 0 END) payment_type_nulls,
    SUM(CASE WHEN payment_installments IS NULL THEN 1 ELSE 0 END) payment_installments_nulls,
    SUM(CASE WHEN payment_value IS NULL THEN 1 ELSE 0 END) payment_value_nulls
FROM order_payments;
-- all 0

# order_reviews
SELECT
	SUM(CASE WHEN review_id IS NULL THEN 1 ELSE 0 END) review_id_nulls,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) order_id_nulls,
    SUM(CASE WHEN review_score IS NULL THEN 1 ELSE 0 END) review_score_nulls,
    SUM(CASE WHEN review_comment_title IS NULL THEN 1 ELSE 0 END) review_comment_title_nulls,           -- 87656 (88.34%)
    SUM(CASE WHEN review_comment_message IS NULL THEN 1 ELSE 0 END) review_comment_message_nulls,       -- 58247 (58.70%)
    SUM(CASE WHEN review_creation_date IS NULL THEN 1 ELSE 0 END) review_creation_date_nulls,
    SUM(CASE WHEN review_answer_timestamp IS NULL THEN 1 ELSE 0 END) review_answer_timestamp_nulls,
	ROUND((SUM(CASE WHEN review_comment_title IS NULL THEN 1 ELSE 0 END)/COUNT(*))*100,2) AS review_comment_title_nulls_percentage,
	ROUND((SUM(CASE WHEN review_comment_message IS NULL THEN 1 ELSE 0 END)/COUNT(*))*100,2) AS review_comment_message_nulls_percentage
FROM order_reviews;

# orders
SELECT
	SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) order_id_nulls,
	SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) customer_id_nulls,
	SUM(CASE WHEN order_status IS NULL THEN 1 ELSE 0 END) order_status_nulls,
    SUM(CASE WHEN order_purchase_timestamp IS NULL THEN 1 ELSE 0 END) order_purchase_timestamp_nulls,
    SUM(CASE WHEN order_approved_at IS NULL THEN 1 ELSE 0 END) order_approved_at_nulls,                         -- 160 (0.16%)
    SUM(CASE WHEN order_delivered_carrier_date IS NULL THEN 1 ELSE 0 END) order_delivered_carrier_date_nulls,   -- 1783
    SUM(CASE WHEN order_delivered_customer_date IS NULL THEN 1 ELSE 0 END) order_delivered_customer_date_nulls, -- 2965 (2.98%)
    SUM(CASE WHEN order_estimated_delivery_date IS NULL THEN 1 ELSE 0 END) order_estimated_delivery_date_nulls,
	ROUND((SUM(CASE WHEN order_approved_at IS NULL THEN 1 ELSE 0 END)/COUNT(*))*100,2) AS order_approved_at_nulls_percentage,
    ROUND((SUM(CASE WHEN order_delivered_carrier_date IS NULL THEN 1 ELSE 0 END)/COUNT(*))*100,2) AS order_delivered_carrier_date_nulls_percentage,
    ROUND((SUM(CASE WHEN order_delivered_customer_date IS NULL THEN 1 ELSE 0 END)/COUNT(*))*100,2) AS order_delivered_customer_date_nulls_percentage
FROM orders;

# product_category_name_translation
SELECT
	SUM(CASE WHEN product_category_name IS NULL THEN 1 ELSE 0 END) product_category_name_nulls,
    SUM(CASE WHEN product_category_name_english IS NULL THEN 1 ELSE 0 END) product_category_name_english_nulls
FROM product_category_name_translation;
-- all 0

# products
SELECT
	SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) product_id_nulls,
    SUM(CASE WHEN product_category_name IS NULL THEN 1 ELSE 0 END) product_category_name_nulls,         -- 610 (1.85%)
    SUM(CASE WHEN product_name_lenght IS NULL THEN 1 ELSE 0 END) product_name_lenght_nulls,             -- 610
	SUM(CASE WHEN product_description_lenght IS NULL THEN 1 ELSE 0 END) product_description_lenght_nulls, -- 610
    SUM(CASE WHEN product_photos_qty IS NULL THEN 1 ELSE 0 END) product_photos_qty_nulls,               -- 610
    SUM(CASE WHEN product_weight_g IS NULL THEN 1 ELSE 0 END) product_weight_g_nulls,                   -- 2
    SUM(CASE WHEN product_length_cm IS NULL THEN 1 ELSE 0 END) product_length_cm_nulls,                 -- 2
    SUM(CASE WHEN product_height_cm IS NULL THEN 1 ELSE 0 END) product_height_cm_nulls,                 -- 2
    SUM(CASE WHEN product_width_cm IS NULL THEN 1 ELSE 0 END) product_width_cm_nulls                    -- 2
FROM products;

# sellers
SELECT
	SUM(CASE WHEN seller_id IS NULL THEN 1 ELSE 0 END) seller_id_nulls,
    SUM(CASE WHEN seller_zip_code_prefix IS NULL THEN 1 ELSE 0 END) seller_zip_code_prefix_nulls,
    SUM(CASE WHEN seller_city IS NULL THEN 1 ELSE 0 END) seller_city_nulls,
    SUM(CASE WHEN seller_state IS NULL THEN 1 ELSE 0 END) seller_state_nulls
FROM sellers;
-- all 0

-- ============================================================
-- 3. EMPTY STRING CHECKS
-- ============================================================

# customers
SELECT
	SUM(CASE WHEN customer_id = '' THEN 1 ELSE 0 END) customer_id_empty,
	SUM(CASE WHEN customer_unique_id = '' THEN 1 ELSE 0 END) customer_unique_id_empty,
	SUM(CASE WHEN customer_zip_code_prefix = '' THEN 1 ELSE 0 END) customer_zip_code_prefix_empty,
    SUM(CASE WHEN customer_city = '' THEN 1 ELSE 0 END) customer_city_empty,
    SUM(CASE WHEN customer_state = '' THEN 1 ELSE 0 END) customer_state_empty
FROM customers;
-- all 0

# order_reviews — real empty strings found
SELECT
	SUM(CASE WHEN review_comment_title = '' THEN 1 ELSE 0 END) review_comment_title_empty,   -- 2
    SUM(CASE WHEN review_comment_message = '' THEN 1 ELSE 0 END) review_comment_message_empty -- 9
FROM order_reviews;

-- ============================================================
-- 4. DUPLICATE CHECKS
-- ============================================================

# customers
SELECT customer_id, COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;
-- no duplicates

# geolocation
SELECT geolocation_zip_code_prefix, geolocation_lat, geolocation_lng, COUNT(*) AS duplicate_count
FROM geolocation
GROUP BY geolocation_zip_code_prefix, geolocation_lat, geolocation_lng
HAVING COUNT(*) > 1;
-- many duplicates — expected (same zip, multiple coordinates)

# order_items
SELECT order_id, order_item_id, COUNT(*) AS duplicate_count
FROM order_items
GROUP BY order_id, order_item_id
HAVING COUNT(*) > 1;
-- no duplicates

# order_payments
SELECT order_id, payment_sequential, COUNT(*) AS duplicate_count
FROM order_payments
GROUP BY order_id, payment_sequential
HAVING COUNT(*) > 1;
-- no duplicates

# order_reviews — duplicates found
SELECT review_id, COUNT(*) AS duplicate_count
FROM order_reviews
GROUP BY review_id
HAVING COUNT(*) > 1;
-- 0.80% of rows (calculated manually: duplicate count / 99224)

-- inspect specific duplicate
SELECT *
FROM order_reviews
WHERE review_id = '28642ce6250b94cc72bc85960aec6c62';
-- same review_id, different order_id — one review linked to two orders. Keep both.

# orders
SELECT order_id, COUNT(*) AS duplicate_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;
-- no duplicates

# products
SELECT product_id, COUNT(*) AS duplicate_count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;
-- no duplicates

# sellers
SELECT seller_id, COUNT(*) AS duplicate_count
FROM sellers
GROUP BY seller_id
HAVING COUNT(*) > 1;
-- no duplicates

-- ============================================================
-- 5. DATE RANGES
-- ============================================================

SELECT MIN(order_purchase_timestamp), MAX(order_purchase_timestamp)
FROM orders;
-- 2016 to 2018 — valid range

-- bonus: delivery time exploration (preview of S10Q3)
CREATE TEMPORARY TABLE total_days_delivery_table AS
SELECT order_id,
	MIN(order_purchase_timestamp) AS order_purchase_date,
	MAX(order_delivered_customer_date) AS delivered_date,
	TIMESTAMPDIFF(DAY, MIN(order_purchase_timestamp), MAX(order_delivered_customer_date)) total_days_delivery
FROM orders
WHERE order_status = 'delivered'
GROUP BY order_id
HAVING delivered_date IS NOT NULL AND total_days_delivery IS NOT NULL
ORDER BY total_days_delivery ASC;

SELECT customers.customer_city, customers.customer_state, products.product_category_name, tddt.total_days_delivery
FROM total_days_delivery_table tddt
JOIN orders ON tddt.order_id = orders.order_id
JOIN customers ON orders.customer_id = customers.customer_id
JOIN order_items ON order_items.order_id = orders.order_id
JOIN products ON products.product_id = order_items.product_id
ORDER BY total_days_delivery;

DROP TEMPORARY TABLE total_days_delivery_table;

-- orders delivered in under 24 hours (São Paulo concentration)
WITH total_hours_delivery AS (
	SELECT order_id,
		MIN(order_purchase_timestamp) AS order_purchase_date,
		MAX(order_delivered_customer_date) AS delivered_date,
		TIMESTAMPDIFF(HOUR, MIN(order_purchase_timestamp), MAX(order_delivered_customer_date)) total_hours_delivery
	FROM orders
	WHERE order_status = 'delivered'
	GROUP BY order_id
	HAVING delivered_date IS NOT NULL AND total_hours_delivery IS NOT NULL AND total_hours_delivery < 24
)
SELECT customers.customer_city, customers.customer_state, thd.total_hours_delivery
FROM total_hours_delivery thd
JOIN orders ON thd.order_id = orders.order_id
JOIN customers ON orders.customer_id = customers.customer_id
ORDER BY total_hours_delivery;

-- ============================================================
-- 6. UNEXPECTED VALUES
-- ============================================================

SELECT price, freight_value FROM order_items ORDER BY price, freight_value;          -- no negatives
SELECT payment_value FROM order_payments ORDER BY payment_value;                     -- no negatives
SELECT review_score FROM order_reviews ORDER BY review_score;                        -- all 1–5
SELECT product_weight_g, product_length_cm, product_height_cm, product_width_cm
FROM products ORDER BY product_weight_g;                                             -- no negatives

-- ============================================================
-- 7. FOREIGN KEY CHECKS
-- ============================================================

-- orders.customer_id → customers
SELECT COUNT(*) FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
-- 0

-- order_items.order_id → orders
SELECT COUNT(*) FROM order_items oi
LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;
-- 0

-- order_items.product_id → products
SELECT COUNT(*) FROM order_items oi
LEFT JOIN products p ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;
-- 0

-- order_items.seller_id → sellers
SELECT COUNT(*) FROM order_items oi
LEFT JOIN sellers s ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL;
-- 0

-- order_reviews.order_id → orders
SELECT COUNT(*) FROM order_reviews orv
LEFT JOIN orders o ON orv.order_id = o.order_id
WHERE o.order_id IS NULL;
-- 0

-- order_payments.order_id → orders
SELECT COUNT(*) FROM order_payments op
LEFT JOIN orders o ON op.order_id = o.order_id
WHERE o.order_id IS NULL;
-- 0
