#DCL - Data control language
use starexdb;
create table student (studentId int primary key, name varchar(30) , 
age int, class varchar(10));

#add a new column
alter table student add gender varchar(10);

#insert data into table
insert into student (studentid,name,age,class,gender) 
values (1, "Ajay" , 14 , 8 , "Male"),(2, "Rajesh" , 14 , 7 , "Male"),
(3, "Smita" , 10 , 4 , "Female"),
(4, "Pavan" , 11 , 5 , "Male"),(5, "Swati" , 12 , 6 , "Female");

select * from student;

#create a new user at out server
create user 'newuser'@'localhost' identified by 'password123';
#we can replace 'localhost' with '%' to allow remote access

show databases;
show tables;

grant select on starexdb.student to 'newuser'@'localhost';
flush privileges;
#to reload the privilage table

#revoking or removing permission
revoke select on starexdb.student from 'newuser'@'localhost';
flush privileges;

#grant all permissions to newuser on starexdb.student
grant all privileges on starexdb.student to 'newuser'@'localhost';
flush privileges;

show databases;

#full access to all databases
grant all privileges on *.* to 'newuser'@'localhost';
flush privileges;


#list of all users on server
select user, host from mysql.user;

#delete any user from server
drop user newuser@localhost;
#if newuser can connect from any host use - 'drop user newuser@%'

select user, host from mysql.user;

flush privileges;



