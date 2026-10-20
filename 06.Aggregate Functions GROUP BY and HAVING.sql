Aim: To demonstrate aggregate functions such as COUNT(), SUM(), AVG(), MIN(), and MAX(), along with GROUP BY and HAVING clauses, using a retail sales analysis system in Oracle SQL*Plus.

Commands:
  
1. Create the Sales Table
  
CREATE TABLE Sales (
    Sale_ID NUMBER PRIMARY KEY,
    Product VARCHAR2(50),
    Category VARCHAR2(30),
    Region VARCHAR2(30),
    Quantity NUMBER,
    Unit_Price NUMBER(10,2),
    Sale_Date DATE
);

Output:
Table created.

2. Insert Sales Records
  
INSERT ALL
    INTO Sales VALUES (1,'Laptop','Electronics','North',2,55000,DATE '2026-01-05')
    INTO Sales VALUES (2,'Phone','Electronics','South',5,18000,DATE '2026-01-07')
    INTO Sales VALUES (3,'Chair','Furniture','North',4,3500,DATE '2026-01-10')
    INTO Sales VALUES (4,'Desk','Furniture','West',2,8500,DATE '2026-01-12')
    INTO Sales VALUES (5,'Tablet','Electronics','West',3,22000,DATE '2026-02-01')
    INTO Sales VALUES (6,'Chair','Furniture','South',6,3500,DATE '2026-02-04')
    INTO Sales VALUES (7,'Phone','Electronics','North',3,18000,DATE '2026-02-10')
    INTO Sales VALUES (8,'Desk','Furniture','South',1,8500,DATE '2026-02-11')
SELECT * FROM DUAL;

COMMIT;

Output:
8 rows created.

Commit complete.

3. Calculate Aggregate Values
  
SELECT COUNT(*) AS Transactions,
       SUM(Quantity) AS Units,
       ROUND(AVG(Quantity),2) AS Avg_Quantity,
       MIN(Unit_Price) AS Min_Price,
       MAX(Unit_Price) AS Max_Price
FROM Sales;

Output:
TRANSACTIONS      UNITS AVG_QUANTITY  MIN_PRICE  MAX_PRICE
           8         26         3.25       3500      55000

1 row selected.

4. Calculate Units Sold and Revenue by Category
  
SELECT Category,
       SUM(Quantity) AS Units_Sold,
       SUM(Quantity * Unit_Price) AS Revenue
FROM Sales
GROUP BY Category
ORDER BY Category;

Output:
CATEGORY       UNITS_SOLD    REVENUE
Electronics            13   296000.00
Furniture              13    45500.00

2 rows selected.

5. Calculate Transactions and Revenue by Region
  
SELECT Region,
       COUNT(*) AS Transactions,
       SUM(Quantity * Unit_Price) AS Revenue
FROM Sales
GROUP BY Region
ORDER BY Region;

Output:
REGION         TRANSACTIONS    REVENUE
North                     3  174000.00
South                     3   71500.00
West                      2   74500.00

3 rows selected.

6. Display Categories with Revenue Greater Than 50000 Using HAVING
  
SELECT Category,
       SUM(Quantity * Unit_Price) AS Revenue
FROM Sales
GROUP BY Category
HAVING SUM(Quantity * Unit_Price) > 50000
ORDER BY Revenue DESC;

Output:
CATEGORY          REVENUE
-------------- ----------
Electronics      296000.00

1 row selected.

7. Group Sales by Category and Region
  
SELECT Category,
       Region,
       SUM(Quantity) AS Units_Sold
FROM Sales
GROUP BY Category, Region
ORDER BY Category, Region;

Output:
CATEGORY       REGION         UNITS_SOLD
Electronics    North                   5
Electronics    South                   5
Electronics    West                    3
Furniture      North                   4
Furniture      South                   7
Furniture      West                    2

6 rows selected.

8. Count Distinct Categories
  
SELECT COUNT(DISTINCT Category) AS Categories
FROM Sales;

Output:
CATEGORIES
         2

1 row selected.
