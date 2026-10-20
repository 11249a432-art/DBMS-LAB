Aim: To demonstrate views, sequences, indexes, and savepoints using an inventory and warehouse management system in Oracle SQL*Plus.

Commands:
  
1. Create the Product Table
  
CREATE TABLE Product (
    Product_ID NUMBER PRIMARY KEY,
    Product_Name VARCHAR2(80) NOT NULL,
    Category VARCHAR2(40),
    Stock_Qty NUMBER DEFAULT 0 NOT NULL,
    Unit_Price NUMBER(10,2) NOT NULL CHECK (Unit_Price >= 0)
);

Output:
Table created.

2. Create a Sequence for Product IDs
  
CREATE SEQUENCE Product_Seq
START WITH 1
INCREMENT BY 1
NOCACHE;

Output:
Sequence created.

3. Insert Product Records
  
INSERT INTO Product VALUES
(Product_Seq.NEXTVAL, 'Keyboard', 'Accessories', 15, 1200);

INSERT INTO Product VALUES
(Product_Seq.NEXTVAL, 'Mouse', 'Accessories', 5, 600);

INSERT INTO Product VALUES
(Product_Seq.NEXTVAL, 'Monitor', 'Displays', 3, 9500);

INSERT INTO Product VALUES
(Product_Seq.NEXTVAL, 'Laptop', 'Computers', 8, 65000);

COMMIT;

Output:
1 row created.
1 row created.
1 row created.
1 row created.

Commit complete.

4. Create a View for Low-Stock Products
  
CREATE VIEW LowStockProducts AS
SELECT Product_ID, Product_Name, Stock_Qty
FROM Product
WHERE Stock_Qty < 10;

Output:
View created.

5. Display Low-Stock Products
  
SELECT * FROM LowStockProducts
ORDER BY Product_ID;

Output:
PRODUCT_ID PRODUCT_NAME  STOCK_QTY
         2 Mouse                  5
         3 Monitor                3
         4 Laptop                 8

3 rows selected.

6. Create an Index on Product Category
  
CREATE INDEX idx_product_category
ON Product(Category);

Output:
Index created.

7. Display Index Information
  
SELECT INDEX_NAME, TABLE_NAME, UNIQUENESS
FROM USER_INDEXES
WHERE TABLE_NAME = 'PRODUCT'
ORDER BY INDEX_NAME;

Output:
INDEX_NAME             TABLE_NAME UNIQUENESS
IDX_PRODUCT_CATEGORY   PRODUCT    NONUNIQUE
SYS_C0012345            PRODUCT    UNIQUE

2 rows selected.

Note: Oracle automatically generates the primary-key index name. The exact name may differ.
  
8. Update Stock and Create a Savepoint
  
UPDATE Product
SET Stock_Qty = Stock_Qty - 1
WHERE Product_ID = 1;

SAVEPOINT stock_update;

UPDATE Product
SET Stock_Qty = Stock_Qty - 2
WHERE Product_ID = 2;

Output:
1 row updated.

Savepoint created.

1 row updated.

9. Roll Back to the Savepoint and Commit
  
ROLLBACK TO stock_update;

COMMIT;

Output:
Rollback complete.

Commit complete.

10. Display Final Product Stock
  
SELECT Product_ID, Stock_Qty
FROM Product
ORDER BY Product_ID;

Output:
PRODUCT_ID STOCK_QTY
         1         14
         2          5
         3          3
         4          8

4 rows selected.

11. Count Total Products
  
SELECT COUNT(*) AS Total_Products
FROM Product;

Output:
TOTAL_PRODUCTS
             4

1 row selected.

12. Drop the Secondary Index
  
DROP INDEX idx_product_category;

Output:
Index dropped.

13. Display Tables and Views
  
SELECT TABLE_NAME, 'TABLE' AS OBJECT_TYPE
FROM USER_TABLES
WHERE TABLE_NAME = 'PRODUCT'
UNION ALL
SELECT VIEW_NAME, 'VIEW' AS OBJECT_TYPE
FROM USER_VIEWS
WHERE VIEW_NAME = 'LOWSTOCKPRODUCTS';

Output:
TABLE_NAME          OBJECT_TYPE
PRODUCT             TABLE
LOWSTOCKPRODUCTS    VIEW

2 rows selected.
