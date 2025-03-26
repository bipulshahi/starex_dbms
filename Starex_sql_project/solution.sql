use starexdb;
select * from sales_data;
-- Total sales revenue
select sum(total_price) as total_revenue from sales_data;

-- Best-selling products
select product_id,count(product_id) as order_count from sales_data
group by product_id
order by order_count desc limit 5;

-- find these product names
select p.product_name,count(s.product_id) as order_count from sales_data s join products p
on p.product_id = s.product_id
group by p.product_name
order by order_count desc limit 5;

-- Total sales per region
select region,sum(total_price) from sales_data group by region;

-- Average order value
select avg(total_price) from sales_data;

-- Monthly sales trend
select date_format(sale_date , '%Y-%m') as month, sum(total_price) as revenue 
from sales_data
group by month
order by month;

-- Top 5 customers by revenue
select customer_id, sum(total_price) as total_spent from sales_data group by customer_id
order by total_spent desc
limit 5;

-- Sales breakdown by payment mode
select payment_mode, count(*) as transactions , sum(total_price) as revenue
from sales_data
group by payment_mode;

-- Products that generated the most revenue
select p.product_name, sum(s.total_price) as revenue from sales_data s join products p
on s.product_id = p.product_id
group by p.product_name
order by revenue desc;

-- Identify slow-moving products
select p.product_name, count(s.sale_id) as sales_count from products p left join sales_data s
on p.product_id = s.product_id
group by p.product_name
having sales_count < 50;

-- Customers who have purchased more than 10 times
select c.customer_name , count(s.customer_id) as order_count
from sales_data s join customers c
on c.customer_id = s.customer_id
group by c.customer_name
having order_count > 10;

select * from customers;

-- Year-over-year revenue growth

-- Sales rep performance analysis

-- Customers with the highest order value

-- Sales trend for a specific product category

-- Detecting potential fraud (unusually high orders)

