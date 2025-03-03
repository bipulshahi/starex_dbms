#SQL function - string function

select length('Database') as char_len;

select concat ('Hello' , ' ' , 'World') as combined;

select lower('HELLO SQL') as lowercasetext;

select upper('hello sql') as uppercasetext;

select replace('Data Science' , 'Science' , 'Engineering') as replacedtext;

select replace('Data Science' , ' ' , '') as replacedtext;

#starts from 6th character and extract 9 characters
select substr("Data Analysis" , 6 , 9) as extractedstring;

#remove characters from string
select trim('$' from '$$100.05$$') as trimmedtext;
select trim(' ' from ' 100.05  ') as trimmedtext;

#SQL functions - Numerical functions
#Basic arthmetic - add, subtract, multiply, divide

select 50+10 , 50-10, 50*10, 50/10;
select 50%7;

select ceil(45.2);
select floor(45.9);
select round(65.87536 , 2);
select truncate(65.87536 , 2);

select least(15, 25, 35, 10);
select greatest(15, 25, 35, 10);

#SQL function - conversion function
select cast(1234  as char) as convertedtext;


























