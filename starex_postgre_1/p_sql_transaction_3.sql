-- update bookings table and payments table with Canceled and Failed in case payment failed


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
declare b_id int;
BEGIN
	BEGIN         -- explicit transaction
		insert into bookings(movie_id,customer_name,seat_count,booking_status)
		values(m_id,c_name,seat_count,'Pending') returning booking_id into b_id;

		if pay_status = 'Failed' then
			update bookings set booking_status = 'Canceled' where booking_id = b_id;
			insert into payments(booking_id,amount,payment_status)
			values(b_id,amt,pay_status);
			raise notice 'Payment failed, Booking cancelled!';
		else
			insert into payments(booking_id,amount,payment_status)
			values(b_id,amt,pay_status);
			update bookings set booking_status = 'Confirmed' where booking_id = b_id;
		end if;
		commit;
	END;
END;
$$;




select * from bookings;

call process_ticket_booking('Saroj',1,2,500.00,'Completed');

call process_ticket_booking('Raj',1,2,500.00,'Failed');

select * from movies;
select * from bookings;
select * from payments;
