-- 1. Tạo bảng OrderInfo
CREATE TABLE OrderInfo (
    order_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(255),
    order_date DATE,
    total_amount DECIMAL(15, 2),
    status VARCHAR(50)
);

-- 2. Thêm 5 đơn hàng mẫu (Yêu cầu 1)
INSERT INTO OrderInfo (customer_name, order_date, total_amount, status) VALUES 
('Nguyễn Văn A', '2024-10-05', 600000, 'Completed'),
('Trần Thị B', '2024-10-15', 450000, 'Pending'),
('Lê Văn C', '2024-10-20', 750000, 'Shipping'),
('Phạm Thị D', '2024-11-01', 300000, 'Completed'),
('Hoàng Văn E', '2024-10-25', 550000, 'Cancelled');
SELECT * FROM OrderInfo 
WHERE total_amount > 500000;
SELECT * FROM OrderInfo 
WHERE order_date BETWEEN '2024-10-01' AND '2024-10-31';SELECT * FROM OrderInfo 
WHERE status != 'Completed';
SELECT * FROM OrderInfo 
ORDER BY order_date DESC 
LIMIT 2;