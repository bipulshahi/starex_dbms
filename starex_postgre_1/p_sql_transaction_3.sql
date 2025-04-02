select * from movies;
select * from bookings;
select * from payments

create table payments (payment_id serial primary key,
booking_id int references bookings(booking_id),
amount decimal(10,2) not null,
payment_status varchar(20) CHECK (payment_status IN ('Pending', 'Completed', 'Failed')));

-- drop function process_ticket_booking;

create or replace procedure process_ticket_booking(
	IN c_name varchar(100),
	IN m_id int,
	IN seat_count int,
	IN amt decimal(10,2),
	IN pay_status varchar(20)
)
language plpgsql
as $$   
declare b_id int;    -- variable to store booking_id
BEGIN           -- this is part of PlSQL syntax, every function or procedure in PostGRE must start with BEFIN...END	  
	-- BEGIN; no need of it inside procedure
-- step 1 - insert a new booking with status pending
insert into bookings(movie_id, customer_name, seat_count, booking_status) values (m_id, c_name , seat_count , 'Pending')
returning booking_id into b_id;

-- step 2 -reduce available seats
update movies set available_seats = available_seats - seat_count where movie_id = m_id;      -- temporarily reserve seats

-- step 3
-- define save point before payment
savepoint before_payment;

-- step 4 - check payment status
if pay_status = 'Failed' then 
	rollback to before_payment;
	update bookings set booking_status = 'Cancelled' where booking_id = b_id;
	insert into payments (booking_id, amount, payment_status) values (b_id, amt, 'Failed');
	commit;
	raise notice 'transaction Successfull! Booking Cancelled, Payment Failed';
else
	insert into payments (booking_id, amount, payment_status) values (b_id, amt, pay_status);
	update bookings set booking_status = 'Confirmed' where booking_id = b_id;
	commit;
	raise notice 'transaction Successfull! Booking Confirmed';
end if;
END;
$$;

select * from bookings;

call process_ticket_booking('Pavan',1,2,500.00,'Completed');

call process_ticket_booking('Raj',1,2,500.00,'Failed');

select * from movies;
select * from bookings;
select * from payments;



