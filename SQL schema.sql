-- PART ONE BUILDING AND POPULATING SCHEMA. 
-------------------------------------------------------------------------------
-- Creating the Client table. 
CREATE TABLE Client(
    Client_Nbr NUMBER(5) CONSTRAINT Pk_Client PRIMARY KEY, 
    First_Name VARCHAR2(50), 
    Last_Name VARCHAR2(50), 
    Street VARCHAR2(80), 
    City VARCHAR2 (50), 
    Prov_State VARCHAR2(50), 
    Postal_Code VARCHAR2(10), 
    Phone VARCHAR2(15), 
    Email VARCHAR(80)
); 

--Creating a sequence for the Client table to start at the Client number of 1001. 
CREATE SEQUENCE Sequence_Client
    START WITH 1001
    INCREMENT BY 1 
    NOCACHE; 

-- Inserting the 6 client values into the client table. 
INSERT INTO Client(Client_Nbr, First_Name, Last_Name, Street, City, Prov_State, Postal_Code, Phone, Email) 
VALUES(Sequence_Client.NEXTVAL, 'Bob', 'Smith', '123 Castle Road', 'Port Alberni', 'British Columbia', 'V9S 2B3', '250-816-7566', 'bsmith@gmail.com'); 

INSERT INTO Client(Client_Nbr, First_Name, Last_Name, Street, City, Prov_State, Postal_Code, Phone, Email) 
VALUES(Sequence_Client.NEXTVAL, 'Dan', 'Brown', '122 departure Lane', 'Nanaimo', 'British Columbia', 'V9S 1V3', '250-777-8174', 'dbrown@gmail.com');

INSERT INTO Client(Client_Nbr, First_Name, Last_Name, Street, City, Prov_State, Postal_Code, Phone, Email) 
VALUES(Sequence_Client.NEXTVAL, 'Darcy', 'Hitchcock', '111 Bumble Street', 'Victoria', 'British Columbia', 'V9B 2G5', '250-390-6421', 'dhitchcockh@gmail.com');

INSERT INTO Client(Client_Nbr, First_Name, Last_Name, Street, City, Prov_State, Postal_Code, Phone, Email) 
VALUES(Sequence_Client.NEXTVAL, 'Joe', 'Ruth', '155 Chariot Road', 'Vancouver', 'British Columbia', 'V9T 1C6', '250-555-9000', 'jcharioth@gmail.com'); 

INSERT INTO Client(Client_Nbr, First_Name, Last_Name, Street, City, Prov_State, Postal_Code, Phone, Email) 
VALUES(Sequence_Client.NEXTVAL, 'Alice', 'Apple', '432 Bin Lane', 'Duncan', 'British Columbia', 'V9S 4T6', '250-918-2132', 'aapple@gmail.com'); 

INSERT INTO Client(Client_Nbr, First_Name, Last_Name, Street, City, Prov_State, Postal_Code, Phone, Email) 
VALUES(Sequence_Client.NEXTVAL, 'Tucker', 'Ball', '789 Zebra Way', 'Kamloops', 'British Columbia', 'V9Y 1C9', '250-656-2743', 'tballh@gmail.com'); 

-- Creating the Account table. 
CREATE TABLE Account(
    Account_Nbr NUMBER(7) CONSTRAINT Pk_Account PRIMARY KEY, 
    Balance_Nbr NUMBER(12,2) DEFAULT 0
); 

--Creating a sequence for the Account table to start at the Account number of 1000001.
CREATE SEQUENCE Sequence_Account 
    START WITH 1000001
    INCREMENT BY 1 
    NOCACHE; 
 
-- Inserting the Account values into the Account table for the 6 Clients. 
INSERT INTO Account(Account_Nbr, Balance_Nbr)
VALUES(Sequence_Account.NEXTVAL, 0);

INSERT INTO Account(Account_Nbr, Balance_Nbr)
VALUES(Sequence_Account.NEXTVAL, 0);

INSERT INTO Account(Account_Nbr, Balance_Nbr)
VALUES(Sequence_Account.NEXTVAL, 0); 

INSERT INTO Account(Account_Nbr, Balance_Nbr)
VALUES(Sequence_Account.NEXTVAL, 0);

INSERT INTO Account(Account_Nbr, Balance_Nbr)
VALUES(Sequence_Account.NEXTVAL, 0);

INSERT INTO Account(Account_Nbr, Balance_Nbr)
VALUES(Sequence_Account.NEXTVAL, 0);

-- Creating the Owns table. 
CREATE TABLE Owns( 
    Client_Nbr NUMBER(5), 
    Account_Nbr NUMBER(7), 
    CONSTRAINT Pk_Owns PRIMARY KEY(Client_Nbr, Account_Nbr), 
    CONSTRAINT Owns_Client_Fk FOREIGN KEY(Client_Nbr) REFERENCES Client(Client_Nbr), 
    CONSTRAINT Owns_Account_Fk FOREIGN KEY(Account_Nbr) REFERENCES Account(Account_Nbr)
); 

-- Inserting the values into the Owns table. 
INSERT INTO Owns(Client_Nbr, Account_Nbr) 
VALUES(1001, 1000001); 

INSERT INTO Owns(Client_Nbr, Account_Nbr) 
VALUES(1002, 1000002); 

INSERT INTO Owns(Client_Nbr, Account_Nbr) 
VALUES(1003, 1000003); 

INSERT INTO Owns(Client_Nbr, Account_Nbr) 
VALUES(1004, 1000004); 

INSERT INTO Owns(Client_Nbr, Account_Nbr) 
VALUES(1005, 1000005); 

INSERT INTO Owns(Client_Nbr, Account_Nbr) 
VALUES(1006, 1000006); 

-- Creating an index for Client_Nbr in Owns table
CREATE INDEX idx_owns_client_nbr ON Owns(Client_Nbr);

-- Creating an idex for Account_Nbr in Owns table
CREATE INDEX idx_owns_account_nbr ON Owns(Account_Nbr);

--Creating table for Transaction. 
CREATE TABLE Transaction(
    Tx_Nbr NUMBER CONSTRAINT Pk_Transaction PRIMARY KEY, 
    Account_Nbr NUMBER(7), 
    Tx_Type_Code CHAR(1), 
    Tx_Date TIMESTAMP, 
    Tx_Amount NUMBER(12,2), 
    Ref_Nbr NUMBER, 
    CONSTRAINT Transaction_Account_Fk FOREIGN KEY(Account_Nbr) REFERENCES Account(Account_Nbr), 
    CONSTRAINT Tx_Type_Transaction_Fk FOREIGN KEY(Tx_Type_Code) REFERENCES Tx_Type(Tx_Type_Code)
); 

-- Creating Sequence for Transaction number. 
CREATE SEQUENCE Sequence_Transaction
    Start WITH 1 
    INCREMENT BY 1
    NOCACHE; 

-- Insertin test data into Transaction table. 
INSERT INTO Transaction(Tx_Nbr, Account_Nbr, Tx_Type_Code,Tx_Date, Tx_Amount, Ref_Nbr) 
VALUES(Sequence_Transaction.NEXTVAL, 1000001, 'X', TO_DATE('05-01-2019 12:00:00','MM-DD-YYYY HH24:MI:SS'), 123.45, 101); 

INSERT INTO Transaction(Tx_Nbr, Account_Nbr, Tx_Type_Code,Tx_Date, Tx_Amount, Ref_Nbr) 
VALUES(Sequence_Transaction.NEXTVAL, 1000000, 'D', TO_TIMESTAMP('05-01-2019 12:00:00','MM-DD-YYYY HH24:MI:SS'), 234.56, 101);

INSERT INTO Transaction(Tx_Nbr, Account_Nbr, Tx_Type_Code,Tx_Date, Tx_Amount, Ref_Nbr) 
VALUES(Sequence_Transaction.NEXTVAL, 1000001, 'D', TO_TIMESTAMP('05-01-2019 12:00:00','MM-DD-YYYY HH24:MI:SS'), 345.67, 111);

INSERT INTO Transaction(Tx_Nbr, Account_Nbr, Tx_Type_Code,Tx_Date, Tx_Amount, Ref_Nbr) 
VALUES(Sequence_Transaction.NEXTVAL, 1000001, 'D', TO_TIMESTAMP('05-01-2019 10:00:00','MM-DD-YYYY HH24:MI:SS'), 100.00, 101);

INSERT INTO Transaction(Tx_Nbr, Account_Nbr, Tx_Type_Code,Tx_Date, Tx_Amount, Ref_Nbr) 
VALUES(Sequence_Transaction.NEXTVAL, 1000001, 'D', TO_TIMESTAMP('05-11-2019 11:00:00','MM-DD-YYYY HH24:MI:SS'), 200.00, 101);

INSERT INTO Transaction(Tx_Nbr, Account_Nbr, Tx_Type_Code,Tx_Date, Tx_Amount, Ref_Nbr) 
VALUES(Sequence_Transaction.NEXTVAL, 1000001, 'D', TO_TIMESTAMP('05-21-2019 12:00:00','MM-DD-YYYY HH24:MI:SS'), 300.00, 101);

INSERT INTO Transaction(Tx_Nbr, Account_Nbr, Tx_Type_Code,Tx_Date, Tx_Amount, Ref_Nbr) 
VALUES(Sequence_Transaction.NEXTVAL, 1000001, 'W', TO_TIMESTAMP('05-29-2019 10:00:00','MM-DD-YYYY HH24:MI:SS'), 50.00, 102);

INSERT INTO Transaction(Tx_Nbr, Account_Nbr, Tx_Type_Code,Tx_Date, Tx_Amount, Ref_Nbr) 
VALUES(Sequence_Transaction.NEXTVAL, 1000001, 'W', TO_TIMESTAMP('05-29-2019 11:00:00','MM-DD-YYYY HH24:MI:SS'), 75.00, 103);

INSERT INTO Transaction(Tx_Nbr, Account_Nbr, Tx_Type_Code,Tx_Date, Tx_Amount, Ref_Nbr) 
VALUES(Sequence_Transaction.NEXTVAL, 1000001, 'D', TO_TIMESTAMP('06-15-2019 13:00:00','MM-DD-YYYY HH24:MI:SS'), 123.45, 101);

INSERT INTO Transaction(Tx_Nbr, Account_Nbr, Tx_Type_Code,Tx_Date, Tx_Amount, Ref_Nbr) 
VALUES(Sequence_Transaction.NEXTVAL, 1000002, 'D', TO_TIMESTAMP('05-15-2019 09:00:00','MM-DD-YYYY HH24:MI:SS'), 1000.00, 104);

INSERT INTO Transaction(Tx_Nbr, Account_Nbr, Tx_Type_Code,Tx_Date, Tx_Amount, Ref_Nbr) 
VALUES(Sequence_Transaction.NEXTVAL, 1000002, 'W', TO_TIMESTAMP('05-15-2019 09:05:00','MM-DD-YYYY HH24:MI:SS'), 456.78, 104);

INSERT INTO Transaction(Tx_Nbr, Account_Nbr, Tx_Type_Code,Tx_Date, Tx_Amount, Ref_Nbr) 
VALUES(Sequence_Transaction.NEXTVAL, 1000003, 'D', TO_TIMESTAMP('05-15-2019 09:10:00','MM-DD-YYYY HH24:MI:SS'), 456.78, 104);

INSERT INTO Transaction(Tx_Nbr, Account_Nbr, Tx_Type_Code,Tx_Date, Tx_Amount, Ref_Nbr) 
VALUES(Sequence_Transaction.NEXTVAL, 1000003, 'W', TO_TIMESTAMP('05-18-2019 14:00:00','MM-DD-YYYY HH24:MI:SS'), 500.00, 104);

INSERT INTO Transaction(Tx_Nbr, Account_Nbr, Tx_Type_Code,Tx_Date, Tx_Amount, Ref_Nbr) 
VALUES(Sequence_Transaction.NEXTVAL, 1000003, 'D', TO_TIMESTAMP('05-20-2019 13:00:00','MM-DD-YYYY HH24:MI:SS'), 100.00, 104);

INSERT INTO Transaction(Tx_Nbr, Account_Nbr, Tx_Type_Code,Tx_Date, Tx_Amount, Ref_Nbr) 
VALUES(Sequence_Transaction.NEXTVAL, 1000003, 'P', TO_TIMESTAMP('05-20-2019 14:50:00','MM-DD-YYYY HH24:MI:SS'), 65.78, 304);

INSERT INTO Transaction(Tx_Nbr, Account_Nbr, Tx_Type_Code,Tx_Date, Tx_Amount, Ref_Nbr) 
VALUES(Sequence_Transaction.NEXTVAL, 1000002, 'B', TO_TIMESTAMP('05-21-2019 09:00:00','MM-DD-YYYY HH24:MI:SS'), 100.00, 301);

INSERT INTO Transaction(Tx_Nbr, Account_Nbr, Tx_Type_Code,Tx_Date, Tx_Amount, Ref_Nbr) 
VALUES(Sequence_Transaction.NEXTVAL, 1000002, 'P', TO_TIMESTAMP('05-21-2019 10:00:00','MM-DD-YYYY HH24:MI:SS'), 200.00, 302);

INSERT INTO Transaction(Tx_Nbr, Account_Nbr, Tx_Type_Code,Tx_Date, Tx_Amount, Ref_Nbr) 
VALUES(Sequence_Transaction.NEXTVAL, 1000002, 'R', TO_TIMESTAMP('05-26-2019 12:34:00','MM-DD-YYYY HH24:MI:SS'), 50.00, 301);

INSERT INTO Transaction(Tx_Nbr, Account_Nbr, Tx_Type_Code,Tx_Date, Tx_Amount, Ref_Nbr) 
VALUES(Sequence_Transaction.NEXTVAL, 1000004, 'D', TO_TIMESTAMP('06-01-2019 13:00:00','MM-DD-YYYY HH24:MI:SS'), 2000.00, 101);

INSERT INTO Transaction(Tx_Nbr, Account_Nbr, Tx_Type_Code,Tx_Date, Tx_Amount, Ref_Nbr) 
VALUES(Sequence_Transaction.NEXTVAL, 1000005, 'D', TO_TIMESTAMP('06-01-2019 13:00:00','MM-DD-YYYY HH24:MI:SS'), 2000.00, 101);

INSERT INTO Transaction(Tx_Nbr, Account_Nbr, Tx_Type_Code,Tx_Date, Tx_Amount, Ref_Nbr) 
VALUES(Sequence_Transaction.NEXTVAL, 1000005, 'D', TO_TIMESTAMP('06-01-2019 14:00:00','MM-DD-YYYY HH24:MI:SS'), 2000.00, 102);

INSERT INTO Transaction(Tx_Nbr, Account_Nbr, Tx_Type_Code,Tx_Date, Tx_Amount, Ref_Nbr) 
VALUES(Sequence_Transaction.NEXTVAL, 1000005, 'B', TO_TIMESTAMP('06-10-2019 12:00:00','MM-DD-YYYY HH24:MI:SS'), 3456.78, 301);

INSERT INTO Transaction(Tx_Nbr, Account_Nbr, Tx_Type_Code,Tx_Date, Tx_Amount, Ref_Nbr) 
VALUES(Sequence_Transaction.NEXTVAL, 1000005, 'B', TO_TIMESTAMP('06-15-2019 14:30:00','MM-DD-YYYY HH24:MI:SS'), 432.10, 302);

INSERT INTO Transaction(Tx_Nbr, Account_Nbr, Tx_Type_Code,Tx_Date, Tx_Amount, Ref_Nbr) 
VALUES(Sequence_Transaction.NEXTVAL, 1000005, 'B', TO_TIMESTAMP('06-20-2019 15:55:00','MM-DD-YYYY HH24:MI:SS'), 100.00, 303);

INSERT INTO Transaction(Tx_Nbr, Account_Nbr, Tx_Type_Code,Tx_Date, Tx_Amount, Ref_Nbr) 
VALUES(Sequence_Transaction.NEXTVAL, 1000005, 'B', TO_TIMESTAMP('06-25-2019 16:56:00','MM-DD-YYYY HH24:MI:SS'), 80.00, 304);


-- Creaing an index on Account_Nbr in the Transaction table for faster queries. 
CREATE INDEX idx_transaction_account_nbr ON Transaction(Account_Nbr);

-- Creating an index on Tx_Type_Code in Transaction table for faster queries. 
CREATE INDEX idx_transaction_tx_type_code ON Transaction(Tx_Type_Code);

--Creating table to Tx_Type.    
CREATE TABLE Tx_Type( 
    Tx_Type_Code CHAR(1) CONSTRAINT Pk_Tx_Type PRIMARY KEY, 
    Tx_Type_Descript VARCHAR2(100)
); 

-- Inserting codes into Tx_Type with Deposit, Withdraw, Bill payment, Return Transaction, and Purchase Transaction. 
INSERT INTO Tx_Type(Tx_Type_Code, Tx_Type_Descript) 
VALUES('D', 'Deposit'); 

INSERT INTO Tx_Type(Tx_Type_Code, Tx_Type_Descript) 
VALUES('W', 'Withdraw'); 

INSERT INTO Tx_Type(Tx_Type_Code, Tx_Type_Descript) 
VALUES('B', 'Bill Payment'); 

INSERT INTO Tx_Type(Tx_Type_Code, Tx_Type_Descript) 
VALUES('R', 'Return Transaction'); 

INSERT INTO Tx_Type(Tx_Type_Code, Tx_Type_Descript) 
VALUES('P', 'Purchase Transaction'); 

-- Creating table for Bank_Branch. 
CREATE TABLE Bank_Branch( 
    Branch_Nbr NUMBER CONSTRAINT Pk_Bank_Branch PRIMARY KEY, 
    Branch_Name VARCHAR2(80) 
); 

--Inserting values into Bank_Branch. 
INSERT INTO Bank_Branch(Branch_Nbr, Branch_Name)
VALUES(101, 'Chequing'); 

INSERT INTO Bank_Branch(Branch_Nbr, Branch_Name)
VALUES(102, 'Savings'); 

INSERT INTO Bank_Branch(Branch_Nbr, Branch_Name)
VALUES(103, 'Loans'); 

INSERT INTO Bank_Branch(Branch_Nbr, Branch_Name)
VALUES(104, 'Investments'); 

--Creating table for Merchant. 
CREATE TABLE Merchant( 
    Merchant_Nbr NUMBER CONSTRAINT Pk_Merchant PRIMARY KEY, 
    Merchant_Name VARCHAR2 (50)
); 

--Inserting values into Merchant. 
INSERT INTO Merchant(Merchant_Nbr, Merchant_Name)
VALUES(301, 'Credit Card'); 

INSERT INTO Merchant(Merchant_Nbr, Merchant_Name)
VALUES(302, 'Housing'); 

INSERT INTO Merchant(Merchant_Nbr, Merchant_Name)
VALUES(304, 'Retail'); 

INSERT INTO Merchant(Merchant_Nbr, Merchant_Name)
VALUES(303, 'Insurance'); 

-- PART TWO: VIEWS
-------------------------------------------------------------------------------
-- Joining of Transaction to Type Description - ViewOne.  
CREATE VIEW ViewOne
AS SELECT
    t.Tx_Nbr,
    t.Account_Nbr,
    t.Tx_Type_Code, 
    t.Tx_Date, 
    t.Tx_Amount, 
    t.Ref_Nbr, 
    tt.Tx_Type_Descript 
FROM 
    Transaction t 
JOIN 
    Tx_Type tt 
ON
    t.Tx_Type_Code = tt.Tx_Type_Code; 

-- Joining of Client table to account table with outer join to the owns table containing - client number, name, account number and balance. 
CREATE VIEW ViewTwo 
AS SELECT 
    c.Client_Nbr, 
    c.First_Name, 
    c.Last_Name, 
    o.Account_Nbr, 
    a.Balance_Nbr
From
    Client c
LEFT OUTER JOIN 
    Owns o
ON
    c.Client_Nbr = o.Client_Nbr
JOIN 
    Account a
ON 
    o.Account_Nbr = a.Account_Nbr; 
    

--Joining of deposit and withdraw transactions to bank branch with a Union of Bill payments and Debit purchases to merchant. 
CREATE OR REPLACE VIEW ViewThree 
AS SELECT 
    *
FROM
    Transaction t
JOIN 
    Bank_Branch bb 
ON 
    t.Ref_Nbr = bb.Branch_Nbr
WHERE 
    Tx_Type_Code = 'D' 
OR 
    Tx_Type_Code = 'W'
UNION

SELECT 
    * 
FROM 
    Transaction t
JOIN 
    Merchant m 
ON 
    t.Ref_Nbr = m.Merchant_Nbr
WHERE 
    Tx_Type_Code = 'B' 
OR 
    Tx_Type_Code = 'P'; 

-- PART 3 QUERIES
-------------------------------------------------------------------------------
-- 1) Listing only the accounts that have mutliple Clients associated to them. 
SELECT 
    o.Account_Nbr  
FROM 
   Owns o
GROUP BY 
    o.Account_Nbr
HAVING 
    COUNT(o.Client_Nbr) > 1;    

--2) Provide an alphabetic list by last name of all Clients showing their full name 
-- with the number of Accounts they hold and the total balance of those Accounts 
SELECT 
    (c.First_Name || ' ' || c.Last_Name) AS Full_Name, 
    COUNT(o.Account_Nbr) AS Number_of_Accounts, 
    SUM(a.Balance_Nbr) AS Total_Balance
FROM 
    Client c
JOIN 
    Owns o 
ON 
    c.Client_Nbr = o.Client_Nbr
JOIN 
    Account a 
ON 
    o.Account_Nbr = a.Account_Nbr
GROUP BY 
    c.First_Name, c.Last_Name
ORDER BY 
    c.Last_Name ASC;
    
--3) Count and sum of transaction by type description. 
SELECT 
    tt.Tx_Type_Descript AS Type_Description, 
    COUNT(T.Tx_Nbr) AS Count_Transactions, 
    SUM(T.Tx_Amount) AS Sum_Transactions
FROM 
    Transaction t 
JOIN 
    Tx_Type tt
ON
    t.Tx_Type_Code = tt.Tx_Type_Code
GROUP BY 
    tt.Tx_Type_Descript; 

--4) List of each Account showing the first Transaction date, type, and amount.
SELECT 
    t.Account_Nbr, 
    t.Tx_Date,
    tt.Tx_Type_Descript, 
    t.Tx_Amount 
FROM 
    Transaction t
Join 
    Tx_Type tt
On
    t.Tx_Type_Code = tt.Tx_Type_Code
WHERE 
    t.Tx_Date =(SELECT MIN(tr.Tx_Date)
                FROM
                    Transaction tr
                WHERE 
                    tr.Account_Nbr = t.Account_Nbr); 

--5)Count and Total Amount for each Transaction Type within each Account 
SELECT
    COUNT(Tx_Nbr) AS Transaction_Count, 
    SUM(T.Tx_Amount) AS Total_Amount, 
    t.Account_Nbr,
    tt.Tx_Type_Descript
FROM 
    Transaction t 
Join 
    Tx_Type tt
On
    t.Tx_Type_Code = tt.Tx_Type_Code
GROUP BY 
    t.Account_Nbr, 
    tt.Tx_Type_Descript 
ORDER BY 
    t.Account_Nbr ASC,  
    tt.Tx_Type_Descript ASC; 

--PART 4 TRIGGERS
-------------------------------------------------------------------------------
--Trigger to enforce referential integrity for the Ref_Nbr. 
CREATE TRIGGER Enforcing_Ref_Nbr
BEFORE INSERT OR UPDATE ON
    Transaction 
FOR EACH ROW 
DECLARE 
    Trigger_Count INTEGER;
BEGIN 
    IF :NEW.Tx_Type_Code IN ('D', 'W') THEN 
        SELECT 
            COUNT(*)
        INTO    
            Trigger_Count
        FROM 
            Bank_Branch
        WHERE 
            Branch_Nbr = :NEW.Ref_Nbr; 
        
        IF Trigger_Count = 0 THEN 
            RAISE_APPLICATION_ERROR(-20000, 'Not a valid Bank Branch'); 
        END IF; 
        
        ELSIF :NEW.Tx_Type_Code IN ('B', 'P', 'R') THEN
            SELECT 
                COUNT(*)
            INTO 
                Trigger_Count
            FROM 
                Merchant
            WHERE 
                Merchant_Nbr = :NEW.Ref_Nbr;
            
            IF Trigger_Count = 0 THEN
                RAISE_APPLICATION_ERROR(-20001, 'Not a valid Merchant Number'); 
            END IF;
        END IF; 
    END; 
/

--Trigger to update the Account Balances for each new transaction entered
CREATE OR REPLACE TRIGGER Update_Account_Balance 
AFTER INSERT ON Transaction
FOR EACH ROW  
BEGIN
    -- Update account for deposit transactions. 
    IF :NEW.Tx_Type_Code = 'D' THEN 
        UPDATE Account
        SET 
            Balance_Nbr = Balance_Nbr + :NEW.Tx_Amount
        WHERE 
            Account_Nbr = :NEW.Account_Nbr; 
        
        -- Update account for withdraw transactions. 
        ELSIF :NEW.Tx_Type_Code = 'W' THEN 
            UPDATE Account
            SET
                Balance_Nbr = Balance_Nbr - :NEW.Tx_Amount
            WHERE 
                Account_Nbr = :NEW.Account_Nbr; 
        
         -- Update account for bill payments and purchase transactions.       
        ELSIF :NEW.Tx_Type_Code IN ('B', 'P') THEN 
            UPDATE Account
            SET 
                Balance_Nbr = Balance_Nbr - :NEW.Tx_Amount
            WHERE 
                Account_Nbr = :NEW.Account_Nbr; 
        
        -- Update account for Return transactions.       
        ELSIF :NEW.Tx_Type_Code = 'R' THEN 
            UPDATE Account
            SET 
                Balance_Nbr = Balance_Nbr + :NEW.Tx_Amount
            WHERE 
                Account_Nbr = :NEW.Account_Nbr; 
        END IF; 
    END; 
/
 

-- Creating a procdure to dsiplay a nicely formatted audit statement
CREATE OR REPLACE PROCEDURE Audit_Display(P_Account_Nbr Account.Account_Nbr%TYPE)
IS
    BEGIN 
        FOR t IN (SELECT Transaction.*
        FROM 
            Transaction 
        WHERE 
            Account_Nbr = P_Account_Nbr
        ORDER BY 
            Tx_Date)
        --Looping through and updating all the transactions
        LOOP 
            DBMS_OUTPUT.PUT_LINE('Account Number: ' || t.Account_Nbr || 'Transaction Date: ' || t.Tx_Date || 'Total Amount: ' || t.Tx_Amount); 
        END LOOP; 
    END; 
/   

