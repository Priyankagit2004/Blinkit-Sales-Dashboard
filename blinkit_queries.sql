==========================================================
--Blinkit Sales Dashboard SQL Queries
-- Author: Priyanka Thorwate
-- Tools Used: MySQL, Power BI
-- ==========================================================

USE blinkit_analysis;

-- ==========================================================
-- KPI QUERIES
-- ==========================================================

-- Total Customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- Total Orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- Total Revenue
SELECT ROUND(SUM(order_total),2) AS total_revenue
FROM orders;

-- Average Order Value
SELECT ROUND(AVG(order_total),2) AS average_order_value
FROM orders;

-- Highest Order Value
SELECT MAX(order_total) AS highest_order
FROM orders;

-- Lowest Order Value
SELECT MIN(order_total) AS lowest_order
FROM orders;

-- Total Products
SELECT COUNT(*) AS total_products
FROM products;

-- ==========================================================
-- ORDER ANALYSIS
-- ==========================================================

-- Orders by Payment Method
SELECT
    payment_method,
    COUNT(*) AS total_orders
FROM orders
GROUP BY payment_method
ORDER BY total_orders DESC;

-- Orders by Delivery Status
SELECT
    delivery_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY delivery_status
ORDER BY total_orders DESC;

-- Monthly Sales Trend
SELECT
    MONTHNAME(order_date) AS month,
    ROUND(SUM(order_total),2) AS total_sales
FROM orders
GROUP BY MONTH(order_date), MONTHNAME(order_date)
ORDER BY MONTH(order_date);

-- ==========================================================
-- CUSTOMER ANALYSIS
-- ==========================================================

-- Customers by Segment
SELECT
    customer_segment,
    COUNT(*) AS customers
FROM customers
GROUP BY customer_segment
ORDER BY customers DESC;

-- Revenue by Customer Segment
SELECT
    c.customer_segment,
    ROUND(SUM(o.order_total),2) AS revenue
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_segment
ORDER BY revenue DESC;

-- Top 10 Customers by Spending
SELECT
    c.customer_name,
    ROUND(SUM(o.order_total),2) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 10;

-- ==========================================================
-- PRODUCT ANALYSIS
-- ==========================================================

-- Products by Category
SELECT
    category,
    COUNT(*) AS total_products
FROM products
GROUP BY category
ORDER BY total_products DESC;

-- Average Product Price by Category
SELECT
    category,
    ROUND(AVG(price),2) AS avg_price
FROM products
GROUP BY category
ORDER BY avg_price DESC;

-- Top 10 Products by Margin
SELECT
    product_name,
    margin_percentage
FROM products
ORDER BY margin_percentage DESC
LIMIT 10;

-- Stock Levels
SELECT
    product_name,
    min_stock_level,
    max_stock_level
FROM products
ORDER BY min_stock_level;

-- ==========================================================
-- SALES ANALYSIS
-- ==========================================================

-- Revenue by Category
SELECT
    p.category,
    ROUND(SUM(oi.total_price),2) AS total_sales
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

-- Top 10 Selling Products
SELECT
    p.product_name,
    ROUND(SUM(oi.total_price),2) AS total_sales
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC
LIMIT 10;

-- Revenue by Product
SELECT
    p.product_name,
    ROUND(SUM(oi.total_price),2) AS revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;

-- ==========================================================
-- DASHBOARD QUERIES
-- ==========================================================

-- KPI Summary
SELECT
    (SELECT COUNT(*) FROM customers) AS Total_Customers,
    (SELECT COUNT(*) FROM orders) AS Total_Orders,
    (SELECT ROUND(SUM(order_total),2) FROM orders) AS Total_Revenue,
    (SELECT ROUND(AVG(order_total),2) FROM orders) AS Average_Order_Value,
    (SELECT COUNT(*) FROM products) AS Total_Products;

-- Revenue by Category
SELECT
    p.category,
    ROUND(SUM(oi.total_price),2) AS Total_Sales
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY Total_Sales DESC;

-- Monthly Revenue Trend
SELECT
    MONTHNAME(order_date) AS Month,
    ROUND(SUM(order_total),2) AS Revenue
FROM orders
GROUP BY MONTH(order_date), MONTHNAME(order_date)
ORDER BY MONTH(order_date);

-- Payment Method Distribution
SELECT
    payment_method,
    COUNT(*) AS Orders
FROM orders
GROUP BY payment_method
ORDER BY Orders DESC;

-- Top 10 Products by Sales
SELECT
    p.product_name,
    ROUND(SUM(oi.total_price),2) AS Total_Sales
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY Total_Sales DESC
LIMIT 10;