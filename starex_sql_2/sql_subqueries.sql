#Subqueries - exist, in, all ,any
show databases;
use starexdb;
show tables;

create table students(student_id int primary key,
name varchar(30), score int, class int, join_date date);

insert into students values(1, 'Amir', 85, 10, '2022-08-15'),
(2, 'Raman', 92, 10, '2023-01-10'),
(3, 'Ajay', 70, 11, '2021-07-25'),
(4, 'Pavan', 60, 10, '2022-08-20'),
(5, 'Raj', 55, 11, '2022-09-05'),
(6, 'Gagan', 78, 12, '2020-06-30'),
(7, 'Sanjeev', 90, 12, '2022-12-01'),
(8, 'Henry', 65, 11, '2023-03-11');

select * from students;
#select student who scored least
select * from students where score in (select min(score) from students);
select * from students where score = (select min(score) from students);

#find lowest-scoring student in each class
select name,score,class from students s1;
select min(score) as min_score from students s2;

select name,score,class from students s1 
where score = (select min(score) as min_score from students s2 where s1.class=s2.class);

#exist => chick if 'Henry' exist in the data table
select * from students;
select * from students where name = 'Henry';
select 1 from students where name = 'Henry';

select * from students 
where exists(select 1 from students where name = 'Henry');

select * from students 
where exists(select 1 from students where name = 'James');

#find student who have same score as someone in class 10. - #IN()
select * from students where score in(select score from students where class = 10);
select * from students where score > all(select score from students where class = 10);

#find students whose scores are higher than all students in class 11. - #all()
select * from students where score > all(select score from students where class = 11);

#find out students who score more then atleast 1 student of class 11 - any()
select * from students where score > any(select score from students where class = 11);

#count total number of students
select count(*) as total_count from students;

#find highest and lowest scores
select max(score) as max_score, min(score) as min_score from students;

#find average of all scores
select avg(score) as avg_score from students;

#find total of all scores
select sum(score) as avg_score from students;

#find number of students in each class
select class,count(*) from students group by class;

#find length of each student name
select name,length(name) from students;

#replace 'a' with 'A' in student names
select name, replace(name , 'a' , 'A') from students;

#Concatenate name and class
select concat(name , ' ' , class) from students;

#find student who joined in year 2022
select * from students where year(join_date)=2022;

#find student who joined in year august 2022
select * from students where year(join_date) = 2022 and month(join_date) = 8;

#find student who joined on 15th day of any month
select * from students where day(join_date) = 15;

#Find how many days each student has been in school
select curdate();
select datediff(curdate() , join_date) as number_of_days from students;

#Find student who score greater then 80
select * from students where score > 80;

#Find student who score lesser then 70
select * from students where score < 70;

#Find student who scored 60 or more
select * from students where score >= 60;

#Find student who score between then 50 and 90
select * from students where score between 50 and 90;

#Find student who joined between then 2021-01-01 and 2023-01-01
select * from students where join_date between '2021-01-01' and '2023-01-01';




