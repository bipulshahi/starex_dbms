use ecoomerce;

show tables;
describe order_items;
describe orders;
select * from products;
describe payments;
select * from customers;
select * from payments;
select * from orders;


delimiter $$
create procedure process_order_transaction(IN c_id int, 
IN p_id int, IN amt decimal(10,2), IN pay varchar(20))
begin

declare p_status varchar(20);
declare o_id int;

-- start transaction within procedure
start transaction;

-- create order
insert into orders (customer_id,total_amount,status)
values(c_id,amt,'Pending');

-- get the last inserted order id
set @o_id = last_insert_id();
-- select @order_id;
-- insert order items
insert into order_items (order_id,product_id,quantity,subtotal) values(@o_id,p_id,1,amt);

-- update product stock
update products set stock = stock - 1 where product_id = p_id;

-- process payment
insert into payments (order_id, amount, payment_status) values (@o_id,amt,pay);

-- check payment status
select payment_status into p_status from payments where order_id = @o_id;

-- if payment failed then rollback everything
if p_status = 'Failed' then
	rollback;
    select 'Transaction failed! Order and payment rolled back'
    as message;
else
	update orders set status = 'Completed' 
    where order_id = @o_id;
	commit;
    select 'Transaction commited successfully' as message;
end if;
end$$
delimiter ;

call process_order_transaction(1, 2, 30000.00,'Failed');

-- drop procedure process_order_transaction;