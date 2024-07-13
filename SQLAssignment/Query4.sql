-- Write a query to find the second highest salary from an Employees table without using the TOP or LIMIT clause.
CREATE PROCEDURE GetSecondHighestSalary (
    @second_highest_salary DECIMAL(18, 2) OUTPUT
)
AS
BEGIN
    -- Find the second highest salary
    SELECT  @second_highest_salary = MAX(salary)
    FROM Employees
    WHERE Salary < (SELECT MAX(Salary) FROM Employees);
END;
GO
-- Execute Stored Procedure
DECLARE @MaxSecondSalary DECIMAL(18, 2);
EXEC GetSecondHighestSalary @second_highest_salary = @MaxSecondSalary OUTPUT;

-- Display the result
SELECT @MaxSecondSalary AS SecondHighestSalary;