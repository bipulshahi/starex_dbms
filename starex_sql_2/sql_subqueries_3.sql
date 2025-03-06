show databases;

create database if not exists starexdb;

use starexdb;
show tables;

drop table employee_details;

CREATE TABLE employees_details (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(10,2),
    phone_number VARCHAR(20),
    email VARCHAR(100),
    job_id VARCHAR(50),
    department_id INT,
    hire_date DATE
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location_id INT
);

CREATE TABLE jobs (
    job_id VARCHAR(50) PRIMARY KEY,
    job_title VARCHAR(50)
);

INSERT INTO departments (department_id, department_name, location_id)
VALUES
(101, 'Shipping', 1700),
(102, 'Executive', 1600),
(103, 'Finance', 1700),
(104, 'IT', 1500),
(105, 'HR', 1600),
(106, 'Sales', 1400);


INSERT INTO jobs (job_id, job_title)
VALUES
('SH_CLERK', 'Shipping Clerk'),
('AC_ACCOUNTANT', 'Accountant'),
('IT_PROGRAMMER', 'IT Programmer'),
('AD_VP', 'Vice President'),
('HR_MANAGER', 'HR Manager'),
('SALES_EXEC', 'Sales Executive');


INSERT INTO employees_details (employee_id, first_name, last_name, salary, phone_number, email, job_id, department_id, hire_date)
VALUES
(1, 'Amit', 'Sharma', 75000, '9876543210', 'amit.sharma@example.com', 'IT_PROGRAMMER', 104, '2020-03-15'),
(2, 'Pooja', 'Verma', 90000, '9765432109', 'pooja.verma@example.com', 'AC_ACCOUNTANT', 103, '2018-06-12'),
(3, 'Rajesh', 'Gupta', 120000, '9876501234', 'rajesh.gupta@example.com', 'AD_VP', 102, '2017-02-25'),
(4, 'Neha', 'Kapoor', 85000, '9856741234', 'neha.kapoor@example.com', 'IT_PROGRAMMER', 104, '2021-07-20'),
(5, 'Ravi', 'Mishra', 50000, '9956341287', 'ravi.mishra@example.com', 'SH_CLERK', 101, '2019-11-05'),
(6, 'Anjali', 'Yadav', 52000, '9923146789', 'anjali.yadav@example.com', 'SH_CLERK', 101, '2021-04-30'),
(7, 'Vikram', 'Singh', 135000, '9987452361', 'vikram.singh@example.com', 'AD_VP', 102, '2016-09-18'),
(8, 'Sanya', 'Chopra', 62000, '9898745632', 'sanya.chopra@example.com', 'SALES_EXEC', 106, '2022-05-14'),
(9, 'Arjun', 'Rao', 58000, '9845698712', 'arjun.rao@example.com', 'SALES_EXEC', 106, '2023-08-10'),
(10, 'Kiran', 'Das', 75000, '9784563210', 'kiran.das@example.com', 'HR_MANAGER', 105, '2021-01-15'),
(11, 'Suresh', 'Pillai', 60000, '9932165874', 'suresh.pillai@example.com', 'AC_ACCOUNTANT', 103, '2022-03-21'),
(12, 'Meena', 'Joshi', 92000, '9876547890', 'meena.joshi@example.com', 'AC_ACCOUNTANT', 103, '2019-12-05'),
(13, 'Farhan', 'Sheikh', 130000, '9812345678', 'farhan.sheikh@example.com', 'AD_VP', 102, '2015-07-30'),
(14, 'Rohit', 'Bansal', 85000, '9751234567', 'rohit.bansal@example.com', 'IT_PROGRAMMER', 104, '2020-09-10'),
(15, 'Simran', 'Kaur', 68000, '9967854123', 'simran.kaur@example.com', 'SH_CLERK', 101, '2020-02-20');

select * from employees_details;

#employees earning above the average salary
select employee_id,first_name,last_name from employees_details
where salary > (select avg(salary) from employees_details);

#employees working in a department with location_id = 1700
select * from employees_details;
select * from departments;

select * from employees_details
where department_id in (select department_id from departments where location_id = 1700);

#Employees in Shipping, executive or finance department
select * from employees_details
where department_id in
(select department_id from departments 
where department_name in ('Executive','Finance','Shipping'));

#Clerk earning more then any IT Programmers
select salary from employees_details where job_id in
(select job_id from jobs where job_title = 'IT Programmer');

select * from employees_details where job_id in
(select job_id from jobs where job_title = 'shipping clerk');

select * from employees_details where job_id = 'SH_CLERK'
and salary > any(select salary from employees_details where job_id in
(select job_id from jobs where job_title = 'IT Programmer'));

select * from employees_details where job_id = 'SH_CLERK'
and salary > any(select salary from employees_details where job_id = 'IT_PROGRAMMER');
