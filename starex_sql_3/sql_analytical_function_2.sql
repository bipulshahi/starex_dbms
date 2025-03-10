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

select * from sales;

#Rank employees based on their sales amount - Highest first
#If two employees have the same sale_amount, they get same rank
#but the next rank is skipped
select emp_name,department,sale_amount,
rank() over(order by sale_amount desc) as sales_rank from sales;

#dense_rank() - does not skip rank
select emp_name,department,sale_amount,
dense_rank() over(order by sale_amount desc) as sales_rank 
from sales;

#assign row number for each employees sales
#It can usefule when employee make multiple sales,
#and we want to assign unique row number for each sale
#which can help to track the order of sales made by each employee
select emp_id, emp_name, department, sale_amount, sale_date,
row_number() over(order by sale_date) as sale_number
from sales; 

select emp_id, emp_name, department, sale_amount, sale_date,
row_number() over(partition by emp_id order by sale_date) as sale_number
from sales;

#First sale amount for each employee - return earliest sale amount 
#of each employee
select emp_id,emp_name,sale_amount,sale_date,
first_value(sale_amount) over(partition by emp_id order by sale_date) 
as first_sale
from sales;

#last sale amount for each employee - return latest sale amount 
#of each employee
select emp_id,emp_name,sale_amount,sale_date,
last_value(sale_amount) over(partition by emp_id order by sale_date
range between unbounded preceding and unbounded following) 
as last_sale
from sales;

#compare the current sale with previous sale
#lead() - get the next sale amount
#lag() - get the previous sale amount
#It can help to analyze trends in employee performance
select emp_id,emp_name,sale_amount,sale_date,
lag(sale_amount,1) over(partition by emp_id order by sale_date) 
as previous_sale,
lead(sale_amount,1) over(partition by emp_id order by sale_date) 
as next_sale
from sales;

#divide sale into equal sized groups
#assign employees into groups based on sale amount
#it can help to group employees into performance categories
select emp_id,emp_name,sale_amount,sale_date,
ntile(4) over(order by sale_amount desc) as quartile
from sales;

#calculate cumulative distribution of sales
#use_case - A sale manager can use this to identify top 10% sales(cume_dist()>=0.90)
#HR can use this to evaluate salaries 
#and check if someone is in top 20% earners
select emp_id,emp_name,sale_amount,
cume_dist() over(order by sale_amount asc) as sales_percentile
from sales;

#Find top 10% sales
select emp_id,emp_name,sale_amount from 
(select emp_id,emp_name,sale_amount,
cume_dist() over(order by sale_amount asc) as sales_percentile
from sales) ranked_sales
where sales_percentile >= 0.9;
