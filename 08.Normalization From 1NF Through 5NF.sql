Aim: To study and implement database normalization from First Normal Form (1NF) to Fifth Normal Form (5NF) using a university course registration and academic resource management database.

Commands:
  
1. Create the Student Table
  
CREATE TABLE Student (
    Student_ID NUMBER PRIMARY KEY,
    Student_Name VARCHAR2(60) NOT NULL,
    Department VARCHAR2(20)
);

Output:
Table created.

2. Create the StudentCourse1NF Table
  
CREATE TABLE StudentCourse1NF (
    Student_ID NUMBER,
    Course VARCHAR2(50),
    Faculty VARCHAR2(50),
    PRIMARY KEY (Student_ID, Course),
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID)
);

Output:
Table created.

3. Insert Student and Course Records
  
INSERT ALL
    INTO Student VALUES (1, 'Ravi', 'CSE')
    INTO Student VALUES (2, 'Anu', 'CSE')
    INTO Student VALUES (3, 'Bala', 'ECE')
SELECT * FROM DUAL;

INSERT ALL
    INTO StudentCourse1NF VALUES (1, 'DBMS', 'Kumar')
    INTO StudentCourse1NF VALUES (1, 'Python', 'Priya')
    INTO StudentCourse1NF VALUES (2, 'DBMS', 'Kumar')
    INTO StudentCourse1NF VALUES (3, 'Python', 'Priya')
    INTO StudentCourse1NF VALUES (3, 'AI', 'Raj')
SELECT * FROM DUAL;

COMMIT;

Output:
3 rows created.
5 rows created.
Commit complete.

4. Display the 1NF Records
  
SELECT *
FROM StudentCourse1NF
ORDER BY Student_ID, Course;

Output:
STUDENT_ID COURSE   FACULTY
1          DBMS     Kumar
1          Python   Priya
2          DBMS     Kumar
3          AI       Raj
3          Python   Priya

5 rows selected.

1NF is demonstrated because each row contains one student-course combination, with atomic values in each column.
  
5. Create Course and Enrollment Tables for 2NF and 3NF
  
CREATE TABLE Course (
    Course_ID NUMBER PRIMARY KEY,
    Course_Name VARCHAR2(50) UNIQUE,
    Faculty VARCHAR2(50)
);

CREATE TABLE Enrollment (
    Student_ID NUMBER,
    Course_ID NUMBER,
    PRIMARY KEY (Student_ID, Course_ID),
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

Output:
Table created.
Table created.

6. Insert Course and Enrollment Records
  
INSERT ALL
    INTO Course VALUES (10, 'DBMS', 'Kumar')
    INTO Course VALUES (11, 'Python', 'Priya')
    INTO Course VALUES (12, 'AI', 'Raj')
SELECT * FROM DUAL;

INSERT ALL
    INTO Enrollment VALUES (1, 10)
    INTO Enrollment VALUES (1, 11)
    INTO Enrollment VALUES (2, 10)
    INTO Enrollment VALUES (3, 11)
    INTO Enrollment VALUES (3, 12)
SELECT * FROM DUAL;

COMMIT;

Output:
3 rows created.
5 rows created.
Commit complete.

7. Retrieve Student Names and Course Names
  
SELECT s.Student_Name, c.Course_Name
FROM Enrollment e
JOIN Student s ON e.Student_ID = s.Student_ID
JOIN Course c ON e.Course_ID = c.Course_ID
ORDER BY s.Student_ID, c.Course_ID;

Output:
STUDENT_NAME COURSE_NAME
Ravi         DBMS
Ravi         Python
Anu          DBMS
Bala         Python
Bala         AI

5 rows selected.

This design separates student details, course details, and enrollment records, helping eliminate partial and transitive dependencies.
  
8. Create Tables for 4NF
  
CREATE TABLE StudentSkill (
    Student_ID NUMBER,
    Skill VARCHAR2(40),
    PRIMARY KEY (Student_ID, Skill),
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID)
);

CREATE TABLE StudentHobby (
    Student_ID NUMBER,
    Hobby VARCHAR2(40),
    PRIMARY KEY (Student_ID, Hobby),
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID)
);

Output:
Table created.
Table created.

9. Insert Skills and Hobbies
  
INSERT ALL
    INTO StudentSkill VALUES (1, 'SQL')
    INTO StudentSkill VALUES (1, 'Java')
    INTO StudentSkill VALUES (2, 'SQL')
SELECT * FROM DUAL;

INSERT ALL
    INTO StudentHobby VALUES (1, 'Chess')
    INTO StudentHobby VALUES (1, 'Music')
    INTO StudentHobby VALUES (2, 'Reading')
SELECT * FROM DUAL;

COMMIT;

Output:
3 rows created.
3 rows created.
Commit complete.

10. Display Student Skills and Hobbies
  
SELECT * FROM StudentSkill ORDER BY Student_ID, Skill;

SELECT * FROM StudentHobby ORDER BY Student_ID, Hobby;

Output:
STUDENT_ID SKILL
1          Java
1          SQL
2          SQL

3 rows selected.

STUDENT_ID HOBBY
1          Chess
1          Music
2          Reading

3 rows selected.

In 4NF, independent multivalued facts such as skills and hobbies are stored in separate tables to avoid unnecessary combinations.
  
11. Create the SupplyRaw Table for 5NF
  
CREATE TABLE SupplyRaw (
    SupplierID NUMBER,
    PartID NUMBER,
    ProjectID NUMBER,
    PRIMARY KEY (SupplierID, PartID, ProjectID)
);

Output:
Table created.

12. Insert Supplier-Part-Project Records
  
INSERT ALL
    INTO SupplyRaw VALUES (1, 10, 100)
    INTO SupplyRaw VALUES (1, 11, 100)
    INTO SupplyRaw VALUES (2, 10, 101)
SELECT * FROM DUAL;

COMMIT;

Output:
3 rows created.
Commit complete.

13. Create Pairwise Relations for 5NF
  
CREATE TABLE SupplierPart (
    SupplierID NUMBER,
    PartID NUMBER,
    PRIMARY KEY (SupplierID, PartID)
);

CREATE TABLE SupplierProject (
    SupplierID NUMBER,
    ProjectID NUMBER,
    PRIMARY KEY (SupplierID, ProjectID)
);

CREATE TABLE PartProject (
    PartID NUMBER,
    ProjectID NUMBER,
    PRIMARY KEY (PartID, ProjectID)
);

Output:
Table created.
Table created.
Table created.

14. Populate the Pairwise Relations
  
INSERT INTO SupplierPart
SELECT DISTINCT SupplierID, PartID
FROM SupplyRaw;

INSERT INTO SupplierProject
SELECT DISTINCT SupplierID, ProjectID
FROM SupplyRaw;

INSERT INTO PartProject
SELECT DISTINCT PartID, ProjectID
FROM SupplyRaw;

COMMIT;

Output:
3 rows created.
2 rows created.
3 rows created.
Commit complete.

15. Display the Decomposed Relations
  
SELECT * FROM SupplierPart ORDER BY SupplierID, PartID;

SELECT * FROM SupplierProject ORDER BY SupplierID, ProjectID;

SELECT * FROM PartProject ORDER BY PartID, ProjectID;

Output — SupplierPart:
SUPPLIERID PARTID
1          10
1          11
2          10

3 rows selected.

Output — SupplierProject:
SUPPLIERID PROJECTID
1          100
2          101

2 rows selected.

Output — PartProject:
PARTID PROJECTID
10     100
10     101
11     100

3 rows selected.

The supplier-part-project relationship is decomposed into pairwise relations. This illustrates 5NF decomposition; a valid 5NF decomposition must preserve the original information when the relations are joined back together.

16. Display the Final 1NF Table
  
SELECT *
FROM StudentCourse1NF
ORDER BY Student_ID, Course;

Output:
STUDENT_ID COURSE   FACULTY
1          DBMS     Kumar
1          Python   Priya
2          DBMS     Kumar
3          AI       Raj
3          Python   Priya

5 rows selected.
