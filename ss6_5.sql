-- 1. Xóa bảng cũ nếu đã tồn tại để làm sạch dữ liệu
DROP TABLE IF EXISTS Course;

-- 2. Tạo bảng Course
CREATE TABLE Course (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(255),
    duration INT, -- Thời lượng (giờ)
    price DECIMAL(15, 2)
);

-- 3. Thêm ít nhất 6 khóa học (Yêu cầu 1)
INSERT INTO Course (course_name, duration, price) VALUES 
('Lập trình SQL cơ bản', 20, 500000),
('SQL Nâng cao và tối ưu', 40, 1500000),
('Python for Data Science', 45, 2500000),
('Web Demo 1', 10, 200000),
('Demo ReactJS', 15, 300000),
('Data Analysis với SQL', 35, 1200000);
UPDATE Course
SET price = price * 1.15
WHERE duration > 30;
DELETE FROM Course
WHERE course_name ILIKE '%Demo%';
SELECT * FROM Course
WHERE course_name ILIKE '%SQL%';
SELECT * FROM Course
WHERE price BETWEEN 500000 AND 2000000
ORDER BY price DESC
LIMIT 3;