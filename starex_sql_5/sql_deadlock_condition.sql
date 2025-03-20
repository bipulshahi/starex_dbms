-- Deadlock detection & prevention
-- Deadlock - it occurs when two or more transactions are waiting
	-- for each other to release locks on resources,
	-- preventing further execution.
-- In MySQL, deadlocks happen in InnoDB tables due to row-level locking.

-- employees_details
use starexdb;
show tables;
select * from employees_details;

-- create a deadlock by making two transactions
-- update the same rows in a different order
-- session 1
start transaction;
update employees_details set salary = salary + 10000
where employee_id = 1;
-- simulate delay
select SLEEP(5);
update employees_details set salary = salary + 20000
where employee_id = 2;

-- session 2
start transaction;
update employees_details set salary = salary + 20000
where employee_id = 2;
-- simulate delay
select SLEEP(5);
update employees_details set salary = salary + 10000
where employee_id = 1;


-- deadlock occurs
	-- session 1 locks employee 1 and waits for employee 2
    -- session 2 locks employee 2 and waits for employee 1
    -- one transaction rolled back automatically

-- check deadlocks in MySQL
-- this will provide details about deadlock, 
	-- including which transaction is rolled back
show engine innodb status




