-- Create a stored procedure that accepts an employee ID and a department ID as input parameters, transfers the employee to the new department, 
-- and returns a status message as an output parameter indicating whether the transfer was successful or not.

-- Create Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(100)
);

-- Create Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName NVARCHAR(100),
    DepartmentID INT,
    Salary DECIMAL(18, 2),
    ManagerID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);

-- Insert data into Departments table
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Human Resources'),
(2, 'Finance'),
(3, 'Engineering'),
(4, 'Sales'),
(5, 'Marketing');

-- Insert data into Employees table
INSERT INTO Employees (EmployeeID, EmployeeName, DepartmentID, Salary, ManagerID) VALUES
(1, 'Alice Smith', 1, 60000.00, NULL),
(2, 'Bob Johnson', 2, 65000.00, 1),
(3, 'Charlie Brown', 3, 70000.00, 2),
(4, 'David Wilson', 4, 55000.00, 3),
(5, 'Eve Davis', 5, 60000.00, 4),
(6, 'Frank Miller', 3, 72000.00, 2);

-- Stored Procedure
GO
CREATE PROCEDURE UpdateDepartmentForEmployee (
    @EmployeeID INT,
	@DepartmentID INT
)
AS
BEGIN
	 IF EXISTS (SELECT * FROM Employees WHERE EmployeeID = @EmployeeID) AND EXISTS(SELECT * FROM Departments WHERE DepartmentID = @DepartmentID)
    BEGIN
		UPDATE Employees SET DepartmentID = @DepartmentID WHERE EmployeeID = @EmployeeID;
        PRINT 'Successful !!! The Department is Updated for the given Employee';
    END
	    ELSE
    BEGIN
        PRINT 'Failed !!! Employee does not exist or New Department Not Exist';
    END
END
GO

DECLARE @TotalAmount DECIMAL(18, 2);
EXEC UpdateDepartmentForEmployee @EmployeeID = 5, @DepartmentID = 1;


