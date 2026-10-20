Aim: To demonstrate Data Control Language (DCL) and Transaction Control Language (TCL) commands using a banking transaction management system in Oracle SQL*Plus.

Commands:
  
1. Create the BankAccount Table

CREATE TABLE BankAccount (
    Account_ID NUMBER PRIMARY KEY,
    Holder_Name VARCHAR2(50),
    Balance NUMBER(12,2) CHECK (Balance >= 0)
);

Output:
Table created.

2. Insert Bank Account Records

INSERT ALL
    INTO BankAccount VALUES (201, 'Arun', 5000)
    INTO BankAccount VALUES (202, 'Priya', 7500)
    INTO BankAccount VALUES (203, 'Ravi', 3000)
SELECT * FROM DUAL;

COMMIT;

Output:
3 rows created.

Commit complete.

3. Display All Bank Accounts

SELECT * FROM BankAccount
ORDER BY Account_ID;

Output:
ACCOUNT_ID HOLDER_NAME BALANCE
201        Arun          5000.00
202        Priya         7500.00
203        Ravi          3000.00

3 rows selected.

4. Perform a Bank Transfer Using a Transaction

UPDATE BankAccount
SET Balance = Balance - 1000
WHERE Account_ID = 201;

UPDATE BankAccount
SET Balance = Balance + 1000
WHERE Account_ID = 202;

SELECT Account_ID, Balance
FROM BankAccount
WHERE Account_ID IN (201, 202)
ORDER BY Account_ID;

Output:
1 row updated.

1 row updated.

ACCOUNT_ID BALANCE
201         4000.00
202         8500.00

2 rows selected.

5. Create a Savepoint and Update Account 203

SAVEPOINT transfer_done;

UPDATE BankAccount
SET Balance = Balance - 2000
WHERE Account_ID = 203;

SELECT Account_ID, Balance
FROM BankAccount
WHERE Account_ID = 203;

Output:
Savepoint created.

1 row updated.

ACCOUNT_ID BALANCE
203         1000.00

1 row selected.

6. Roll Back to the Savepoint

ROLLBACK TO transfer_done;

SELECT Account_ID, Balance
FROM BankAccount
WHERE Account_ID = 203;

Output:
Rollback complete.

ACCOUNT_ID BALANCE
203         3000.00

1 row selected.

7. Commit the Transaction
  
COMMIT;

SELECT * FROM BankAccount
ORDER BY Account_ID;

Output:
Commit complete.

ACCOUNT_ID HOLDER_NAME BALANCE
201        Arun          4000.00
202        Priya         8500.00
203        Ravi          3000.00

3 rows selected.

8. Calculate the Total Balance
  
SELECT SUM(Balance) AS Total_Balance
FROM BankAccount;

Output:
TOTAL_BALANCE
     15500.00

1 row selected.

9. Demonstrate DCL Commands

Run these commands using an Oracle account with the required administrative privileges.
CREATE USER lab_teller
IDENTIFIED BY "ChangeThis_StrongPassword!";

GRANT CREATE SESSION TO lab_teller;

GRANT SELECT, UPDATE
ON BankAccount
TO lab_teller;

REVOKE UPDATE
ON BankAccount
FROM lab_teller;

SELECT * FROM USER_TAB_PRIVS
WHERE TABLE_NAME = 'BANKACCOUNT';

DROP USER lab_teller;

Output:
User created.
Grant succeeded.
Grant succeeded.
Revoke succeeded.
