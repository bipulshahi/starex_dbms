CREATE TABLE movies (
    movie_id SERIAL PRIMARY KEY,
    movie_name VARCHAR(100) NOT NULL,
    total_seats INT NOT NULL,
    available_seats INT NOT NULL
);

CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    movie_id INT REFERENCES movies(movie_id),
    customer_name VARCHAR(100) NOT NULL,
    seat_count INT NOT NULL,
    booking_status VARCHAR(20) CHECK (booking_status IN ('Pending', 'Confirmed', 'Canceled'))
);

insert into movies (movie_name,total_seats,available_seats)
values ('Avengers Endgame', 100 , 100), ('Inception' , 80 , 75) , ('The Dark knight' , 90 , 80);

insert into bookings(movie_id, customer_name, seat_count, booking_status) 
values (1, 'Rahul' , 3 , 'Confirmed'), (2, 'Jai' , 4 , 'Canceled'), (3, 'Vinay' , 2 , 'Pending'),
(2, 'Jai' , 4 , 'Confirmed');

select * from movies;
select * from bookings;

start transaction;
select available_seats from movies where movie_id = 1;

insert into bookings(movie_id, customer_name, seat_count, booking_status) values (1, 'Karan' , 2 , 'Pending')
returning booking_id;   -- returning booking_id gets the newly created booking_id to track the booking

update movies set available_seats = available_seats - 2 where movie_id = 1;      -- temporarily reserve seats

-- create a save point before payment
savepoint before_payment;


-- successfull payment
/*
update bookings set booking_status = 'Confirmed' where booking_id = 1;
commit;
*/

-- unsuccessfull payment
rollback to before_payment;
update movies set available_seats = available_seats + 2 where movie_id = 1;
update bookings set booking_status = 'Canceled' where booking_id = 1;













