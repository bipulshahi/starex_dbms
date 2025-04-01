drop table users;

-- Auto_Increment(Mysql) vs Serial(Postgre) for autoincrementing ids
create table users (id serial primary key,name varchar(50), age int, created_at timestamp default current_timestamp);


-- no difference in insert
insert into users(name , age) values ('Joy',22) , ('Arun',20) , ('Sameer', 18);


-- no difference in select
select * from users;

-- MySQL uses JSON data type, But Postgre sql has JSONB (binary format, better for indexing)
-- Postgre JSON support is more advanced
create table products(
id serial primary key,
details jsonb);       -- use only json in mysql

select * from products;

insert into products (details) values
('{"name" : "Laptop" , "price" : 60000}'),
('{"name" : "Phone" , "price" : 40000}');

select * from products;
select details->>'name',details->>'price' from products;
-- in MySQL => select details->>'$.name',details->>'$.price' from products;

-- for mysql
/*
create table orders (
id int auto_increment primary key,
user_id int,
amount decimal(10,2),
foreign key (user_id) references users(id)
)
*/
-- in postgre
create table orders (
id serial primary key,
user_id int references users(id),
amount decimal(10,2)
);

insert into orders (user_id, amount) values (1,500.00),(2,400.00);

select users.name, orders.amount from users join orders
on users.id = orders.user_id;
-- joins has no major difference but postgre has better optimization for joins

-- for MySQL -- ALTER TABLE employees MODIFY COLUMN name TYPE VARCHAR(150);
ALTER TABLE employees ADD COLUMN phone VARCHAR(15);
ALTER TABLE employees ALTER COLUMN name TYPE VARCHAR(150);
ALTER TABLE employees DROP COLUMN phone;

-- postgre supports full join but MySQL don't
SELECT e.name, d.dept_name
FROM employees e
FULL JOIN departments d ON e.dept_id = d.dept_id;


select table_name from information_schema.tables where table_schema='public';

select * from users;

select name as emp_name from users u1;
select name as mng_name from users u2;

select u1.name as emp_name, u2.name as mng_name from users u1 join users u2
on u1.id = u2.manager_id;

-- Subquerries 
-- Correlated - runs for each row
-- list employees from each department getting more then average salary of that department
select * from employees e1 where salary > (select avg(salary) from employees e2 where e1.dept_id = e2.dept_id);


-- Non Correlated - runs independently
-- list the employees getting salary more then average salary
select * from employees where salary > (select avg(salary) from employees);


-- indexing

-- clustered 
-- The primary key in MySQL automatically creates clustered index.
-- but PostgreSQL does not automatically cluster, but we can do manually
select * from users;
update users set name = 'Ajay' where id = 4;
select * from users;
insert into users (name,age,manager_id) values ('Joy',25,1)
select * from users;

cluster users using users_pkey;          -- making primary key as clustered index
select * from users;
update users set name = 'Varun' where id = 4;
select * from users;
cluster users using users_pkey;          -- making primary key as clustered index
select * from users;

-- Non-clustered index  -- same as MySQL
create index idx_age on users(age);


-- Partial indexing 
create index idx_high_age on users(age) where age > 22;


-- Transaction Control
-- commit
-- add two new data row and then commit
start transaction;
insert into users (name,age,manager_id) values ('Pavan',23,2),('Sameer',22,1);
commit;

select * from users;

-- rollback
-- add two new data row and then rollback
start transaction;
insert into users (name,age,manager_id) values ('Raman',23,2),('Gagan',22,1);
rollback;

select * from users;


-- savepoint
start transaction;
insert into users (name,age,manager_id) values ('Raman',23,2);
savepoint save1;

insert into users (name,age,manager_id) values ('Gagan',22,1);
rollback to save1;          -- rollback only Gagan insertion

commit;

select * from users;

explain analyze select * from users;

-- describe users;
select * from information_schema.tables where table_name = 'users';
select * from information_schema.columns where table_name = 'users';

select column_name,data_type,is_nullable,column_default from information_schema.columns where table_name = 'users';
