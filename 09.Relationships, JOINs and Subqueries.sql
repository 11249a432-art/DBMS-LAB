Aim: To create and manage an IT company project management database and perform relationships, JOIN operations, subqueries, aggregate functions, and record-count queries using Oracle SQL*Plus.

Commands:
  
1. Create the Departments Table
  
CREATE TABLE Departments (
    Department_ID NUMBER PRIMARY KEY,
    Department_Name VARCHAR2(50) UNIQUE
);

Output:
Table created.

2. Create the Employees Table
  
CREATE TABLE Employees (
    Employee_ID NUMBER PRIMARY KEY,
    Employee_Name VARCHAR2(60),
    Department_ID NUMBER,
    Salary NUMBER(10,2),
    FOREIGN KEY (Department_ID)
        REFERENCES Departments(Department_ID)
);

Output:
Table created.

3. Create the Projects Table
  
CREATE TABLE Projects (
    Project_ID NUMBER PRIMARY KEY,
    Project_Name VARCHAR2(80),
    Budget NUMBER(12,2)
);

Output:
Table created.

4. Create the Assignments Table
  
CREATE TABLE Assignments (
    Employee_ID NUMBER,
    Project_ID NUMBER,
    Hours_Worked NUMBER,
    PRIMARY KEY (Employee_ID, Project_ID),
    FOREIGN KEY (Employee_ID)
        REFERENCES Employees(Employee_ID),
    FOREIGN KEY (Project_ID)
        REFERENCES Projects(Project_ID)
);

Output:
Table created.

5. Insert Department Records
  
INSERT ALL
    INTO Departments VALUES (1, 'Engineering')
    INTO Departments VALUES (2, 'Data')
    INTO Departments VALUES (3, 'Support')
SELECT * FROM DUAL;

Output:
3 rows created.

6. Insert Employee Records
  
INSERT ALL
    INTO Employees VALUES (101, 'Arun', 1, 65000)
    INTO Employees VALUES (102, 'Priya', 2, 72000)
    INTO Employees VALUES (103, 'Ravi', 1, 58000)
    INTO Employees VALUES (104, 'Sneha', 3, 48000)
    INTO Employees VALUES (105, 'Kiran', 2, 80000)
SELECT * FROM DUAL;

Output:
5 rows created.

7. Insert Project Records
  
INSERT ALL
    INTO Projects VALUES (201, 'Website', 250000)
    INTO Projects VALUES (202, 'Analytics', 400000)
    INTO Projects VALUES (203, 'Helpdesk', 100000)
SELECT * FROM DUAL;

Output:
3 rows created.

8. Insert Assignment Records
  
INSERT ALL
    INTO Assignments VALUES (101, 201, 40)
    INTO Assignments VALUES (102, 202, 55)
    INTO Assignments VALUES (103, 201, 30)
    INTO Assignments VALUES (105, 202, 60)
    INTO Assignments VALUES (104, 203, 45)
SELECT * FROM DUAL;

COMMIT;

Output:
5 rows created.
Commit complete.

9. Display Employees with Their Departments Using JOIN
  
SELECT e.Employee_Name, d.Department_Name
FROM Employees e
JOIN Departments d
ON e.Department_ID = d.Department_ID
ORDER BY e.Employee_ID;

Output:
EMPLOYEE_NAME  DEPARTMENT_NAME
Arun           Engineering
Priya          Data
Ravi           Engineering
Sneha          Support
Kiran          Data

5 rows selected.

10. Display Employees Assigned to Projects
  
SELECT e.Employee_Name, p.Project_Name, a.Hours_Worked
FROM Assignments a
JOIN Employees e
ON a.Employee_ID = e.Employee_ID
JOIN Projects p
ON a.Project_ID = p.Project_ID
ORDER BY e.Employee_ID;

Output:
EMPLOYEE_NAME  PROJECT_NAME  HOURS_WORKED
Arun           Website       40
Priya          Analytics     55
Ravi           Website       30
Sneha          Helpdesk      45
Kiran          Analytics     60

5 rows selected.

11. Find Employees Earning More Than the Average Salary
  
SELECT Employee_Name, Salary
FROM Employees
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees
)
ORDER BY Salary DESC;

Output:
EMPLOYEE_NAME  SALARY
Kiran          80000
Priya          72000

2 rows selected.

12. Find Departments Without Employees Using NOT EXISTS
  
SELECT Department_Name
FROM Departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM Employees e
    WHERE e.Department_ID = d.Department_ID
);

Output:
no rows selected

All departments have at least one employee.
  
13. Calculate Total Project Hours Using GROUP BY
  
SELECT p.Project_Name,
       SUM(a.Hours_Worked) AS Total_Hours
FROM Projects p
JOIN Assignments a
ON p.Project_ID = a.Project_ID
GROUP BY p.Project_ID, p.Project_Name
ORDER BY p.Project_ID;

Output:
PROJECT_NAME  TOTAL_HOURS
Website       70
Analytics     115
Helpdesk      45

3 rows selected.

14. Count Departments, Employees, Projects and Assignments
  
SELECT
    (SELECT COUNT(*) FROM Departments) AS Departments,
    (SELECT COUNT(*) FROM Employees) AS Employees,
    (SELECT COUNT(*) FROM Projects) AS Projects,
    (SELECT COUNT(*) FROM Assignments) AS Assignments
FROM DUAL;

Output:
DEPARTMENTS  EMPLOYEES  PROJECTS  ASSIGNMENTS
3            5          3         5

1 row selected.
