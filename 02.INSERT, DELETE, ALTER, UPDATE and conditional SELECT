Aim: To perform INSERT, DELETE, ALTER, and UPDATE operations and retrieve employee records using conditional SELECT statements in Oracle SQL*Plus.

Commands:

1. Create Employee Table

CREATE TABLE Employee (
    Emp_ID NUMBER PRIMARY KEY,
    Emp_Name VARCHAR2(50) NOT NULL,
    Department VARCHAR2(30),
    Salary NUMBER(10,2),
    Email VARCHAR2(100)
);

Output:
Table created successfully.

2. Insert Employee Records

INSERT INTO Employee VALUES
(201,'Arun','Sales',35000,'arun@example.com');

INSERT INTO Employee VALUES
(202,'Priya','IT',52000,'priya@example.com');

INSERT INTO Employee VALUES
(203,'Ravi','Operations',41000,'ravi@example.com');

INSERT INTO Employee VALUES
(204,'Sneha','Sales',46000,'sneha@example.com');

INSERT INTO Employee VALUES
(205,'Kiran','IT',60000,'kiran@example.com');

INSERT INTO Employee VALUES
(206,'Divya','Operations',39000,'divya@example.com');

COMMIT;

Output:
6 employee records inserted successfully.

3. Display All Employee Records

SELECT * FROM Employee
ORDER BY Emp_ID;

Output:
EMP_ID  EMP_NAME  DEPARTMENT  SALARY     EMAIL
201     Arun      Sales       35000.00   arun@example.com
202     Priya     IT          52000.00   priya@example.com
203     Ravi      Operations  41000.00   ravi@example.com
204     Sneha     Sales       46000.00   sneha@example.com
205     Kiran     IT          60000.00   kiran@example.com
206     Divya     Operations  39000.00   divya@example.com


4. Update Salary of Sales Department Employees by 10%

UPDATE Employee
SET Salary = Salary * 1.10
WHERE Department = 'Sales';

Output:
2 rows updated.

Updated salaries:
SELECT Emp_Name, Salary
FROM Employee
WHERE Department = 'Sales'
ORDER BY Emp_ID;

EMP_NAME  SALARY
Arun      38500.00
Sneha     50600.00

5. Retrieve Employees Whose Salary Is at Least 45000

SELECT Emp_Name, Salary
FROM Employee
WHERE Salary >= 45000
ORDER BY Salary DESC;

Output:
EMP_NAME  SALARY
Kiran     60000.00
Priya     52000.00
Sneha     50600.00

6. Add Phone Column to Employee Table

ALTER TABLE Employee
ADD (Phone VARCHAR2(15));

Output:
Table altered successfully.

7. Update Phone Number of Employee 201

UPDATE Employee
SET Phone = '9000000201'
WHERE Emp_ID = 201;

COMMIT;

Output:
  1 row updated. Phone number set for employee 201.

8. Delete Employee 206 from Operations Department

DELETE FROM Employee
WHERE Department = 'Operations'
AND Emp_ID = 206;

COMMIT;

Output:
1 row deleted. Employee 206 (Divya) deleted successfully. Employee 203 (Ravi) remains in the table.

9. Count the Remaining Employees

SELECT COUNT(*) AS Final_Count
FROM Employee;

Output:
FINAL_COUNT
5

10. Display the Structure of the Employee Table

SELECT COLUMN_NAME, DATA_TYPE, DATA_LENGTH,
       DATA_PRECISION, DATA_SCALE, NULLABLE
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'EMPLOYEE'
ORDER BY COLUMN_ID;

Output:
COLUMN_NAME  DATA_TYPE  DATA_LENGTH
EMP_ID       NUMBER     22
EMP_NAME     VARCHAR2   50
DEPARTMENT   VARCHAR2   30
SALARY       NUMBER     22
EMAIL        VARCHAR2   100
PHONE        VARCHAR2   15
