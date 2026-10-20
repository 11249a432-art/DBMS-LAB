Aim: To demonstrate advanced SQL queries, including subqueries, IN, EXISTS, NOT EXISTS, and set operators such as UNION and INTERSECT using a library management system in Oracle SQL*Plus.

Commands:
  
1. Create the Books Table
  
CREATE TABLE Books (
    book_id NUMBER PRIMARY KEY,
    title VARCHAR2(100) NOT NULL,
    category VARCHAR2(40),
    price NUMBER(8,2)
);

Output:
Table created.

2. Create the Members Table
  
CREATE TABLE Members (
    member_id NUMBER PRIMARY KEY,
    member_name VARCHAR2(60) NOT NULL,
    city VARCHAR2(40)
);

Output:
Table created.

3. Create the Loans Table
  
CREATE TABLE Loans (
    loan_id NUMBER PRIMARY KEY,
    book_id NUMBER,
    member_id NUMBER,
    loan_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

Output:
Table created.

4. Insert Book Records
  
INSERT ALL
    INTO Books VALUES (1,'Database Systems','DBMS',650)
    INTO Books VALUES (2,'Python Basics','Programming',450)
    INTO Books VALUES (3,'Computer Networks','Networking',700)
    INTO Books VALUES (4,'SQL Practice','DBMS',500)
    INTO Books VALUES (5,'Algorithms','Programming',800)
SELECT * FROM DUAL;

COMMIT;

Output:
5 rows created.

Commit complete.

5. Insert Member Records
  
INSERT ALL
    INTO Members VALUES (101,'Arun','Chennai')
    INTO Members VALUES (102,'Priya','Hyderabad')
    INTO Members VALUES (103,'Ravi','Chennai')
    INTO Members VALUES (104,'Sneha','Bengaluru')
SELECT * FROM DUAL;

COMMIT;

Output:
4 rows created.

Commit complete.

6. Insert Loan Records
  
INSERT ALL
    INTO Loans VALUES (1001,1,101,DATE '2026-01-10')
    INTO Loans VALUES (1002,2,102,DATE '2026-01-12')
    INTO Loans VALUES (1003,4,103,DATE '2026-02-01')
SELECT * FROM DUAL;

COMMIT;

Output:
3 rows created.

Commit complete.

7. Retrieve Books Priced Above the Average Price
  
SELECT title, price
FROM Books
WHERE price > (SELECT AVG(price) FROM Books)
ORDER BY price;

Output:
TITLE                 PRICE
Database Systems      650
Computer Networks     700
Algorithms            800

3 rows selected.

8. Retrieve Books That Have Been Loaned Using IN
  
SELECT title
FROM Books
WHERE book_id IN (SELECT book_id FROM Loans)
ORDER BY title;

Output:
TITLE
Database Systems
Python Basics
SQL Practice

3 rows selected.

9. Retrieve Loaned Books Using EXISTS
  
SELECT title
FROM Books b
WHERE EXISTS (
    SELECT 1
    FROM Loans l
    WHERE l.book_id = b.book_id
)
ORDER BY title;

Output:
TITLE
Database Systems
Python Basics
SQL Practice

3 rows selected.

10. Retrieve Books That Have Not Been Loaned Using NOT EXISTS
  
SELECT title
FROM Books b
WHERE NOT EXISTS (
    SELECT 1
    FROM Loans l
    WHERE l.book_id = b.book_id
)
ORDER BY title;

Output:
TITLE
Algorithms
Computer Networks

2 rows selected.

11. Demonstrate the UNION Operator
  
SELECT book_id
FROM Books
WHERE category = 'DBMS'
UNION
SELECT book_id
FROM Loans
ORDER BY book_id;

Output:
   BOOK_ID
         1
         2
         4

3 rows selected.

12. Demonstrate the INTERSECT Operator
  
SELECT book_id
FROM Books
WHERE category = 'DBMS'
INTERSECT
SELECT book_id
FROM Loans
ORDER BY book_id;

Output:
   BOOK_ID
         1

1 row selected.

13. Count Books, Members, and Loans
  
SELECT
    (SELECT COUNT(*) FROM Books) AS books,
    (SELECT COUNT(*) FROM Members) AS members,
    (SELECT COUNT(*) FROM Loans) AS loans
FROM DUAL;

Output:
     BOOKS    MEMBERS      LOANS
         5          4          3

1 row selected.
