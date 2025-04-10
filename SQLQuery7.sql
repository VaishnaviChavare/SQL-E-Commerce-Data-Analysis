CREATE VIEW MonthlyCustomerOrderSummary AS
SELECT 
    FORMAT(c.SignupDate, 'yyyy-MM') AS Month,
    COUNT(DISTINCT c.CustomerID) AS NewCustomers,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(o.TotalAmount) AS Revenue
FROM Customers c
LEFT JOIN Orders o 
    ON MONTH(c.SignupDate) = MONTH(o.OrderDate) 
   AND YEAR(c.SignupDate) = YEAR(o.OrderDate)
GROUP BY FORMAT(c.SignupDate, 'yyyy-MM');
