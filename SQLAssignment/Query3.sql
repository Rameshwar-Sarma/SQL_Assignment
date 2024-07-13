-- Write a stored procedure that returns the highest, lowest, and average order amounts for a given customer using output parameters.
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderAmount DECIMAL(18, 2),
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
INSERT INTO Orders (OrderID, CustomerID, OrderAmount, OrderDate) VALUES
(1, 1, 150.50, '2024-01-10'),
(2, 2, 250.75, '2024-02-15'),
(3, 3, 300.00, '2024-03-20'),
(4, 4, 450.25, '2024-04-25'),
(5, 5, 500.50, '2024-05-30'),
(6, 1, 125.75, '2024-06-05'),
(7, 2, 175.00, '2024-07-10'),
(8, 3, 200.50, '2024-08-15'),
(9, 4, 225.25, '2024-09-20'),
(10, 5, 275.75, '2024-10-25');

-- Stored Procedure
GO
CREATE PROCEDURE GetHighLowAverage (
    @CustomerID INT,
    @HighestAmount DECIMAL(10, 2) OUTPUT,
	@LowestAmount DECIMAL(10, 2) OUTPUT,
	@AverageAmount DECIMAL(10, 2) OUTPUT
)
AS
BEGIN
    SELECT @HighestAmount = MAX(OrderAmount), @LowestAmount = MIN(OrderAmount), @AverageAmount = AVG(OrderAmount)
    FROM Orders 
    WHERE CustomerID = @CustomerID;
END
GO
DECLARE @High DECIMAL(10, 2);
DECLARE @Low DECIMAL(10, 2);
DECLARE @Average DECIMAL(10, 2);
EXEC GetHighLowAverage @CustomerID = 5, @HighestAmount = @High OUTPUT, @LowestAmount = @Low OUTPUT, @AverageAmount = @Average OUTPUT;

-- Display the result
SELECT @High AS Highest_Order_Amount, @Low AS Lowest_Order_Amount, @Average  AS Average_Amount;