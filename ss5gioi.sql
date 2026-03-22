-- 1. Xóa bảng cũ (nếu có)
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

-- 2. Tạo bảng customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    city VARCHAR(100)
);

-- 3. Tạo bảng orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    total_price DECIMAL(10, 2)
);

-- 4. Tạo bảng order_items
CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2)
);

-- 5. Chèn dữ liệu mẫu
INSERT INTO customers VALUES 
(1, 'Nguyễn Văn A', 'Hà Nội'),
(2, 'Trần Thị B', 'Đà Nẵng'),
(3, 'Lê Văn C', 'Hồ Chí Minh'),
(4, 'Phạm Thị D', 'Hà Nội');

INSERT INTO orders VALUES 
(101, 1, '2024-12-20', 3000),
(102, 2, '2025-01-05', 1500),
(103, 1, '2025-02-10', 2500),
(104, 3, '2025-02-15', 4000),
(105, 4, '2025-03-01', 800);

INSERT INTO order_items VALUES 
(1, 101, 1, 2, 1500),
(2, 102, 2, 1, 1500),
(3, 103, 3, 5, 500),
(4, 104, 2, 4, 1000);
SELECT 
    customer_id, 
    SUM(total_price) AS total_revenue, 
    COUNT(order_id) AS order_count
FROM orders
GROUP BY customer_id
HAVING SUM(total_price) > 2000;
SELECT customer_id, SUM(total_price) AS total_revenue
FROM orders
GROUP BY customer_id
HAVING SUM(total_price) > (
    SELECT AVG(customer_total) 
    FROM (SELECT SUM(total_price) AS customer_total FROM orders GROUP BY customer_id) AS sub
);
SELECT c.city, SUM(o.total_price) AS city_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY city_revenue DESC
LIMIT 1;
SELECT 
    c.customer_name, 
    c.city, 
    SUM(oi.quantity) AS total_products_bought, 
    SUM(o.total_price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name, c.city;