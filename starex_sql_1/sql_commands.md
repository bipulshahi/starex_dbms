SQL Documentation
1. DDL - Data Definition Language

DDL commands are used to define, modify, and manage database structures or schemas. They primarily deal with the structure of the database, not the data within it.
1.1 CREATE

    Purpose: Creates a new table, database, index, or view.
    Example:

    CREATE TABLE Employees (
        EmployeeID INT PRIMARY KEY,
        Name VARCHAR(255),
        Position VARCHAR(255),
        Salary DECIMAL(10, 2)
    );

1.2 ALTER

    Purpose: Modifies an existing database object like a table.
    Example:

    ALTER TABLE Employees
    ADD Email VARCHAR(255);

1.3 DROP

    Purpose: Deletes an entire table, database, or other database object.
    Example:

    DROP TABLE Employees;

1.4 TRUNCATE

    Purpose: Removes all records from a table but keeps the table structure for future use.
    Example:

    TRUNCATE TABLE Employees;

2. DML - Data Manipulation Language

DML commands are used for managing data within database objects.
2.1 INSERT

    Purpose: Adds new records to a table.
    Example:

    INSERT INTO Employees (EmployeeID, Name, Position, Salary)
    VALUES (1, 'John Doe', 'Manager', 75000.00);

2.2 UPDATE

    Purpose: Modifies existing records in a table.
    Example:

    UPDATE Employees
    SET Salary = 80000.00
    WHERE EmployeeID = 1;

2.3 DELETE

    Purpose: Removes records from a table.
    Example:

    DELETE FROM Employees
    WHERE EmployeeID = 1;

3. DQL - Data Query Language

DQL is used to retrieve data from the database.
3.1 SELECT

    Purpose: Fetches data from a database.
    Example:

    SELECT * FROM Employees;

4. DCL - Data Control Language

DCL commands are used to control access to data within the database.
4.1 GRANT

    Purpose: Provides users with access privileges.
    Example:

    GRANT SELECT ON Employees TO 'testuser'@'localhost';

4.2 REVOKE

    Purpose: Removes access privileges granted to users.
    Example:

REVOKE SELECT ON Employees FROM 'testuser'@'localhost';
