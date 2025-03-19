show databases;

use ecoomerce;

show tables;
describe order_items;
describe orders;
select * from products;
describe payments;
select * from customers;

-- transaction begins
start transaction;

-- create an order for customer id 1  - one smartphone
insert into orders (customer_id,total_amount,status)
values(1,30000.00,'Pending');

select * from orders;

-- get the last inserted order id
set @order_id = last_insert_id();

-- insert order items
insert into order_items (order_id,product_id,quantity,subtotal)
values(@order_id,2,1,30000.00);

select * from order_items;

-- update product stock
update products set stock = stock - 1 where product_id = 2;
select * from products;

-- process payment
describe payments;
insert into payments (order_id, amount, payment_status)
values (@order_id,54000.00,'Completed');
select * from payments;

-- update order status
update orders set status = 'Completed' where order_id = 1;
select * from orders;

-- Commit all transaction (Save all changes made)
-- commit;
rollback;






