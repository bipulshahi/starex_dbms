#DML

use starexdb;

create table student (studentId int primary key, name varchar(30) , 
age int, class varchar(10));

#add a new column
alter table student add gender varchar(10);

#insert data into table
insert into student (studentid,name,age,class,gender) 
values (1, "Ajay" , 14 , 8 , "Male");

select * from student;

#update data values
update student set age = 15 where studentid=1;

insert into student (studentid,name,age,class,gender) 
values (2, "Rajesh" , 14 , 7 , "Male"),(3, "Smita" , 10 , 4 , "Female"),
(4, "Pavan" , 11 , 5 , "Male"),(5, "Swati" , 12 , 6 , "Female");

select name,age from student;

select * from student where age > 12;
select * from student where age = 12;

select * from student order by age;
select * from student order by age desc;

delete from student where name = 'rajesh';
select * from student;

#remove only data from the table keeping the table structure as it is
truncate table student;
select * from student;

#drop or delete complete table
drop table student;
show tables;
describe student;