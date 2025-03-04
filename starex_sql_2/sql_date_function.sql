#SQL - date time functions

select now(); 		 #returns the current date and time
select curdate();    #returns current date
select curtime();    #returns current time

select datediff(curdate() , '2023-12-01') as numofdays;    
#to calculate num of days between two dates

select datediff(curdate() , '2023-12-01')/365 as numofyears;
#to calculate num of days between two years

select date_add(curdate() , interval 15 day) as date_after_15_days;
select date_add(curdate() , interval 5 month) as day_after_5_months;

select date_sub(curdate() , interval 1 day);

select day(curdate()) as current_day, month(curdate()) as current_month ,
year(curdate()) as current_year;

select dayname(curdate()) as currentdayname;   #day name of current date
select last_day(curdate()) as lastdayofmonth;  #last day of month
select dayofyear(curdate()) as dayofyear;
select dayofweek(curdate()) as dayofweek;

select date_format(curdate() , '%d-%m-%Y');   #modify or change date format

##############################################################
select * from employees;

#Calculate the number of days employee have worked since their joining date
select first_name, join_date, datediff(curdate(),join_date) as daysworked from employees;

#Convert days to years
select first_name, join_date, round(datediff(curdate(),join_date)/365,0) 
as yearsworked from employees;

#Find employees who completed 5 years in the organisation
select first_name, join_date, round(datediff(curdate(),join_date)/365,0) 
as yearsworked from employees where round(datediff(curdate(),join_date)/365,0) >= 5 ;

#select employees who are very close to complete 5 years within next 6 month
select first_name, join_date, date_add(join_date , interval 5 year) 
as completes_5_years_on from employees where
date_add(join_date , interval 5 year) >= curdate()
and date_add(join_date , interval 5 year) <= date_add(curdate(), interval 6 month);

select first_name, join_date, date_add(join_date , interval 5 year) 
as completes_5_years_on from employees where
date_add(join_date , interval 5 year) 
between curdate() and date_add(curdate(), interval 6 month);

select date_add(curdate(), interval 6 month);

#Find month and year of joining of each employee
select first_name , monthname(join_date) as joining_month,
dayname(join_date) as joining_day, year(join_date) as join_year from employees;

#Format date columns a day-month-year
select first_name, date_format(join_date , '%d-%m-%Y') as formatted_date from employees;
select first_name, date_format(join_date , '%d-%M-%Y') as formatted_date from employees;
select first_name, date_format(join_date , '%d-%b-%Y') as formatted_date from employees;
















 