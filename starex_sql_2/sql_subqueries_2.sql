show databases;
use starexdb;

show tables;

select * from students;

#Single row sub query
#returns only one value and is used with operators like =,>,<
#Find students from same class as 'Ajay'
select class from students where name = 'Ajay';
select * from students where class = 11;

select * from students where class = (select class from students where name = 'Ajay');

#Multiple row sub query
#returns multiple rows and is used with IN, ANY, or ALL
#Find students in classes 10 and 12
select * from students;
select student_id from students where class in (10 , 12);

select * from students where class in (10 , 12);
select * from students 
where student_id in (select student_id from students where class in (10 , 12));

alter table students add column subjects varchar(20);
select * from students;
update students set subjects = 'Science' where student_id = 1;
update students set subjects = 'Commerce' where student_id = 2;
update students set subjects = 'Art' where student_id = 3;
update students set subjects = 'Science' where student_id = 4;
update students set subjects = 'Commerce' where student_id = 5;
update students set subjects = 'Art' where student_id = 6;
update students set subjects = 'Art' where student_id = 8;
select * from students;

#Find student from 'Science' or 'Commerce'
select * from students where subjects in ('Science','Commerce');

#Find students from class having subject 'Science' or 'Commerce'
select * from students 
where class in (select class from students where subjects in ('Science','Commerce'));

#Sub query with aggregation
#Find students who scores higher then average score
select * from students where score > (select avg(score) from students);

#Correlated subquery
#Find students whose score is higher then average score in their own class
select class,avg(score) from students group by class; 

select * from students s1;
select score from students s2;
select avg(score) from students s2;

select * from students s1 where score > (select avg(score) from students s2 
where s1.class = s2.class);

create table cities (city_id int, city_name varchar(20));
insert into cities values (1,'Gurugram'),(2,'Noida');
select * from cities;

alter table students add column city_id int;
update students set city_id = 1 where student_id in (1,3,4,8);
update students set city_id = 2 where student_id in (2,5,7);
select * from students;

#Query to find students from 'Noida'
select city_id from cities where city_name = 'Noida';
select * from students 
where city_id in (select city_id from cities where city_name = 'Noida');
