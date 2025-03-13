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

-- ROLLBACK;
-- commit;
-- use case to check status
delimiter $$
create procedure process_order_transaction()
begin
	-- declare a variable to store payment status
    declare payment_status varchar(20);
    
    -- start transaction inside procedure
    start transaction;
    
	-- check payment status
    select payment_status into payment_status from payments where order_id = @order_id;
    
    -- if payment failed, rollback everything
	if payment_status = 'Failed' then
		rollback;
        select 'Transaction failed and rollback' as message;
	else
		-- if successfull commit
		commit;
        select 'Transaction commited successfully' as message;
	end if;
end $$
delimiter ;

-- calling the procedure to test different cases
call process_order_transaction();

-- drop procedure if exists process_order_transaction;
-- drop procedure if exists process_transaction;




