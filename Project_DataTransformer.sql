-- Create Database
CREATE DATABASE DataTransformer;
USE DataTransformer;

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    RegistrationDate DATE NOT NULL
);

INSERT INTO Customers (FirstName, LastName, Email, RegistrationDate)
VALUES
('John', 'Smith', 'john.smith@email.com', '2024-01-15'),
('Emma', 'Johnson', 'emma.johnson@email.com', '2024-01-20'),
('Michael', 'Brown', 'michael.brown@email.com', '2024-02-05'),
('Sophia', 'Davis', 'sophia.davis@email.com', '2024-02-18'),
('William', 'Miller', 'william.miller@email.com', '2024-03-02'),
('Olivia', 'Wilson', 'olivia.wilson@email.com', '2024-03-15');

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_customer
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES
(1, '2026-04-01', 1200.50),
(3, '2026-03-03', 850.00),
(5, '2026-02-05', 2300.75),
(2, '2026-06-08', 950.25),
(4, '2026-02-10', 1750.00),
(1, '2026-01-15', 3200.99);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    HireDate DATE NOT NULL,
    Salary DECIMAL(10,2) NOT NULL
);

INSERT INTO Employees (FirstName, LastName, Department, HireDate, Salary)
VALUES
('Amit', 'Sharma', 'Sales', '2021-03-15', 45000.00),
('Priya', 'Patel', 'HR', '2020-07-10', 52000.00),
('Rahul', 'Verma', 'IT', '2019-11-25', 68000.00),
('Neha', 'Singh', 'Finance', '2022-01-18', 58000.00),
('Karan', 'Mehta', 'Marketing', '2023-05-08', 47000.00);

--  retrive all customer details which have order (INNER JOIN) --
SELECT * FROM Customers c INNER JOIN Orders o ON o.CustomerID = c.CustomerID;

--  retrive all customer details which have order (Left JOIN) --
SELECT * FROM Customers c LEFT JOIN Orders o ON o.CustomerID = c.CustomerID;

--  retrive all customer details which have order (Right Join) --
SELECT * FROM Customers c RIGHT JOIN Orders o ON o.CustomerID = c.CustomerID;

--  retrive all customer details regardless of order (FULL OUTER JOIN) --
SELECT *
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID

UNION

SELECT *
FROM Customers c
RIGHT JOIN Orders o
ON c.CustomerID = o.CustomerID;

-- find customer who have placed order worth more than  average amount
SELECT 
c.CustomerID,
c.FirstName,
c.LastName,
o.OrderID,
o.TotalAmount
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE 
o.TotalAmount > (
SELECT AVG(TotalAmount) FROM Orders 
);

 -- find employee salary higher than average salary
 SELECT * FROM employees WHERE salary > (SELECT AVG(salary) FROM employees);
 
 -- exctract year and month from the OrderDate
 SELECT *,YEAR(OrderDate) AS year , DATE_FORMAT(OrderDate,'%b') AS month FROM Orders;
 
 -- calculate days differrence between orderDate and current Date
  SELECT OrderID, OrderDate,DATEDIFF(CURDATE(), OrderDate) AS DaysSinceOrder FROM Orders;
  
  -- change the  date format to "DD-MM-YYYY"
  SELECT OrderID, OrderDate,DATE_FORMAT(OrderDate, '%d-%m-%Y') AS formatted_date FROM Orders;
  
  -- concat firstname and last name
  SELECT EmployeeID,CONCAT(FirstName," ",LastName) as FullName, Department FROM employees;
  
  -- replace the part of the string
UPDATE Customers
SET FirstName = REPLACE(FirstName, 'John', 'Johnny')
WHERE FirstName = 'John';
  
 SELECT * FROM Customers;
 
-- convert first name to uppercase and last name to lower case 
UPDATE Customers
SET FirstName = UPPER(FirstName),
    LastName = LOWER(LastName);
    
SELECT * FROM Customers;

-- Trim extra spaces from the email field
UPDATE Customers SET Email = TRIM(Email); 
SELECT * FROM Customers;

-- calculate the running total of the total amount
SELECT *,
SUM(TotalAmount) OVER(
ORDER BY OrderDate
)
AS RunningTotal
FROM Orders;

-- Rank orderd using Rank() function on TotalAmount
SELECT *,
Rank() OVER(
ORDER BY TotalAmount
)
AS OrderRank
FROM Orders;

-- Assign discount according to the TotalAmount
SELECT
    OrderID,
    CustomerID,
    TotalAmount,
CASE 
	WHEN TotalAmount > 3000 THEN TotalAmount * 0.20
    WHEN TotalAmount > 2000 THEN TotalAmount * 0.15
    WHEN TotalAmount > 1000 THEN TotalAmount * 0.10
    ELSE TotalAmount * 0.05
END AS DiscountedPrice
FROM Orders;

-- Categorize the salary as high,medium,low
SELECT
   EmployeeID ,
    FirstName,
    LastName,
    Salary,
CASE 
	WHEN salary >= 60000 THEN "high"
    WHEN salary >= 40000 THEN "medium"
    ELSE "low"
END AS SalaryCategory
FROM employees;

