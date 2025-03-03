#joins - inner , left, right, full

use starexdb;

create table students (studentid int primary key, Name varchar(20));

insert into students values (1,'Ajay'),(2,'Rohan');
insert into students values (4,'Arun');

create table courses (courseid int , course varchar(50), studentid int);

insert into courses values (101,'Math',1),(102,'Science',1),(103,'History',2);
insert into courses values (104,'English',3);

select * from students;
select * from courses;

#inner join
select students.name, courses.courseid, courses.course from students inner join courses 
on students.studentid = courses.studentid;

#left join
select students.name, courses.courseid, courses.course from students left join courses 
on students.studentid = courses.studentid;

#right join
select students.name, courses.courseid, courses.course from students right join courses 
on students.studentid = courses.studentid;

#full join
select students.name, courses.courseid, courses.course from students left join courses 
on students.studentid = courses.studentid
union
select students.name, courses.courseid, courses.course from students right join courses 
on students.studentid = courses.studentid;


