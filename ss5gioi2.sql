-- 1. Xóa bảng cũ để làm mới
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS customers CASCADE;

-- 2. Tạo cấu trúc 3 bảng
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    city VARCHAR(100)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    total_price DECIMAL(10, 2)
);

CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2)
);

-- 3. Chèn dữ liệu mẫu (Dựa trên hình ảnh bài tập)
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
WITH CitySpending AS (
    SELECT c.city, SUM(o.total_price) AS total_city_revenue
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.city
)
SELECT city, total_city_revenue
FROM CitySpending
WHERE total_city_revenue = (SELECT MAX(total_city_revenue) FROM CitySpending);
SELECT customer_id FROM customers
EXCEPT
SELECT customer_id FROM orders;
SELECT DISTINCT product_id
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.customer_id IN (SELECT customer_id FROM customers WHERE city = 'Hà Nội')
GROUP BY product_id
HAVING COUNT(DISTINCT o.customer_id) = (
    SELECT COUNT(*) FROM customers WHERE city = 'Hà Nội'
);
SELECT 
    c.customer_name, 
    c.city, 
    COUNT(DISTINCT o.order_id) AS total_orders, 
    SUM(o.total_price) AS total_spent,
    SUM(oi.quantity) AS total_items
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name, c.city;