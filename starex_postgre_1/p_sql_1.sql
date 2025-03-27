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













