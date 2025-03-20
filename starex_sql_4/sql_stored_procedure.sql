-- stored procedure - a set of SQL statements that are saved
	-- in the database and executed by calling the procedure
    -- It helps automate repetitive tasks and improves performance
    
-- stored procedure to add two numbers

delimiter $$
create procedure add_numbers(in num1 int, in num2 int , out result int)
begin
	set result = num1 + num2;
end$$
delimiter ;


call add_numbers(7,4,@sum);
select @sum as total;

-- example2

CREATE TABLE new_employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2)
);

INSERT INTO new_employees (emp_name, salary) VALUES 
('Amit Sharma', 90000),
('Pooja Verma', 45000),
('Rajesh Gupta', 120000),
('Neha Kapoor', 38000);

select * from new_employees;

delimiter $$
create procedure check_salary(in emp_id int, out salarycategory varchar(20))
begin
declare empSalary decimal(10,2);
select salary into empSalary from new_employees where emp_id = emp_id limit 1;
if empSalary > 70000 then
	set salarycategory = 'High Salary';
else
	set salarycategory = 'Low Salary';
end if;
end $$
delimiter ;

call check_salary(1,@category);
select @category as salary_status;



select salary from new_employees where emp_id = 1;

drop procedure check_salary;
