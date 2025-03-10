#Analytical functions
#it performs calculations across set of rows related to current row.
#unlike aggregate functions, which returns a single value for
#a group of rows, analytical functions returns multiple values
#while preserving individual row details.

use starexdb;
create table test (val integer);

insert into test values (20),(30),(15),(30),(80),
(35),(35),(42),(67),(67);

#rank() - assigns rank based on order specified
select val from test order by val desc;

#assign rank based on the order specified
#Ties - get the same rank, but the next rank skip numbers
select val,rank() over (order by val desc) as _rank from test;
select val,rank() over (order by val asc) as _rank from test;

#dense_rank() - similar to rank, but does not skip ranking numbers after ties
select val,rank() over (order by val desc) as _rank,
dense_rank() over (order by val desc) as _dense_rank from test;

#row_number() - assignes a unique sequential row number to each record
select val,row_number() over(order by val desc) from test;

select max(val) from test;
select val,first_value(val) over(order by val desc) as max_val 
from test;

select val,first_value(val) over() as max_val 
from test;

select val,last_value(val) over(order by val desc
range between unbounded preceding and  unbounded following) 
as min_val
from test;

select * from test;
#lag - retrieves the previous row's value, first row gets null
select val , lag(val,1) over(order by val desc) from test;

#lead - retrieves the next row's value, last row gets null
select val , lead(val,1) over(order by val desc) from test;

#NTILE() - Distributes rows into N equal parts
select val, ntile(2) over(order by val desc) from test;

select val, ntile(4) over(order by val desc) from test;

#cume_dist() - shows the cumulative percentage of values less
#than or equal to the current row

select val , cume_dist() over() from test;
select val , cume_dist() over(order by val asc) from test;
select val , cume_dist() over(order by val desc) from test;

select avg(val) from test;
select val,avg(val) over() from test;
