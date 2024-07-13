-- You have the following tables:

-- Sales (SaleID, ProductID, SaleDate, Quantity)
-- Products (ProductID, ProductName, CategoryID)
-- Categories (CategoryID, CategoryName)
-- Write a query to find the total quantity of products sold per category in the last month.

SELECT c.CategoryID, SUM(Quantity) AS Total_Quantities
FROM Categories c JOIN Products p 
ON c.CategoryID = p.CategoryID
JOIN Sales s 
ON s.ProductID = p.ProductID
WHERE s.SaleDate >= DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) - 1, 0)
AND s.SaleDate < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)
GROUP BY c.CategoryID;