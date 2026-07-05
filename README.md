# DataTransformer SQL Project

## Overview

This project demonstrates core MySQL concepts using a simple
customer-order-employee database.

## Database

-   Database: `DataTransformer`

## Tables

1.  Customers
    -   CustomerID (PK)
    -   FirstName
    -   LastName
    -   Email
    -   RegistrationDate
2.  Orders
    -   OrderID (PK)
    -   CustomerID (FK → Customers.CustomerID)
    -   OrderDate
    -   TotalAmount
3.  Employees
    -   EmployeeID (PK)
    -   FirstName
    -   LastName
    -   Department
    -   HireDate
    -   Salary

## Features Demonstrated

-   Database and table creation
-   Primary and foreign keys
-   Sample data insertion
-   INNER, LEFT, RIGHT and FULL OUTER JOIN (using UNION)
-   Date functions:
    -   YEAR()
    -   MONTH()
    -   MONTHNAME()
    -   DATEDIFF()
-   String functions:
    -   UPPER()
    -   LOWER()
    -   TRIM()
-   Window functions:
    -   SUM() OVER() for running totals
    -   RANK() OVER()
-   CASE expressions:
    -   Order discount calculation
    -   Employee salary categorization

## Requirements

-   MySQL 8.0 or later

## How to Run

1.  Open MySQL Workbench.
2.  Execute `Project_DataTransformer.sql`.
3.  Run the queries individually to observe the results.

## Learning Objectives

-   Practice DDL and DML statements.
-   Work with joins and foreign keys.
-   Use date and string functions.
-   Learn window functions.
-   Apply conditional logic using CASE.

## Author

Created as a MySQL practice project.
