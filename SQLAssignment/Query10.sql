-- Write a stored procedure that takes a table name and a column name as parameters and returns the distinct values from that column.
CREATE PROCEDURE GetDistinctValues
    @TableName NVARCHAR(128),
    @ColumnName NVARCHAR(128)
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX)

    SET @SQL = N'SELECT DISTINCT ' + QUOTENAME(@ColumnName) + ' FROM ' + QUOTENAME(@TableName)

    EXEC sp_executesql @SQL
END

EXEC GetDistinctValues @TableName ='Sales', @ColumnName ='ProductID';
