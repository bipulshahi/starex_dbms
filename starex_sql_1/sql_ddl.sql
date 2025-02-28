#DDL 

show databases;

create database starexdb;

show databases;

use starexdb;

create table student (studentId int primary key, name varchar(30) , 
age int, class varchar(10));

show tables;

#add a new column
alter table student add gender varchar(10);

#modify type of name to varchar(50)
alter table student modify name varchar(50);

describe student;

drop table student;

show tables;
