-- Explain how to create a stored procedure with an output parameter. Write a stored procedure that calculates the total sales amount 
-- for a given customer and returns this value through an output parameter.

Create Database ProductsSalesDB;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(100)
);
 CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName NVARCHAR(100)
);
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    CategoryID INT,
    Price DECIMAL(18, 2),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    SaleDate DATE,
    Quantity INT,
    CustomerID INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
-- Insert data into Customers table
INSERT INTO Customers (CustomerID, CustomerName) VALUES
(1, 'John Doe'),
(2, 'Jane Smith'),
(3, 'Alice Johnson'),
(4, 'Bob Brown'),
(5, 'Charlie Black');

-- Insert data into Categories table
INSERT INTO Categories (CategoryID, CategoryName) VALUES
(1, 'Electronics'),
(2, 'Books'),
(3, 'Clothing'),
(4, 'Furniture'),
(5, 'Toys');

-- Insert data into Products table
INSERT INTO Products (ProductID, ProductName, CategoryID, Price) VALUES
(1, 'Laptop', 1, 999.99),
(2, 'Smartphone', 1, 599.99),
(3, 'Novel', 2, 19.99),
(4, 'T-Shirt', 3, 9.99),
(5, 'Sofa', 4, 299.99),
(6, 'Action Figure', 5, 14.99);

-- Insert data into Sales table
Delete from Sales;
select * from sales;
INSERT INTO Sales (SaleID, ProductID, SaleDate, Quantity, CustomerID) VALUES
(1, 1, '2024-01-01', 1, 1),
(2, 2, '2024-02-01', 2, 2),
(3, 3, '2024-03-01', 3, 3),
(4, 4, '2024-04-01', 4, 4),
(5, 5, '2024-05-01', 1, 5),
(6, 6, '2024-06-01', 2, 1),
(7, 1, '2024-01-05', 1, 2),
(8, 2, '2024-02-10', 2, 3),
(9, 3, '2024-03-15', 3, 4),
(10, 4, '2024-04-20', 4, 5),
(11, 5, '2024-05-25', 1, 1),
(12, 6, '2024-06-30', 2, 2),
(13, 1, '2024-07-01', 1, 3),
(14, 2, '2024-08-01', 2, 4),
(15, 3, '2024-09-01', 3, 5),
(16, 4, '2024-10-01', 4, 1),
(17, 5, '2024-11-01', 1, 2),
(18, 6, '2024-12-01', 2, 3),
(19, 1, '2024-01-10', 1, 4),
(20, 2, '2024-02-15', 2, 5),
(21, 3, '2024-03-20', 3, 1),
(22, 4, '2024-04-25', 4, 2),
(23, 5, '2024-05-30', 1, 3),
(24, 6, '2024-06-05', 2, 4),
(25, 1, '2024-07-10', 1, 5),
(26, 2, '2024-08-15', 2, 1),
(27, 3, '2024-09-20', 3, 2),
(28, 4, '2024-10-25', 4, 3),
(29, 5, '2024-11-30', 1, 4),
(30, 6, '2024-12-05', 2, 5);

-- Stored Procedure
GO
CREATE PROCEDURE TotalSalesByCustomer (
    @CustomerID INT,
    @TotalSales DECIMAL(10, 2) OUTPUT
)
AS
BEGIN
    SELECT @TotalSales = SUM(p.Price * s.Quantity)
    FROM Sales s
    INNER JOIN Products p ON s.ProductID = p.ProductID
    WHERE s.CustomerID = @CustomerID;
END
GO
DECLARE @TotalAmount DECIMAL(18, 2);
EXEC TotalSalesByCustomer @CustomerID = 5, @TotalSales = @TotalAmount OUTPUT;

-- Display the result
SELECT @TotalAmount AS TotalSalesAmount;