-- Create a stored procedure that logs changes to an employee's salary. 
-- The procedure should update the employee's salary and insert a record into a SalaryLog table with details of the change.

CREATE TABLE SalaryLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT,
    OldSalary DECIMAL(18, 2),
    NewSalary DECIMAL(18, 2),
    ChangeDate DATETIME,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Stored Procedure
GO
CREATE PROCEDURE UpdateSalaryLog (
    @EmployeeID INT,
    @NewSalary DECIMAL(10, 2),
	@OldSalary DECIMAL(10, 2) OUTPUT
)
AS
BEGIN
    SELECT @OldSalary = Salary
    FROM Employees
    WHERE EmployeeID = @EmployeeID;
	
	INSERT INTO SalaryLog (EmployeeID, OldSalary, NewSalary, ChangeDate) VALUES (@EmployeeID, @OldSalary, @NewSalary, GETDATE());

	UPDATE Employees
	SET Salary = @NewSalary
	WHERE EmployeeID = @EmployeeID;

	PRINT'Salary Updated and Logged to SalaryLog Table'
END
GO
DECLARE @LastSalary DECIMAL(18, 2);
EXEC UpdateSalaryLog @EmployeeID = 5, @NewSalary =85000, @OldSalary = @LastSalary OUTPUT;

Select * from Employees;