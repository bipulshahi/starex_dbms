-- You have a table called orders with the following structure:
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATETIME,
    total_amount DECIMAL(10,2)
);
-- slow query
SELECT * FROM orders WHERE order_date BETWEEN '2024-01-01' AND '2024-03-01';

-- optimized query (fast)
create index idx_order on orders(order_date);
SELECT * FROM orders WHERE order_date BETWEEN '2024-01-01' AND '2024-03-01';



-- You have the following two tables:
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10,2)
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- slow query
SELECT first_name, last_name FROM employees 
WHERE department_id IN (SELECT department_id FROM departments WHERE department_name = 'HR');

-- optimized query (exists)
SELECT first_name, last_name FROM employees e WHERE exists
(SELECT department_id FROM departments WHERE d.department_id = e.department_id
and d.department_name = 'HR');

-- optimized query (joins)
SELECT first_name, last_name FROM employees e join departments d
on e.department_id = d.department_id where d.department_name = 'HR';

-- employees_details
-- departments
-- compare and analyse performance of exists vs join







