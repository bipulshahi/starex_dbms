-- employees_details
use starexdb;
show tables;
select * from employees_details;

-- to avoid deadlock -1
	-- lock table in same order
	-- modify transaction so they always lock rows in the same sequence

-- session 1
start transaction;
update employees_details set salary = salary + 1000
where employee_id = 1;
update employees_details set salary = salary + 2000
where employee_id = 2;
commit;

-- session 2
start transaction;
update employees_details set salary = salary + 1000
where employee_id = 1;
update employees_details set salary = salary + 2000
where employee_id = 2;
commit;

-- avoid deadlock -2
	-- set timeout for transactions
set innodb_lock_wait_timeout = 5;

-- avoid deadlock -3
	-- keep transactions short and fast
start transaction;
update employees_details set salary = salary + 1000
where employee_id = 1;
commit;

-- avoid deadlock -4
	-- use explicit locking
    -- this will lock the row and prevents deadlock
start transaction;
select salary from employees_details 
where employee_id = 1 for update;
update employees_details set salary = salary + 1000
where employee_id = 1;
commit;