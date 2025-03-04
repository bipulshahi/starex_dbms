show databases;

use starexdb;

create table employees (emp_id int primary key, first_name varchar(50),
last_name varchar(50), salary decimal(10,2), department varchar(50), join_date date);

insert into employees values(1,'Akash','Singh',55000.75,'HR','2021-02-15'),
(2,'Ragini','Jaiswal',65000.55,'IT','2019-06-22'),
(3,'Rohan','Joshi',72000.75,'Finance','2018-08-10'),
(4,'Rahul','Kumar',48000.25,'Marketing','2022-01-05'),
(5,'Radhika','Singh',80000.75,'IT','2017-12-12');

select * from employees;

#count characters od first name
select first_name,length(first_name) as name_length from employees;

#concat first_name & last_name
select first_name , last_name, concat(first_name , ' ' , last_name) as full_name 
from employees;

#convert first_name into upper case and lower case
select first_name, upper(first_name) as uppercase , lower(first_name) as lower
from employees;

#Replace department 'IT' as 'Information Technology'
select replace(department , 'IT' , 'Information Technology') as dept
from employees;

#Select first 3 charcters from first_name
select substr(first_name , 1,3) from employees;

select concat(substr(first_name , 1,3), substr(join_date,1,4)) as password from employees;

select * from employees;
#Calculate yearly salary of each employee
select salary , salary*12 as yearly_salary from employees;

#Round up and round down the salary of employees
select salary, ceil(salary) as round_up , floor(salary) as round_down from employees;

#Round up the salary to 1 decimal place
select salary, round(salary,1) as rounded_salary from employees;

#Minimum and Maximum salaries among the employees
select min(salary) , max(salary) from employees;
select least(23,21,7,25,29) as least_value;

#Convert salary value to character
select cast(salary as char) from employees;

#Find sample where salary data is missing
select * from employees where salary is null;