show databases;
use starexdb;
show tables;
drop table students;

create table students(
student_id int primary key,   -- unique ID for each student
name varchar(100),
age INT
);

insert into students (student_id, name, age)
values (1, "Ajay" , 22),(2,"Raju",24);

select * from students;
insert into students (student_id, name, age)
values (1, "Rahul" , 22);    -- duplicate entry for student_id = 1


-- create enrollments table
create table enrollments(
enrollment_id int primary key,
student_id int,    -- foreign key referring student_id of student table
course_name varchar(20),
foreign key (student_id) references students(student_id)
);
-- student_id in enollments refers to student_id in students
-- This ensures only valid student_id can be used in enrollments
insert into enrollments (enrollment_id,student_id,course_name) 
values (1,2,'Mathematics'),(2,1,'Science');

select * from enrollments;

insert into enrollments (enrollment_id,student_id,course_name) 
values (3,5,'Mathematics');
-- error - student_id = 5, doesn't exist in students, violating referential integrity


-- Candiate key
create table visitors(
visitor_id int,             -- candidate key 1
name varchar(50),
email varchar(100) unique,  -- candidate key 2
phone varchar(100) unique,   -- candidate key 3
primary key (visitor_id)
);

insert into visitors(visitor_id,name,email,phone) values
(1,"Ajay","ajay@abc.com","986545785"),(2,"Sanjay","sanjay@abc.com","964688457");

select * from visitors;

insert into visitors(visitor_id,name,email,phone) values
(3,"Ajay","ajay@abc.com","98545678");
-- error as email = "ajay@abc.com", violating unique constraints
