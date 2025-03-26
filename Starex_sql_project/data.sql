show databases;
use starexdb;

show tables;

DROP TABLE IF EXISTS sales_data;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;

-- Create Customers Table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    region VARCHAR(50)
);

-- Create Products Table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10,2),
    stock INT
);

-- Create Sales Data Table
CREATE TABLE sales_data (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    sale_date DATE,
    quantity INT,
    unit_price DECIMAL(10,2),
    total_price DECIMAL(10,2),
    region VARCHAR(50),
    sales_rep VARCHAR(50),
    payment_mode VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers (customer_name, email, region) VALUES
('Amit Sharma', 'amit.sharma@email.com', 'North'),
('Priya Verma', 'priya.verma@email.com', 'West'),
('Rajesh Iyer', 'rajesh.iyer@email.com', 'South'),
('Sneha Patil', 'sneha.patil@email.com', 'West'),
('Vikram Singh', 'vikram.singh@email.com', 'North'),
('Kiran Rao', 'kiran.rao@email.com', 'South'),
('Pooja Mehta', 'pooja.mehta@email.com', 'West'),
('Arjun Das', 'arjun.das@email.com', 'East'),
('Neha Kapoor', 'neha.kapoor@email.com', 'North'),
('Sandeep Yadav', 'sandeep.yadav@email.com', 'East');

INSERT INTO products (product_name, category, unit_price, stock) VALUES
('Samsung Galaxy S23', 'Smartphones', 75000.00, 50),
('Redmi Note 12', 'Smartphones', 18000.00, 100),
('OnePlus Nord CE', 'Smartphones', 25000.00, 80),
('Sony Bravia 55" 4K', 'Televisions', 60000.00, 30),
('HP Pavilion Laptop', 'Laptops', 65000.00, 40),
('Apple MacBook Air', 'Laptops', 95000.00, 25),
('Mi Smart TV 43"', 'Televisions', 30000.00, 50),
('boAt Airdopes 441', 'Accessories', 2500.00, 300),
('Realme Smartwatch', 'Wearables', 4000.00, 150),
('JBL Bluetooth Speaker', 'Accessories', 5000.00, 200);


DELIMITER $$

CREATE PROCEDURE GenerateSalesData()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 500 DO
        INSERT INTO sales_data (customer_id, product_id, sale_date, quantity, unit_price, total_price, region, sales_rep, payment_mode)
        VALUES (
            FLOOR(1 + (RAND() * 10)),  -- Random customer_id (1-10)
            FLOOR(1 + (RAND() * 10)),  -- Random product_id (1-10)
            DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 365) DAY), -- Random date in last 1 year
            FLOOR(1 + (RAND() * 5)),  -- Random quantity (1-5)
            (SELECT unit_price FROM products ORDER BY RAND() LIMIT 1), -- Fetch random unit price
            (SELECT unit_price * FLOOR(1 + (RAND() * 5)) FROM products ORDER BY RAND() LIMIT 1), -- Calculate total price
            (SELECT region FROM customers ORDER BY RAND() LIMIT 1), -- Fetch random region
            CONCAT('Sales Rep ', FLOOR(1 + (RAND() * 5))), -- Random sales rep
            ELT(FLOOR(1 + (RAND() * 3)), 'Credit Card', 'UPI', 'Net Banking') -- Random payment mode
        );

        SET i = i + 1;
    END WHILE;
END $$

DELIMITER ;

CALL GenerateSalesData();

-- drop PROCEDURE GenerateSalesData;

select * from sales_data;