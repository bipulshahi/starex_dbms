-- efficient queries
-- to reduce database load and speed up execution

-- 1. use select instead of select *
-- bad practice
select * from employees_details;
-- good practice
select first_name,last_name,salary from employees_details;

-- 2. Use proper indexing
-- helps speed up searches and filter results efficiently
-- without index (slow search)
select * from employees_deatils where last_name='Sharma';
-- With index (fast search)
create index idx_last_name on employees_details(last_name);
select * from employees_deatils where last_name='Sharma';

-- 3.Avoid using functions on indexed columns in where clause
-- bad practice (slow query)
select * from employees_deatils where year(joining_date)=2020;
-- good practice (fast query)
-- applying functions on indexed columns makes MySQL ignore the index
select * from employees_deatils where joining_date between '2020-01-01' and '2020-12-31';

-- 4. Use EXISTS instead of IN (for large data)
-- Using IN (Slow for large data)
select first_name from employees_details where department_id in (select department_id from departments 
where department_name = 'Shipping');
-- Using Exists (Faster)
-- exists stop searching once it finds a match, whereas IN scans all rows
select * from employees_details e where exists 
(select 1 from departments d 
where d.department_id = e.department_id 
and d.department_name = 'Shipping');

-- 5. Use LIMIT for large data fetch
-- fetch all rows (slow)
select * from employees_details order by salary desc;
-- fetching limited rows (fast)
select * from employees_details order by salary desc limit 10;
