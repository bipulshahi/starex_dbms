use starexdb;

CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    sale_amount DECIMAL(10,2),
    sale_date DATE
);

INSERT INTO sales (emp_id, emp_name, department, sale_amount, sale_date) VALUES
(101, 'Amit', 'Electronics', 5000, '2024-03-01'),
(102, 'Neha', 'Electronics', 7000, '2024-03-02'),
(103, 'Raj', 'Clothing', 2000, '2024-03-03'),
(104, 'Priya', 'Clothing', 4000, '2024-03-04'),
(105, 'Rahul', 'Furniture', 10000, '2024-03-05'),
(101, 'Amit', 'Electronics', 6500, '2024-03-06'),
(102, 'Neha', 'Electronics', 7200, '2024-03-07'),
(103, 'Raj', 'Clothing', 2500, '2024-03-08'),
(104, 'Priya', 'Clothing', 3800, '2024-03-09'),
(105, 'Rahul', 'Furniture', 8900, '2024-03-10');

