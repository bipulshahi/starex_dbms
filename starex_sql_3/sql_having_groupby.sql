#Groupby and Having in SQL-
#'group by' is used to group rows that have same values in specified columns and 
#apply aggregate functions like sum(), count(), avg() etc.
#having is used to filter grouped records (like where, but for aggregated results)

#count employees in each department
select department_id , count(*) from employees_details group by department_id;

#Find total salary paid in each department
select department_id,sum(salary) from employees_details
group by department_id;

#Find average salary for each job role
select job_id,avg(salary) from employees_details
group by job_id;

#Find highest salry in each department
select department_id,max(salary) from employees_details
group by department_id;

#Count employees who joined each year
select year(hire_date) as hiring_year, count(employee_id) as employee_count
from employees_details group by year(hire_date);


#having - to apply or implement a condition for filtering on grouped data
#find departments with more then 2 employees
select department_id, count(employee_id) as employee_count from employees_details
group by(department_id)
having count(employee_id) > 2;

#find job roles with an average salary greater then 80000.
select job_id, AVG(salary) AS avg_salary
from employees_details
group by job_id
having avg(salary) > 80000;

#find departments where total salary is more then 200,000.
select department_id, SUM(salary) as total_salary
from employees_details
group by department_id
having total_salary >=200000;

#find hiring_years where more then 2 employees were hired
select YEAR(hire_date) as hire_year, COUNT(*) as employee_count
from employees_details
group by YEAR(hire_date)
having employee_count > 2;

#find departments where the highest salary is greater then 100000
select department_id, max(salary) as high_salary
from employees_details
group by department_id
having high_salary >=100000;










