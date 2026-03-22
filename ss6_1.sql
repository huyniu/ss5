CREATE OR REPLACE VIEW CustomerOrderSummary AS
SELECT 
    c.customer_name, 
    c.city, 
    COUNT(o.order_id) AS total_orders, 
    SUM(o.total_price) AS total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name, c.city;

-- Cách kiểm tra View:
SELECT * FROM CustomerOrderSummary;
BEGIN;

-- Thêm khách hàng mới
INSERT INTO customers (customer_id, customer_name, city) 
VALUES (5, 'Hoàng Văn E', 'Cần Thơ');

-- Thêm đơn hàng cho khách hàng đó
INSERT INTO orders (order_id, customer_id, order_date, total_price) 
VALUES (106, 5, CURRENT_DATE, 1200);

-- Nếu mọi thứ ổn, xác nhận lưu dữ liệu
COMMIT;

-- Lưu ý: Nếu có lỗi xảy ra giữa chừng, hãy dùng lệnh: ROLLBACK;
CREATE OR REPLACE FUNCTION UpdateOrderPrice(p_order_id INT, p_new_price DECIMAL)
RETURNS VOID AS $$
BEGIN
    UPDATE orders
    SET total_price = p_new_price
    WHERE order_id = p_order_id;
END;
$$ LANGUAGE plpgsql;

-- Cách gọi Procedure (Function):
SELECT UpdateOrderPrice(101, 3500);
SELECT * FROM CustomerOrderSummary 
WHERE total_spent > 3000 
ORDER BY total_spent DESC;