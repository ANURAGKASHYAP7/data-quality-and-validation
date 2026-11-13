CREATE DATABASE DATAVALIDATION;
USE DATAVALIDATION;
/* Question 1 : Define Data Quality in the context of ETL pipelines. Why is it more than just data cleaning?
Definition:
Data Quality refers to the accuracy, completeness, consistency, validity, uniqueness, and reliability of data throughout the ETL pipeline.

Why is it more than just Data Cleaning?

Data Quality is more than just data cleaning because it not only removes errors and duplicates but also ensures that data is reliable, valid, consistent, and suitable for business decisions.
Question 2 : Explain why poor data quality leads to misleading dashboards and incorrect decisions.
Answer:
Poor data quality means data contains errors, missing values, duplicate records, or inconsistencies. When this incorrect data is used in dashboards, it produces misleading reports, wrong calculations, and inaccurate insights.
Reasons:
1. Incorrect Results: Wrong data produces incorrect calculations and reports.
2. Missing Information: Missing values can affect totals, averages, and comparisons.
3. Duplicate Records: Duplicates can increase sales or customer counts incorrectly.
4. Inconsistent Data: Different formats can create incorrect grouping and analysis.

Question 3 : What is duplicate data? Explain three causes in ETL pipelines.
Duplicate data refers to records that appear more than once in a dataset, even though they represent the same information or entity.

Three Causes of Duplicate Data in ETL Pipelines:

1. Repeated Data Extraction: The same data is extracted multiple times from the source system, creating duplicate records.

2. Data Integration: When data from multiple sources is combined, the same customer or transaction may appear more than once.

3. Improper ETL Process: If an ETL pipeline runs repeatedly without checking existing records, it may insert duplicate data into the target table

Question 4 : Differentiate between exact, partial, and fuzzy duplicates
Difference 
Type	Meaning
Exact	All values are identical.
Partial	Some values are identical.
Fuzzy	Values are similar but not exactly the same.

Question 5 : Why should data validation be performed during transformation rather than after loading
Data validation should be performed during the transformation stage of ETL because it helps identify and correct errors before loading data into the target system.
Suppose a customer dataset contains a negative age (-5). During transformation, validation identifies this invalid value so it can be corrected or rejected before loading it into the target database.

Question 6 : Explain how business rules help in validating data accuracy. Give an example
Business rules are predefined conditions or guidelines that data must follow to meet an organization's requirements.

How Business Rules Help in Data Validation:
1. Check Validity: Ensure data follows predefined conditions.
2. Maintain Accuracy: Identify incorrect or unrealistic values.
3. Maintain Consistency: Ensure data follows standard formats.
4. Prevent Errors: Reject or flag records that do not meet business requirements.
*/

CREATE TABLE Sales_Transactions (
    Txn_ID INT PRIMARY KEY,
    Customer_ID VARCHAR(10),
    Customer_Name VARCHAR(100),
    Product_ID VARCHAR(10),
    Quantity INT,
    Txn_Amount DECIMAL(10,2),
    Txn_Date DATE,
    City VARCHAR(50)
);
INSERT INTO Sales_Transactions
(Txn_ID, Customer_ID, Customer_Name, Product_ID,
 Quantity, Txn_Amount, Txn_Date, City)
VALUES
(201, 'C101', 'Rahul Mehta', 'P11', 2, 4000, '2025-12-01', 'Mumbai'),

(202, 'C102', 'Anjali Rao', 'P12', 1, 1500, '2025-12-01', 'Bengaluru'),

(203, 'C101', 'Rahul Mehta', 'P11', 2, 4000, '2025-12-01', 'Mumbai'),

(204, 'C103', 'Suresh Iyer', 'P13', 3, 6000, '2025-12-02', 'Chennai'),

(205, 'C104', 'Neha Singh', 'P14', NULL, 2500, '2025-12-02', 'Delhi'),

(206, 'C105', NULL, 'P15', 1, NULL, '2025-12-03', 'Pune'),

(207, 'C106', 'Amit Verma', 'P16', 1, 1800, NULL, 'Pune'),

(208, 'C101', 'Rahul Mehta', 'P11', 2, 4000, '2025-12-01', 'Mumbai');
SELECT * FROM Sales_Transactions;

#Question 7 : Write an SQL query on SALES_TRANSACTION to list all duplicate keys and their counts using the 
#business key (Customer_ID + Product_ID + Txn_Date + Txn_Amount )
SELECT
    Customer_ID,
    Product_ID,
    Txn_Date,
    Txn_Amount,
    COUNT(*) AS Duplicate_Count
FROM Sales_Transactions
GROUP BY
    Customer_ID,
    Product_ID,
    Txn_Date,
    Txn_Amount
HAVING COUNT(*) > 1;

# q8 Identify Sales_Transactions.Customer_ID values that violate referential integrity when joined with
#Customers_Master and write a query to detect such violations.
CREATE TABLE Customers_Master (
    CustomerID VARCHAR(10) PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50)
);
INSERT INTO Customers_Master
(CustomerID, CustomerName, City)
VALUES
('C101', 'Rahul Mehta', 'Mumbai'),
('C102', 'Anjali Rao', 'Bengaluru'),
('C103', 'Suresh Iyer', 'Chennai'),
('C104', 'Neha Singh', 'Delhi');
SELECT
    s.Txn_ID,
    s.Customer_ID
FROM Sales_Transactions s
LEFT JOIN Customers_Master c
ON s.Customer_ID = c.CustomerID
WHERE c.CustomerID IS NULL;
