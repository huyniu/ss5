SELECT p.product_name, SUM(o.total_price) AS total_revenue
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_name
HAVING SUM(o.total_price) = (
    SELECT MAX(revenue) 
    FROM (SELECT SUM(total_price) AS revenue FROM orders GROUP BY product_id) AS sub
);
SELECT p.category, SUM(o.total_price) AS total_category_revenue
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category;
-- Tập hợp 1: Category của sản phẩm bán chạy nhất
SELECT category FROM products WHERE product_id = (
    SELECT product_id FROM orders GROUP BY product_id ORDER BY SUM(total_price) DESC LIMIT 1
)
INTERSECT
-- Tập hợp 2: Các Category có tổng doanh thu > 3000
SELECT p.category
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category
HAVING SUM(o.total_price) > 3000;