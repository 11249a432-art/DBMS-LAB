Aim: To create a Student table and demonstrate information retrieval using filtering, sorting, pattern matching, aggregate functions, and top-record selection in Oracle SQL*Plus.

Commands:
    
1. Create the Student Table

CREATE TABLE Student (
    Student_ID NUMBER PRIMARY KEY,
    Student_Name VARCHAR2(50) NOT NULL,
    Department VARCHAR2(20) NOT NULL,
    Year NUMBER NOT NULL,
    Age NUMBER,
    Gender VARCHAR2(10),
    Marks NUMBER(5,2),
    City VARCHAR2(30)
);

Output:
Table created.


2. Insert Student Records

INSERT ALL
    INTO Student VALUES (101,'Arun','CSE',2,19,'Male',85,'Chennai')
    INTO Student VALUES (102,'Priya','ECE',3,20,'Female',92,'Hyderabad')
    INTO Student VALUES (103,'Ravi','CSE',2,19,'Male',67,'Vijayawada')
    INTO Student VALUES (104,'Sneha','AIML',1,18,'Female',88,'Bengaluru')
    INTO Student VALUES (105,'Kiran','EEE',4,21,'Male',56,'Chennai')
    INTO Student VALUES (106,'Divya','CSE',3,20,'Female',94,'Tirupati')
    INTO Student VALUES (107,'Rahul','MECH',2,19,'Male',72,'Nellore')
    INTO Student VALUES (108,'Anjali','AIML',1,18,'Female',81,'Hyderabad')
    INTO Student VALUES (109,'Naveen','ECE',4,21,'Male',63,'Guntur')
    INTO Student VALUES (110,'Kavya','CSE',3,20,'Female',90,'Chennai')
SELECT * FROM DUAL;

COMMIT;

Output:
10 rows created.

Commit complete.


3. Display All Student Records

SELECT * FROM Student
ORDER BY Student_ID;


Output:
STUDENT_ID STUDENT_NAME DEPARTMENT YEAR AGE GENDER MARKS CITY
101        Arun         CSE        2    19  Male   85    Chennai
102        Priya        ECE        3    20  Female 92    Hyderabad
103        Ravi         CSE        2    19  Male   67    Vijayawada
104        Sneha        AIML       1    18  Female 88    Bengaluru
105        Kiran        EEE        4    21  Male   56    Chennai
106        Divya        CSE        3    20  Female 94    Tirupati
107        Rahul        MECH       2    19  Male   72    Nellore
108        Anjali       AIML       1    18  Female 81    Hyderabad
109        Naveen       ECE        4    21  Male   63    Guntur
110        Kavya        CSE        3    20  Female 90    Chennai

10 rows selected.


4. Retrieve Students from the CSE Department

SELECT Student_ID, Student_Name, Department
FROM Student
WHERE Department = 'CSE'
ORDER BY Student_ID;

Output:
STUDENT_ID STUDENT_NAME DEPARTMENT
101        Arun         CSE
103        Ravi         CSE
106        Divya        CSE
110        Kavya        CSE

4 rows selected.

5. Retrieve Students Whose Marks Are Between 70 and 90

SELECT Student_Name, Marks
FROM Student
WHERE Marks BETWEEN 70 AND 90
ORDER BY Marks ASC;

Output:
STUDENT_NAME MARKS
Rahul        72
Anjali       81
Arun         85
Sneha        88
Kavya        90

5 rows selected.


6. Retrieve Students Whose Names Begin with A

SELECT Student_ID, Student_Name
FROM Student
WHERE Student_Name LIKE 'A%'
ORDER BY Student_ID;

Output:
STUDENT_ID STUDENT_NAME
101        Arun
108        Anjali

2 rows selected.

7. Count Total Students and Departments

SELECT COUNT(*) AS Total_Students,
       COUNT(DISTINCT Department) AS Departments
FROM Student;

Output:
TOTAL_STUDENTS DEPARTMENTS
10             5

1 row selected.

8. Display the Top Three Students by Marks

SELECT Student_Name, Marks
FROM Student
ORDER BY Marks DESC
FETCH FIRST 3 ROWS ONLY;

Output:
STUDENT_NAME MARKS
Divya        94
Priya        92
Kavya        90

3 rows selected.
