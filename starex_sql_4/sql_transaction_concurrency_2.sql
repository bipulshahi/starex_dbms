USE ecommerce;

show tables;

start transaction;

-- create order
insert into orders (customer_id, total_amount, status)
values
(2, 30000.00, 'Pending');
set @order_id = last_insert_id();

-- add order items
insert into order_items (order_id, product_id, quantity, subtotal)
values
(@order_id,2,1,30000.00);  -- 1 smartphone

-- update stock
update products set stock = stock-1 where product_id = 2;

-- Payment processing
insert into payments (order_id,amount,payment_status)
values
(@order_id,30000.00,'Failed');

-- check payment status, if failed, rollback
select payment_status from payments where order_id = @order_id into @status;

ROLLBACK;
-- commit;

