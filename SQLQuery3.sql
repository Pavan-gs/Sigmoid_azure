/* SQL Server Queries for HR Schema */

/* Ensure you're in the HR database */
USE HR;
GO

/* Exploring the Database */
/* Display all columns and rows to understand the data */
/* Rule: SELECT * retrieves all columns; use for exploration only */
/* Violation: Using SELECT * in production can fetch unnecessary data */
SELECT * FROM EMPLOYEES;

/* Projection - Selecting Specific Tables and Columns */
/* View all rows from DEPARTMENTS and LOCATIONS, then specific columns from EMPLOYEES */
/* Rule: List only the columns you need after SELECT */
/* Violation: Forgetting FROM clause causes a syntax error */
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

/* Selecting specific columns from EMPLOYEES */
SELECT FIRST_NAME, JOB_ID, SALARY 
FROM EMPLOYEES;

/* Case Insensitivity and Computed Columns */
/* SQL Server is case-insensitive for identifiers; compute a new column */
/* Rule: SQL Server is case-insensitive for table/column names */
/* Violation: Forgetting parentheses in computed expressions can lead to errors */
SELECT LAST_NAME, JOB_ID, SALARY, SALARY + 500 AS IncreasedSalary
FROM EMPLOYEES;

SELECT LAST_NAME, SALARY, (SALARY + 100) * 12 AS YearlyBonus
FROM EMPLOYEES;

/* Handling NULL Values */
/* How NULL affects computations */
/* Rule: Use ISNULL to handle NULL values in computations */
/* Violation: Adding NULL to a number results in NULL */
SELECT LAST_NAME, SALARY, COMMISSION_PCT, SALARY + (SALARY * ISNULL(COMMISSION_PCT, 0)) AS TotalPay
FROM EMPLOYEES;

/* Aliases */
/* Rename columns for better readability */
/* Rule: Use AS or a space to define aliases; enclose in [] if spaces are used */
/* Violation: Using double quotes for aliases fails in SQL Server */
SELECT LAST_NAME, SALARY, (SALARY + 100) * 12 AS BONUS
FROM EMPLOYEES;

SELECT LAST_NAME, SALARY, (SALARY + 100) * 12 AS [YEARLY BONUS]
FROM EMPLOYEES;

/* Concatenation */
/* Combine strings to create meaningful outputs */
/* Rule: Use + for concatenation in SQL Server */
/* Violation: Using || causes a syntax error */
SELECT FIRST_NAME + LAST_NAME AS FullName
FROM EMPLOYEES;

SELECT FIRST_NAME + ' ' + LAST_NAME AS FullName
FROM EMPLOYEES;

/* Using Literals in Concatenation */
/* Rule: Enclose literals in single quotes */
/* Violation: Using double quotes for literals causes a syntax error */
SELECT FIRST_NAME + ' is a ' + JOB_ID AS EmployeeRole
FROM EMPLOYEES;

/* Concatenation with Departments */
/* Create a descriptive string for departments */
/* Rule: Convert numbers to strings using CAST when concatenating */
/* Violation: Forgetting to convert MANAGER_ID to string causes errors */
SELECT DEPARTMENT_NAME + ' department''s manager id is ' + CAST(MANAGER_ID AS VARCHAR) AS DEPT_MANAGER
FROM DEPARTMENTS;

/* System Functions and Literals */
/* Show current date and perform simple calculations */
/* Rule: SQL Server doesn't require DUAL; remove FROM DUAL */
/* Violation: Including FROM DUAL causes an error */
SELECT GETDATE() AS CurrentDate;

/* Simple calculation without FROM */
SELECT 100 * 8 AS Result;

/* DISTINCT - Removing Duplicates */
/* Retrieve unique values */
/* Rule: Use DISTINCT to eliminate duplicate rows */
/* Violation: Using DISTINCT on multiple columns affects the entire row */
SELECT DISTINCT DEPARTMENT_ID 
FROM EMPLOYEES;

/* Describe Table Structure */
/* View table metadata */
/* Rule: Use sp_help in SQL Server to describe tables */
/* Violation: DESCRIBE fails in SQL Server */
EXEC sp_help 'dbo.EMPLOYEES';

/* Activities for Practice */
/* Activity 1: Count unique departments with employees */
SELECT COUNT(DISTINCT DEPARTMENT_ID) AS UniqueDepartments
FROM EMPLOYEES;

/* Activity 2: Years employed for employees who quit */
SELECT EMPLOYEE_ID, JOB_ID, HIRE_DATE, END_DATE,
       ROUND(DATEDIFF(DAY, HIRE_DATE, END_DATE) / 365.25, 2) AS YearsEmployed
FROM EMPLOYEES
WHERE END_DATE IS NOT NULL;

/* Activity 3: Job description formatting */
SELECT 'The Job Id for the ' + JOB_TITLE + '''s job is: ' + JOB_ID AS JobDescription
FROM JOBS;

/* Restricting Data with WHERE Clause */
/* Filter rows based on conditions */
/* Rule: WHERE clause comes after FROM and before ORDER BY */
/* Violation: Placing WHERE after ORDER BY causes a syntax error */
SELECT LAST_NAME, DEPARTMENT_ID, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 90;

/* Sorting with ORDER BY */
SELECT LAST_NAME, DEPARTMENT_ID, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 90
ORDER BY SALARY DESC;

/* Filtering with String Literals */
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_ID, SALARY
FROM EMPLOYEES
WHERE LAST_NAME = 'King'
ORDER BY SALARY DESC;

/* Comparison Operators */
SELECT LAST_NAME, DEPARTMENT_ID, SALARY
FROM EMPLOYEES
WHERE SALARY > 10000
ORDER BY SALARY DESC;

/* Range Filtering with AND */
SELECT LAST_NAME, DEPARTMENT_ID, SALARY
FROM EMPLOYEES
WHERE SALARY >= 10000 AND SALARY <= 15000
ORDER BY SALARY DESC;

/* Using BETWEEN */
SELECT LAST_NAME, DEPARTMENT_ID, SALARY
FROM EMPLOYEES
WHERE SALARY BETWEEN 10000 AND 15000
ORDER BY SALARY DESC;

/* Using NOT BETWEEN */
SELECT LAST_NAME, DEPARTMENT_ID, SALARY
FROM EMPLOYEES
WHERE SALARY NOT BETWEEN 10000 AND 15000
ORDER BY SALARY DESC;

/* Using IN Operator */
SELECT LAST_NAME, DEPARTMENT_ID, SALARY
FROM EMPLOYEES
WHERE SALARY > 10000 AND DEPARTMENT_ID IN (60, 80, 90)
ORDER BY SALARY DESC;

/* Pattern Matching with LIKE */
SELECT LAST_NAME, DEPARTMENT_ID, SALARY
FROM EMPLOYEES
WHERE LAST_NAME LIKE 'A%';

SELECT LAST_NAME, DEPARTMENT_ID, SALARY
FROM EMPLOYEES
WHERE LAST_NAME LIKE '_a%';

/* Handling NULL Values in WHERE */
SELECT LAST_NAME, DEPARTMENT_ID, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL;

SELECT LAST_NAME, DEPARTMENT_ID, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;

/* Filtering by Date */
SELECT LAST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE HIRE_DATE = '2007-05-21';

/* Combining Conditions with OR and AND */
SELECT LAST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE (JOB_ID = 'SA_REP' OR JOB_ID = 'AD_PRES')
AND SALARY > 10000
ORDER BY HIRE_DATE DESC;

/* ORDER BY with Column Position */
SELECT LAST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE (JOB_ID = 'SA_REP' OR JOB_ID = 'AD_PRES')
AND SALARY > 10000
ORDER BY 2;  -- Sorts by JOB_ID

/* Substitution Variables */
/* Allow dynamic input using variables */
/* Rule: Use DECLARE for variables in SQL Server */
/* Violation: Using & causes an error */
DECLARE @EMPLOYEE_NUM INT = 100;
SELECT LAST_NAME, EMPLOYEE_ID, JOB_ID, SALARY
FROM EMPLOYEES
WHERE EMPLOYEE_ID = @EMPLOYEE_NUM;

/* Variable for String Input */
DECLARE @INPUT VARCHAR(10) = 'SA_REP';
SELECT LAST_NAME, EMPLOYEE_ID, JOB_ID, SALARY
FROM EMPLOYEES
WHERE JOB_ID = @INPUT;

/* Activities for Restricting Data */
/* Activity 1: Department names ending with "ing" and second character is "a" */
SELECT DEPARTMENT_NAME
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME LIKE '_a%ing';

/* Activity 2: Job title variance for President or Manager roles */
SELECT JOB_TITLE, MIN_SALARY, MAX_SALARY, 
       (MAX_SALARY - MIN_SALARY) AS VARIANCE
FROM JOBS
WHERE JOB_TITLE LIKE '%President%' OR JOB_TITLE LIKE '%Manager%'
ORDER BY VARIANCE DESC, JOB_TITLE DESC;

/* Activity 3: Tax calculation with variables */
DECLARE @TAX_RATE DECIMAL(5,2) = 0.20;
DECLARE @EMP_ID INT = 100;
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, 
       SALARY * 12 AS AnnualSalary,
       @TAX_RATE AS TaxRate, 
       (SALARY * 12) * @TAX_RATE AS TaxAmount
FROM EMPLOYEES
WHERE EMPLOYEE_ID = @EMP_ID;

/* Single-Row Functions */
/* Transform data using functions */
SELECT LAST_NAME
FROM EMPLOYEES
WHERE UPPER(LAST_NAME) = 'KING';

/* String Functions */
SELECT EMPLOYEE_ID, JOB_ID, 
       FIRST_NAME + LAST_NAME AS [FULL NAME],
       LEN(LAST_NAME) AS LengthOfLastName,
       CHARINDEX('a', LAST_NAME) AS [CONTAINS A?]
FROM EMPLOYEES
WHERE SUBSTRING(JOB_ID, 4, 3) = 'REP';

/* Numeric Functions */
SELECT ROUND(109999.79698680, 2) AS RoundedNumber;

/* Date Functions and Formats */
/* Work with dates for analysis */
/* Rule: Use FORMAT for custom date formatting */
/* Violation: Using TO_CHAR causes an error */
SELECT LAST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE < '2008-02-01';

/* Calculate weeks employed */
SELECT EMPLOYEE_ID, 
       ROUND(DATEDIFF(DAY, HIRE_DATE, GETDATE()) / 7.0, 0) AS WEEKS
FROM EMPLOYEES
ORDER BY WEEKS DESC;

/* Date Calculations */
SELECT DATEDIFF(MONTH, '2003-01-01', '2010-12-12') AS MonthsDifference;

SELECT DATEADD(DAY, 
       (8 - DATEPART(WEEKDAY, '2024-07-25')) % 7, 
       '2024-07-25') AS NextThursday;

SELECT EOMONTH('2024-07-25') AS LastDayOfMonth;

SELECT DATEADD(MONTH, 2, '2024-07-25') AS TwoMonthsLater;

SELECT DATEADD(MONTH, -2, '2023-09-30') AS TwoMonthsEarlier;

/* Formatting Dates */
SELECT FORMAT(GETDATE(), 'd ''of'' MMMM') + ' is my birthday' AS Birthday;

SELECT FORMAT(GETDATE(), 'd''th'' ''of'' MMMM') + ' is my birthday' AS Birthday;

SELECT FORMAT(GETDATE(), 'dd MM yyyy') + ' is my birthday' AS Birthday;

SELECT FORMAT(GETDATE(), 'yyyy') + ' is my birthday' AS Birthday;

SELECT FORMAT(GETDATE(), 'MMMM') + ' is my birthday' AS Birthday;

/* Formatting Numbers */
SELECT FORMAT(SALARY, '$#,##0.00') AS SALARY
FROM EMPLOYEES;

/* Activities for Date Functions */
/* Activity 1: Format hire date as "01-Jan-2022" */
SELECT LAST_NAME, FORMAT(HIRE_DATE, 'dd-MMM-yyyy') AS FormattedHireDate
FROM EMPLOYEES;

/* Activity 2: Format hire date as "1st of Jan 2022" */
SELECT LAST_NAME, 
       FORMAT(HIRE_DATE, 'd''th'' ''of'' MMM yyyy') AS FormattedHireDate
FROM EMPLOYEES;

/* More Activities for Date and String Functions */
/* Activity 1: Envelope printing with name length restriction */
SELECT FIRST_NAME, LAST_NAME,
       CASE 
           WHEN LEN(FIRST_NAME + ' ' + LAST_NAME) > 15 
           THEN LEFT(FIRST_NAME, 1) + ' ' + LEFT(LAST_NAME, 14)
           ELSE FIRST_NAME + ' ' + LAST_NAME
       END AS Addressee
FROM EMPLOYEES
WHERE LEN(FIRST_NAME + ' ' + LAST_NAME) > 15;

/* Activity 2: Employee tenure and review dates */
SELECT EMPLOYEE_ID, HIRE_DATE,
       DATEDIFF(MONTH, HIRE_DATE, GETDATE()) AS MonthsEmployed,
       DATEADD(MONTH, 6, HIRE_DATE) AS SixMonthReview,
       DATEADD(DAY, 
               (6 - DATEPART(WEEKDAY, HIRE_DATE) + 7) % 7, 
               HIRE_DATE) AS FirstFriday,
       EOMONTH(HIRE_DATE) AS LastDayOfHireMonth
FROM EMPLOYEES
WHERE DATEDIFF(MONTH, HIRE_DATE, GETDATE()) < 150
AND DEPARTMENT_ID = 50;

/* Nesting Functions */
/* Combine functions for complex transformations */
SELECT LAST_NAME, UPPER(FIRST_NAME + JOB_ID) AS EmployeeInfo
FROM EMPLOYEES;

/* NULL Handling Functions */
SELECT LAST_NAME, SALARY, COMMISSION_PCT, 
       ISNULL(COMMISSION_PCT, 0) AS Commission,
       SALARY + 10 + ISNULL(COMMISSION_PCT, 0) AS TotalPay
FROM EMPLOYEES;

/* Using IIF for Conditional Logic */
SELECT LAST_NAME, SALARY, COMMISSION_PCT, 
       IIF(COMMISSION_PCT IS NOT NULL, 'SAL+COMM', 'SAL') AS INCOME
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (60, 80, 90);

/* Using NULLIF */
SELECT FIRST_NAME, LEN(FIRST_NAME) AS EXPR1, 
       LAST_NAME, LEN(LAST_NAME) AS EXPR2, 
       NULLIF(LEN(FIRST_NAME), LEN(LAST_NAME)) AS RESULT
FROM EMPLOYEES;

/* Using COALESCE */
SELECT LAST_NAME, FIRST_NAME, SALARY, COMMISSION_PCT,
       COALESCE(SALARY + (COMMISSION_PCT * SALARY), SALARY + 2000, SALARY) AS [NEW SALARY]
FROM EMPLOYEES;

/* COALESCE with String Conversion */
SELECT LAST_NAME, COMMISSION_PCT, MANAGER_ID,
       COALESCE(CAST(COMMISSION_PCT AS VARCHAR), CAST(MANAGER_ID AS VARCHAR)) AS [NO COMMISSION AND MANAGER]
FROM EMPLOYEES;

/* Conditional Expressions */
SELECT LAST_NAME, JOB_ID, SALARY,
       CASE JOB_ID 
           WHEN 'IT_PROG' THEN (0.10 * SALARY) + SALARY
           WHEN 'SA_REP' THEN (0.20 * SALARY) + SALARY
           WHEN 'ST_CLERK' THEN (0.05 * SALARY) + SALARY
           ELSE SALARY 
       END AS [REVISED SALARY]
FROM EMPLOYEES;

/* CASE with Range Conditions */
SELECT SALARY, LAST_NAME,
       CASE 
           WHEN SALARY <= 10000 THEN 'LOW'
           WHEN SALARY BETWEEN 10001 AND 20000 THEN 'AVG'
           WHEN SALARY >= 20000 THEN 'HIGH'
           ELSE 'UNKNOWN'
       END AS SALARY_LEVEL
FROM EMPLOYEES;

/* Activities for Conditional Expressions */
/* Activity 1: Compare name lengths for DEPARTMENT_ID 100 */
SELECT LAST_NAME, FIRST_NAME,
       CASE 
           WHEN LEN(FIRST_NAME) = LEN(LAST_NAME) THEN 'Same Length'
           ELSE 'Different Length'
       END AS NAME_LENGTHS
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 100;

/* Activity 2: Location info based on STATE_PROVINCE */
SELECT CITY, STATE_PROVINCE,
       CASE STATE_PROVINCE
           WHEN 'Washington' THEN 'Headquarters'
           WHEN 'Texas' THEN 'Oil Wells'
           WHEN 'California' THEN 'City'
           WHEN 'New Jersey' THEN 'Street Address'
           ELSE 'Other'
       END AS LOCATION_INFO
FROM LOCATIONS
WHERE COUNTRY_ID = 'US'
ORDER BY LOCATION_INFO;

/* Day 2 Preview: Group Functions, Joins, Subqueries, CRUD */
/* Group Functions */
/* Aggregate data for analysis */
SELECT ROUND(AVG(SALARY), 2) AS AvgSalary, 
       MAX(SALARY) AS MaxSalary, 
       MIN(SALARY) AS MinSalary
FROM EMPLOYEES
WHERE JOB_ID LIKE '%REP%';

/* Earliest and latest hire dates */
SELECT MIN(HIRE_DATE) AS EarliestHire, 
       MAX(HIRE_DATE) AS LatestHire
FROM EMPLOYEES;

/* Count employees in a department */
SELECT COUNT(*) AS EmployeeCount
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 90;

/* Count non-NULL commission percentages */
SELECT COUNT(COMMISSION_PCT) AS CommissionCount
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 90;

/* View commission data for context */
SELECT COMMISSION_PCT
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 90;

/* Average commission, handling NULLs */
SELECT AVG(ISNULL(COMMISSION_PCT, 0)) AS AvgCommission
FROM EMPLOYEES;

/* Count unique departments */
SELECT COUNT(DISTINCT DEPARTMENT_ID) AS UniqueDepts
FROM EMPLOYEES;

/* GROUP BY - Aggregating by Department */
SELECT DEPARTMENT_ID, 
       AVG(SALARY) AS AvgSalary, 
       MIN(SALARY) AS MinSalary, 
       MAX(SALARY) AS MaxSalary
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY MAX(SALARY) DESC;

/* GROUP BY with Filtering */
SELECT DEPARTMENT_ID, 
       AVG(SALARY) AS AvgSalary, 
       MIN(SALARY) AS MinSalary, 
       MAX(SALARY) AS MaxSalary
FROM EMPLOYEES
WHERE JOB_ID IN ('AD_VP', 'AD_PRES', 'IT_PROG')
GROUP BY DEPARTMENT_ID
ORDER BY MAX(SALARY) DESC;

/* GROUP BY Rule Violation */
/* Rule: All non-aggregated columns in SELECT must be in GROUP BY */
/* Violation: Missing GROUP BY causes an error */
-- This will fail
SELECT DEPARTMENT_ID, AVG(SALARY)
FROM EMPLOYEES;

/* Correct Code: Include GROUP BY */
SELECT DEPARTMENT_ID, AVG(SALARY) AS AvgSalary
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

/* Multiple Columns in GROUP BY */
SELECT DEPARTMENT_ID, JOB_ID, AVG(SALARY) AS AvgSalary
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID;

/* Counting Multiple Columns */
SELECT DEPARTMENT_ID, 
       COUNT(JOB_ID) AS JobCount, 
       COUNT(LAST_NAME) AS NameCount
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

/* WHERE Clause Limitation with Groups */
/* Rule: WHERE cannot filter groups; use HAVING instead */
/* Violation: Using WHERE with aggregate functions fails */
-- This will fail
SELECT DEPARTMENT_ID, AVG(SALARY)
FROM EMPLOYEES
WHERE AVG(SALARY) > 10000
GROUP BY DEPARTMENT_ID;

/* Correct Code: Use HAVING */
SELECT DEPARTMENT_ID, AVG(SALARY) AS AvgSalary
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) > 10000;

/* HAVING with Pre-Filtering */
SELECT DEPARTMENT_ID, AVG(SALARY) AS AvgSalary
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (50, 60, 80, 90)
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) > 5000;

/* Activities for Group Functions */
/* Activity 1: Days with 2 or more hires */
SELECT FORMAT(HIRE_DATE, 'dddd') AS HireDay,
       COUNT(*) AS HireCount
FROM EMPLOYEES
GROUP BY FORMAT(HIRE_DATE, 'dddd')
HAVING COUNT(*) >= 2;

/* Activity 2: Staff turnover by year and job */
SELECT YEAR(END_DATE) AS QuitYear, 
       JOB_ID, 
       COUNT(*) AS TurnoverCount
FROM EMPLOYEES
WHERE END_DATE IS NOT NULL
GROUP BY YEAR(END_DATE), JOB_ID
ORDER BY TurnoverCount DESC;

/* Activity 3: Average length of country names */
SELECT ROUND(AVG(LEN(COUNTRY_ID)), 0) AS AvgCountryLength
FROM LOCATIONS;

/* Joins */
/* Natural Join (Not Recommended in SQL Server) */
/* Rule: SQL Server supports JOIN syntax; avoid NATURAL JOIN due to ambiguity */
/* Violation: NATURAL JOIN can join unintended columns with the same name */
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID, CITY
FROM DEPARTMENTS
INNER JOIN LOCATIONS
ON DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID;

/* Explicit Join with Table Aliases */
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, D.LOCATION_ID, L.CITY
FROM DEPARTMENTS D, LOCATIONS L
WHERE D.LOCATION_ID = L.LOCATION_ID;

/* Join with Filtering */
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID, CITY
FROM DEPARTMENTS
INNER JOIN LOCATIONS
ON DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID
WHERE DEPARTMENT_ID IN (50, 60, 80);

/* Inner Join with Aliases */
SELECT E.LAST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

/* Join Using Clause */
/* Rule: USING specifies the join column; column names must match */
/* Violation: Aliasing the column in USING causes an error */
SELECT LAST_NAME, DEPARTMENT_ID, E.MANAGER_ID
FROM EMPLOYEES E
JOIN DEPARTMENTS D
USING (DEPARTMENT_ID)
WHERE DEPARTMENT_ID = 80;

/* Violation: Aliasing column in USING */
-- This will fail
SELECT LAST_NAME, DEPARTMENT_ID, E.MANAGER_ID
FROM EMPLOYEES E
JOIN DEPARTMENTS D
USING (DEPARTMENT_ID)
WHERE D.DEPARTMENT_ID = 80;

/* Correct Code: Avoid aliasing in USING */
SELECT LAST_NAME, DEPARTMENT_ID, E.MANAGER_ID
FROM EMPLOYEES E
JOIN DEPARTMENTS D
USING (DEPARTMENT_ID)
WHERE DEPARTMENT_ID = 80;

/* Join with ON Clause */
SELECT EMPLOYEE_ID, LAST_NAME, E.DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID
FROM EMPLOYEES E
JOIN DEPARTMENTS D
ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID);

/* Multiple Joins */
SELECT EMPLOYEE_ID, LAST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME, L.LOCATION_ID, L.CITY
FROM EMPLOYEES E
JOIN DEPARTMENTS D
ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID;

/* Self Join */
SELECT E.FIRST_NAME, E.LAST_NAME, MGR.FIRST_NAME AS MgrFirstName, MGR.LAST_NAME AS MgrLastName
FROM EMPLOYEES E
JOIN EMPLOYEES MGR
ON (E.MANAGER_ID = MGR.EMPLOYEE_ID);

/* Non-Equi Join */
SELECT E.LAST_NAME, E.SALARY, J.JOB_TITLE
FROM EMPLOYEES E
JOIN JOBS J
ON E.SALARY BETWEEN J.MIN_SALARY AND J.MAX_SALARY;

/* Cross Join */
SELECT EMPLOYEE_ID, DEPARTMENT_NAME
FROM EMPLOYEES
CROSS JOIN DEPARTMENTS;

/* Outer Joins */
SELECT LAST_NAME, D.DEPARTMENT_ID, DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT OUTER JOIN DEPARTMENTS D
ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID);

SELECT LAST_NAME, D.DEPARTMENT_ID, DEPARTMENT_NAME
FROM EMPLOYEES E
RIGHT OUTER JOIN DEPARTMENTS D
ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID);

SELECT LAST_NAME, D.DEPARTMENT_ID, DEPARTMENT_NAME
FROM EMPLOYEES E
FULL OUTER JOIN DEPARTMENTS D
ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID);

/* Activities for Joins */
/* Activity 1: Natural join results */
SELECT EMPLOYEE_ID, JOB_ID, DEPARTMENT_ID, LAST_NAME, HIRE_DATE, END_DATE
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

/* Activity 2: Manager report */
SELECT E.FIRST_NAME + ' ' + E.LAST_NAME + ' is manager of the ' + D.DEPARTMENT_NAME AS Managers
FROM EMPLOYEES E
JOIN DEPARTMENTS D
ON D.MANAGER_ID = E.EMPLOYEE_ID;

/* Activity 3: Departments with no employees */
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM DEPARTMENTS D
LEFT OUTER JOIN EMPLOYEES E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE E.EMPLOYEE_ID IS NULL;

/* Activity 4: Employee and manager details */
SELECT E.LAST_NAME, E.EMPLOYEE_ID, M.LAST_NAME AS ManagerLastName, E.DEPARTMENT_ID
FROM EMPLOYEES E
JOIN EMPLOYEES M
ON E.MANAGER_ID = M.EMPLOYEE_ID
WHERE E.DEPARTMENT_ID IN (10, 20, 30)
ORDER BY E.DEPARTMENT_ID;

/* Subqueries */
/* Single-Row Subquery */
SELECT MAX(SALARY) AS MaxSalary
FROM EMPLOYEES;

/* Nested Subquery: Second highest salary */
SELECT MAX(SALARY) AS SecondHighest
FROM EMPLOYEES
WHERE SALARY < (SELECT MAX(SALARY) FROM EMPLOYEES);

/* Nested Subquery: Third highest salary */
SELECT MAX(SALARY) AS ThirdHighest
FROM EMPLOYEES
WHERE SALARY < (SELECT MAX(SALARY)
                FROM EMPLOYEES
                WHERE SALARY < (SELECT MAX(SALARY) FROM EMPLOYEES));

/* Top 5 Salaries */
SELECT TOP 5 *
FROM EMPLOYEES
ORDER BY SALARY DESC;

/* Violation: Incorrect ordering with row limiting */
/* Rule: TOP applies before ORDER BY in SQL Server */
/* Violation: This will not guarantee top 5 salaries */
-- This will fail to give correct results
SELECT *
FROM EMPLOYEES
WHERE ROW_NUMBER() OVER (ORDER BY SALARY DESC) <= 5;

/* Correct Code: Use TOP with ORDER BY */
SELECT TOP 5 *
FROM EMPLOYEES
ORDER BY SALARY DESC;

/* Subquery with ANY */
SELECT LAST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY < ANY (SELECT SALARY FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG')
AND JOB_ID <> 'IT_PROG';

/* Subquery with ALL */
SELECT LAST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY < ALL (SELECT SALARY FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG')
AND JOB_ID <> 'IT_PROG';

/* Subquery with EXISTS */
SELECT EMPLOYEE_ID, SALARY, LAST_NAME
FROM EMPLOYEES E
WHERE EXISTS
(SELECT EMPLOYEE_ID FROM EMPLOYEES E1
WHERE E1.MANAGER_ID = E.EMPLOYEE_ID
AND E1.SALARY > 10000);

/* Subquery with NOT EXISTS */
SELECT DEPARTMENT_ID, DEPARTMENT_NAME
FROM DEPARTMENTS D
WHERE NOT EXISTS
(SELECT * FROM EMPLOYEES E
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID);

/* Subquery with NOT IN */
SELECT E.LAST_NAME
FROM EMPLOYEES E
WHERE E.EMPLOYEE_ID NOT IN 
(SELECT MGR.MANAGER_ID FROM EMPLOYEES MGR WHERE MGR.MANAGER_ID IS NOT NULL);

/* Activities for Subqueries */
/* Activity 1: Identify managers */
SELECT E1.LAST_NAME
FROM EMPLOYEES E1
WHERE EXISTS
(SELECT * FROM EMPLOYEES E2 WHERE E2.MANAGER_ID = E1.EMPLOYEE_ID);

/* Activity 2: Highest salary per country */
SELECT L.COUNTRY_ID, MAX(E.SALARY) AS MaxSalary
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
GROUP BY L.COUNTRY_ID;

/* CRUD Operations */
/* Create a Sample Table */
CREATE TABLE RETAIL_DB1 (
    CUST_ID INT NOT NULL,
    CUST_NAME VARCHAR(10) NOT NULL,
    CITY CHAR(10),
    CONSTRAINT RETAILDB_PK PRIMARY KEY (CUST_ID)
);

/* Describe the Table */
EXEC sp_help 'dbo.RETAIL_DB1';

/* Alternative Table Creation */
CREATE TABLE MYRETAIL_DB1 (
    CUST_ID INT CONSTRAINT RETAILDB2_PK PRIMARY KEY,
    CUST_NAME VARCHAR(10) NOT NULL,
    CITY CHAR(10)
);

/* Alter Table */
ALTER TABLE RETAIL_DB1 ADD GENDER CHAR(5), PROF CHAR(5);
ALTER TABLE RETAIL_DB1 ALTER COLUMN GENDER CHAR(10);
ALTER TABLE RETAIL_DB1 ALTER COLUMN PROF VARCHAR(10);
ALTER TABLE RETAIL_DB1 DROP COLUMN PROF;
EXEC sp_rename 'RETAIL_DB1', 'MYRETAIL_DB2';

/* Insert Data */
INSERT INTO MYRETAIL_DB2 (CUST_ID, CUST_NAME, CITY) 
VALUES (101, 'RAM', 'BLR');

/* Set Table to Read-Only (SQL Server uses Constraints) */
/* Rule: SQL Server doesn't support ALTER TABLE READ ONLY directly */
/* Violation: Attempting Oracle syntax fails */
-- This will fail
-- ALTER TABLE MYRETAIL_DB2 READ ONLY;

/* Correct Code: Use DENY to restrict modifications */
DENY INSERT, UPDATE, DELETE ON MYRETAIL_DB2 TO PUBLIC;

/* Attempt Insert (Will Fail) */
INSERT INTO MYRETAIL_DB2 (CUST_ID, CUST_NAME, CITY) 
VALUES (102, 'BHEEM', 'MLR');

/* Revert Permissions */
GRANT INSERT, UPDATE, DELETE ON MYRETAIL_DB2 TO PUBLIC;

/* Insert Data */
INSERT INTO MYRETAIL_DB2 (CUST_ID, CUST_NAME, CITY) 
VALUES (102, 'BHEEM', 'MLR');

/* Drop Constraint and Insert Duplicate (Will Fail Initially) */
ALTER TABLE MYRETAIL_DB2 DROP CONSTRAINT RETAILDB_PK;
INSERT INTO MYRETAIL_DB2 (CUST_ID, CUST_NAME, CITY) 
VALUES (102, 'JOHN', 'MLR');

/* Delete Data */
DELETE FROM MYRETAIL_DB2 WHERE CUST_ID = 102;

/* Drop Tables */
DROP TABLE MYRETAIL_DB2;
DROP TABLE MYRETAIL_DB1;
GO