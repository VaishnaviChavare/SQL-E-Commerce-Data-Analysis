
-- Drop tables if they already exist
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Country VARCHAR(50),
    SignupDate DATE
);

-- Create Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    Stock INT
);

-- Create Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert Customers
INSERT INTO Customers VALUES 
(1, 'John', 'Doe', 'john@example.com', 'USA', '2023-01-15'),
(2, 'Alice', 'Smith', 'alice@example.com', 'UK', '2023-02-20'),
(3, 'Bob', 'Lee', 'bob@example.com', 'India', '2023-03-05');

-- Insert Products
INSERT INTO Products VALUES 
(1, 'iPhone 13', 'Electronics', 999.99, 50),
(2, 'AirPods', 'Electronics', 199.99, 100),
(3, 'Gaming Chair', 'Furniture', 149.99, 20),
(4, 'Coffee Mug', 'Kitchen', 9.99, 500);

-- Insert Orders
INSERT INTO Orders VALUES 
(1, 1, '2023-04-01', 1199.98),
(2, 2, '2023-04-02', 9.99),
(3, 1, '2023-04-05', 149.99);

-- Insert OrderDetails
INSERT INTO OrderDetails VALUES 
(1, 1, 1, 1, 999.99),
(2, 1, 2, 1, 199.99),
(3, 2, 4, 1, 9.99),
(4, 3, 3, 1, 149.99);

SELECT * 
FROM Customers
WHERE Country = 'USA'
ORDER BY SignupDate;

SELECT c.Country, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.Country
ORDER BY TotalOrders DESC;

SELECT c.FirstName, c.LastName, o.OrderID, o.OrderDate, o.TotalAmount
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID;

SELECT c.FirstName, c.LastName, o.OrderID
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;

SELECT c.FirstName, c.LastName, o.OrderID
FROM Orders o
RIGHT JOIN Customers c ON o.CustomerID = c.CustomerID;

SELECT FirstName, LastName 
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID 
    FROM Orders 
    GROUP BY CustomerID
    HAVING SUM(TotalAmount) > 1000
);

SELECT * 
FROM Products
WHERE Price = (
    SELECT MAX(Price) FROM Products
);

SELECT SUM(TotalAmount) AS TotalRevenue
FROM Orders;

SELECT AVG(TotalAmount) AS AverageOrderValue
FROM Orders;

SELECT p.Category, SUM(od.Quantity * od.Price) AS Revenue
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY Revenue DESC;

SELECT * FROM MonthlyCustomerOrderSummary
ORDER BY Month;

SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;











