DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;

CREATE TABLE Department
(
  ID int IDENTITY(1, 1) PRIMARY KEY,
  Name nvarchar(max) NOT NULL
);

CREATE TABLE Employee
(
  ID int IDENTITY(1, 1) PRIMARY KEY,
  Name nvarchar(max) NOT NULL,
  DepartmentID int NOT NULL REFERENCES Department(ID)
);

INSERT INTO Department VALUES
('HR'),
('Sales'),
('IT');

INSERT INTO Employee VALUES
('Micky', 1),
('Goofy', 2),
('Donald', 2);
GO

CREATE OR ALTER FUNCTION GetEmployeesByDepartment(@DepartmentID int)
RETURNS TABLE
AS
RETURN
  SELECT * FROM Employee WHERE DepartmentID = @DepartmentID;
GO

-- Syntax error because a column cannot be passed to a function as a parameter.
-- SELECT * FROM Department D JOIN GetEmployeesByDepartment(D.ID) E ON D.ID = E.ID;

-- Example of CROSS APPLY
SELECT D.ID DepartmentID,
       D.Name DepartmentName,
	   E.ID EmployeeID,
	   E.Name EmployeeName
FROM Department D
CROSS APPLY GetEmployeesByDepartment(ID) E

-- Example of OUTER APPLY
SELECT D.ID DepartmentID,
       D.Name DepartmentName,
	   E.ID EmployeeID,
	   E.Name EmployeeName
FROM Department D
OUTER APPLY GetEmployeesByDepartment(ID) E
