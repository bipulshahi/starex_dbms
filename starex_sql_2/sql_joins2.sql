#joins
#inner join - returns only matching records from both tables

#left join - all records from left table and matching records from right table,
#if there is no match, NULL values will be returned

#right join - all records from right table and matching records from left table,
#if there is no match, NULL values will be returned

#full outer join - all records from both tables, 
#if there is no match null values will be returned on missing side

#self join - a table joined with itself.

use starexdb;

create table locations(
location_id int primary key,
city varchar(50),
state_province varchar(50)
);

insert into locations values (1500,'Delhi','Delhi'),(1600,'Mumbai','Maharashtra'),
(1700,'Lucknow','Uttar Pradesh');
#Inner join
show tables;
select * from employees_details;
select * from departments;
#show first_name, last_name, salary & department_name
select first_name,last_name,salary from employees_details;
select department_name from departments;

select first_name,last_name,salary,department_name from employees_details e1 
join departments d1
on e1.department_id = d1.department_id;

#show departments with location
select * from departments;
select * from locations;

select department_name,city,state_province from departments join locations
on departments.location_id = locations.location_id;

#show employees in lucknow - three table join
select * from employees_details e1 join departments d1
on e1.department_id = d1.department_id join locations l1
on l1.location_id = d1.location_id;

select * from employees_details e1 join departments d1
on e1.department_id = d1.department_id join locations l1
on l1.location_id = d1.location_id
where l1.city = 'lucknow';

select * from employees_details;
#left outer join
#All employees, even if they don't have a department
select e1.employee_id, e1.first_name, e1.last_name, e1.salary, d1.department_name 
from employees_details e1 left outer join departments d1
on e1.department_id = d1.department_id;

#right outer join
#all departments even if they don't have employees
select e1.employee_id, e1.first_name, e1.last_name, e1.salary, d1.department_name 
from employees_details e1 right outer join departments d1
on e1.department_id = d1.department_id;

#full outer join
#all employees and department, even if no match
select e1.employee_id, e1.first_name, e1.last_name, e1.salary, d1.department_name 
from employees_details e1 left outer join departments d1
on e1.department_id = d1.department_id
union
select e1.employee_id, e1.first_name, e1.last_name, e1.salary, d1.department_name 
from employees_details e1 right outer join departments d1
on e1.department_id = d1.department_id;

#self join
alter table employees_details add column manager_id int;
#update employees_details set manager_id  = 1 where employee_id in (2,3);

update employees_details set manager_id  = 
case 
when employee_id = 1 then null
when employee_id = 2 then 1
when employee_id = 3 then 1
when employee_id = 4 then 2
when employee_id = 5 then 3
when employee_id = 6 then 3
when employee_id = 7 then 2
when employee_id = 8 then 3
when employee_id = 9 then 4
when employee_id = 10 then 5
else null
end;

select * from employees_details;

#show each employee_name with their manager name
select e.employee_id, e.first_name as employee from employees_details e;
select m.manager_id, m.first_name as manager from employees_details m;

select e.employee_id, e.first_name as employee,
m.manager_id, m.first_name as manager 
from employees_details e inner join employees_details m
on e.manager_id = m.employee_id;



















