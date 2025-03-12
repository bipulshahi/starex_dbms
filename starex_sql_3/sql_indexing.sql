#Indexing - indexes improve query performance 
#by making data retrieval faster.
#Two types of indexing -
#1. Clustered index - determines the physical order of 
#data in the table
#each table can have only one clustered index because 
#rows can be physically orderd in 
#only one way
#Fast lookup by primary key
use starexdb;

CREATE TABLE if not exists employees_details (
	-- Clustered index is automatically created
    -- data stored physically sorted by employee_id
    employee_id INT PRIMARY KEY,  
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(10,2),
    phone_number VARCHAR(20),
    email VARCHAR(100),
    job_id VARCHAR(50),
    department_id INT,
    hire_date DATE
);

-- retrieving data using clustered index
select * from employees_details where employee_id = 5;
-- it will execute faster because MySQL directly looks up the
-- employee_id using the clusterted index

-- clustered index on range queries
select * from employees_details where employee_id between 3 and 8;
-- employee_id is physically sorted, 
-- MySQL scans the relevent range instead of searching the whole table

explain select * from employees_details where employee_id = 5;
-- storage order follows the clustered index on 'employee_id'

-- attemting to create another clustered index
create index idx_salary on employees_details(salary);
-- this will not create any clustered index as any table can have only one clustered index
-- instead it will create a non clustered index 

#2. Non-clustered indexes - 
#A non-clustered index creates a seperate structure that stores pointers to the actual data
#A table can have multiple non-clustered indexes.
#Faster searches on non-primary key columns
create index idx_salary on employees_details(salary);
-- it will create a seperate index for salary
-- that helps in speed up searches on salary column
-- it will not change the physical order of your data table

select * from employees_details where salary = 90000;
-- it will execute faster
-- instead of scanning the whole table, MySQL uses the index to locate the matching rows quickly

-- Using non-clustered index for sorting
select * from employees_details order by salary;
-- this query uses the index on salary to sort data faster

-- Composite non-clustered index
create index idx_department_salary on employees_details(department_id, salary);
-- create an index that speeds up the searches involving both department_id and salary

select * from employees_details where department_id = 103 and salary > 70000;

explain select * from employees_details where department_id = 103 and salary > 70000;
-- MySQL uses the composite index (idx_department_salary) to find result faster

-- When to use clustered index?
  -- We frequently search by primary key or range of values
  -- example- searching by employee_id

-- when to use non clustered index?
  -- We need multiple fast serches on different columns
  -- example- searching employees by salary





