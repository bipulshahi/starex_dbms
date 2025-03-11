use starexdb;
#Subqueries in SQL - Correlated vs Non-Correlated
#A query within another query
#It helps in filter, aggregate or compare data dynamically

#Non-correlated query
#Independent of the outer query
#executes once, and the result is used in outer query
#find employee who earn more then average salary

#correlated query
#dependent on the outer query
#execures for each row in the outer query.
#find employee who earn the highest salary in their department.

#non - Correlated -
#find employee who earn more then average salary
select first_name,last_name,salary from employees_details
where(select avg(salary) from employees_details);

#list employees who work in departments located in lucknow
select * from employees_details;
select * from departments;
select * from locations;
select first_name,last_name,salary from employees_details
where department_id in(select department_id from departments where location_id=1700);

#find employees with the same job as 'Pooja Verma'
SELECT * FROM employees_details where job_id = (SELECT job_id FROM employees_details
WHERE first_name = 'Pooja' and last_name = 'Verma');

#retrieve employees who have the highest salary
select first_name,last_name,salary from employees_details
where salary = (select max(salary) from employees_details);

#list employees who earn more than the highest paid shipping clerk
select first_name,last_name,salary from employees_details
where salary > (select max(salary) from employees_details where job_id = 'SH_CLERK');

#Correlated subqueries
#These subqueries execute once per row in the outer query
#Find employees who are higest-paid in their department
select first_name,last_name,salary,department_id from employees_details e1
where salary = (select max(salary) from employees_details e2
where e1.department_id = e2.department_id);
#here subquery fetches the highest salary for each department
#the outer query compares each employee's salary with this maximum

#Find employees who joined before anyone else in their department
select first_name,last_name,hire_date,department_id from employees_details e1
where hire_date = (select min(hire_date) from employees_details e2
where e1.department_id = e2.department_id);

#sleelct employees who earn more then the average salary of their department
select first_name,last_name,salary,department_id from employees_details e1
where salary > (select avg(salary) from employees_details e2
where e1.department_id = e2.department_id);

#find employees whose salary is higher then atleast one employee in HR department
SELECT *
FROM employees_details e1
WHERE salary >= (
    SELECT MIN(salary)
    FROM employees_details e2
    WHERE department_id = 105
);

#find employees who earn the second highest salary in their department

#employees from each department whose salary is lesser then maximum salary of their depatment
select * from employees_details e2 where salary < (SELECT MAX(salary) FROM employees_details e3
where e2.department_id = e3.department_id);

select first_name,last_name,salary,department_id from employees_details e1
where salary = (select max(salary) from employees_details e2 
where e2.department_id = e1.department_id and
e2.salary < (SELECT MAX(salary) FROM employees_details e3
where e2.department_id = e1.department_id));
#the squery to find highest salary per department
#correlated query to find second highest salary
#the outer query to fetch employees who is eaning this salary














