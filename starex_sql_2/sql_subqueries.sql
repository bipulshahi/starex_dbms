#Subqueries - exist, in, all ,any

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

#find highest and lowest scores

#find average of all scores

#find total of all scores

#find number of students in each class

#find length of each student name

#replace 'a' with 'A' in student names

#Concatenate name and class

#find student who joined in year 2022

#find student who joined in year august 2022

#find student who joined on 15th day of any month

#Find how many days each student has been in school

#Find student who score greater then 80

#Find student who score lesser then 70

#Find student who scored 60 or more

#Find student who score between then 50 and 90

#Find student who joined between then 2021-01-01 and 2023-01-01





