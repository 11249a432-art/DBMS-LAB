Aim: To demonstrate database constraints such as PRIMARY KEY, NOT NULL, UNIQUE, DEFAULT, CHECK, and FOREIGN KEY using an online retail order management system in Oracle SQL*Plus.

Commands:
  
1. Create the Customers Table
  
CREATE TABLE Customers (
    customer_id NUMBER PRIMARY KEY,
    customer_name VARCHAR2(60) NOT NULL,
    email VARCHAR2(100) UNIQUE,
    city VARCHAR2(40) DEFAULT 'Unknown'
);

Output:
Table created.

2. Create the Products Table
  
CREATE TABLE Products (
    product_id NUMBER PRIMARY KEY,
    product_name VARCHAR2(60) NOT NULL,
    price NUMBER(10,2) CHECK (price > 0),
    stock NUMBER DEFAULT 0 CHECK (stock >= 0)
);

Output:
Table created.

3. Create the Orders Table
  
CREATE TABLE Orders (
    order_id NUMBER PRIMARY KEY,
    customer_id NUMBER NOT NULL,
    product_id NUMBER NOT NULL,
    quantity NUMBER NOT NULL CHECK (quantity > 0),
    order_status VARCHAR2(20) DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

Output:
Table created.

4. Insert Customer Records
  
INSERT ALL
    INTO Customers VALUES (201,'Arun','arun@example.com','Chennai')
    INTO Customers VALUES (202,'Priya','priya@example.com','Hyderabad')
    INTO Customers VALUES (203,'Ravi','ravi@example.com','Unknown')
SELECT * FROM DUAL;

COMMIT;

Output:
3 rows created.

Commit complete.

5. Insert Product Records
  
INSERT ALL
    INTO Products VALUES (301,'Keyboard',1200,20)
    INTO Products VALUES (302,'Mouse',600,35)
    INTO Products VALUES (303,'Monitor',9500,10)
SELECT * FROM DUAL;

COMMIT;

Output:
3 rows created.

Commit complete.

6. Insert Order Records
  
INSERT ALL
    INTO Orders VALUES (401,201,301,2,'Shipped')
    INTO Orders VALUES (402,202,303,1,'Pending')
    INTO Orders VALUES (403,203,302,3,'Processing')
SELECT * FROM DUAL;

COMMIT;

Output:
3 rows created.

Commit complete.

7. Display All Orders
  
SELECT * FROM Orders
ORDER BY order_id;


Output:
  ORDER_ID CUSTOMER_ID PRODUCT_ID   QUANTITY ORDER_STATUS
       401         201        301          2 Shipped
       402         202        303          1 Pending
       403         203        302          3 Processing

3 rows selected.

8. Display Customer Details
  
SELECT customer_id, customer_name, email, city
FROM Customers
ORDER BY customer_id;

Output:
CUSTOMER_ID CUSTOMER_NAME EMAIL                CITY
        201 Arun          arun@example.com     Chennai
        202 Priya         priya@example.com    Hyderabad
        203 Ravi          ravi@example.com     Unknown

3 rows selected.

9. Demonstrate the NOT NULL Constraint
  
INSERT INTO Customers (customer_id, customer_name, email)
VALUES (204, NULL, 'x@example.com');

Output:
ERROR at line 1:
ORA-01400: cannot insert NULL into
("CUSTOMERS"."CUSTOMER_NAME")

10. Demonstrate the UNIQUE Constraint
  
INSERT INTO Customers
VALUES (205, 'Duplicate email', 'arun@example.com', 'Chennai');

Output:
ERROR at line 1:
ORA-00001: unique constraint violated


11. Demonstrate the CHECK Constraint on Price
  
INSERT INTO Products
VALUES (304, 'Invalid price', -1, 3);

Output:
ERROR at line 1:
ORA-02290: check constraint violated

12. Demonstrate the FOREIGN KEY Constraint
  
INSERT INTO Orders
VALUES (404, 999, 301, 1, 'Shipped');

Output:
ERROR at line 1:
ORA-02291: integrity constraint violated
- parent key not found

13. Demonstrate the CHECK Constraint on Quantity
  
INSERT INTO Orders
VALUES (405, 201, 301, 0, 'Shipped');

Output:
ERROR at line 1:
ORA-02290: check constraint violated

14. Display the Orders Table Structure
  
SELECT
    uc.constraint_name,
    uc.constraint_type,
    ucc.column_name
FROM user_constraints uc
JOIN user_cons_columns ucc
    ON uc.constraint_name = ucc.constraint_name
WHERE uc.table_name = 'ORDERS'
ORDER BY uc.constraint_name, ucc.position;

Output:
CONSTRAINT_NAME       CONSTRAINT_TYPE COLUMN_NAME
SYS_C0012345          C               QUANTITY
SYS_C0012346          P               ORDER_ID
SYS_C0012347          R               CUSTOMER_ID
SYS_C0012348          R               PRODUCT_ID
SYS_C0012349          C               CUSTOMER_ID
SYS_C0012350          C               PRODUCT_ID

6 rows selected.
