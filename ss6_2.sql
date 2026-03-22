-- 1. Tạo bảng Employee
CREATE TABLE Employee (
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(255),
    department VARCHAR(100),
    salary DECIMAL(15, 2),
    hire_date DATE
);

-- 2. Thêm 6 nhân viên mới (Yêu cầu 1)
INSERT INTO Employee (employee_name, department, salary, hire_date) VALUES 
('Nguyễn Văn An', 'IT', 12000000, '2023-05-15'),
('Trần Thị Bình', 'HR', 8000000, '2022-10-01'),
('Lê Hoàng Anh', 'IT', 15000000, '2023-01-20'),
('Phạm Mỹ Hạnh', 'Marketing', 5500000, '2024-02-10'),
('Đặng Văn Bình', 'IT', 9000000, '2023-12-31'),
('Hoàng Phan Anh', 'Sales', 5800000, '2023-06-01');
UPDATE Employee
SET salary = salary * 1.1
WHERE department = 'IT';
DELETE FROM Employee
WHERE salary < 6000000;
SELECT * FROM Employee
WHERE employee_name ILIKE '%An%';
SELECT * FROM Employee
WHERE hire_date BETWEEN '2023-01-01' AND '2023-12-31';