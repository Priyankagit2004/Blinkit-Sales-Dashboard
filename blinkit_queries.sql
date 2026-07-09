SELECT COUNT(*) AS total_customers
FROM customers;

SELECT COUNT(*) AS total_orders
FROM orders;

SELECT ROUND(SUM(order_total),2) AS total_revenue
FROM orders;

SELECT ROUND(AVG(order_total),2) AS average_order_value
FROM orders;

SELECT MAX(order_total) AS highest_order
FROM orders;

SELECT MIN(order_total) AS lowest_order
FROM orders;

SELECT payment_method,
COUNT(*) AS total_orders
FROM orders
GROUP BY payment_method
ORDER BY total_orders DESC;

SELECT delivery_status,
COUNT(*) AS total_orders
FROM orders
GROUP BY delivery_status
ORDER BY total_orders DESC;

SELECT customer_segment,
COUNT(*) AS customers
FROM customers
GROUP BY customer_segment
ORDER BY customers DESC;

SELECT c.customer_segment,
ROUND(SUM(o.order_total),2) AS revenue
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_segment
ORDER BY revenue DESC;

SELECT c.customer_name,
SUM(o.order_total) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 10;

SELECT category,
COUNT(*) AS total_products
FROM products
GROUP BY category
ORDER BY total_products DESC;

SELECT category,
ROUND(AVG(price),2) AS avg_price
FROM products
GROUP BY category
ORDER BY avg_price DESC;

SELECT product_name,
margin_percentage
FROM products
ORDER BY margin_percentage DESC
LIMIT 10;

SELECT product_name,
min_stock_level,
max_stock_level
FROM products
ORDER BY min_stock_level;
