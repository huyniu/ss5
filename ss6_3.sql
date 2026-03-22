-- 1. Tạo bảng Customer
CREATE TABLE Customer (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(255),
    email VARCHAR(255),
    points INT
);

-- 2. Thêm 7 khách hàng (Yêu cầu 1: có 1 người không có email)
INSERT INTO Customer (customer_name, email, points) VALUES 
('Nguyễn Văn A', 'a@gmail.com', 500),
('Trần Thị B', 'b@gmail.com', 800),
('Lê Văn C', NULL, 300), -- Khách hàng không có email
('Nguyễn Văn A', 'a2@gmail.com', 100), -- Trùng tên với khách đầu để test DISTINCT
('Phạm Thị D', 'd@gmail.com', 1200),
('Hoàng Văn E', 'e@gmail.com', 950),
('Ngô Thị F', 'f@gmail.com', 700);
SELECT DISTINCT customer_name 
FROM Customer;
SELECT * 
FROM Customer 
WHERE email IS NULL;
SELECT * 
FROM Customer 
ORDER BY points DESC 
LIMIT 3 OFFSET 1;
SELECT * 
FROM Customer 
ORDER BY customer_name DESC;