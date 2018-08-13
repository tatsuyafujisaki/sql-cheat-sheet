DROP TABLE IF EXISTS Table1;

CREATE TABLE Table1
(
  Id int IDENTITY PRIMARY KEY,
  Name nvarchar(max) NOT NULL
);
GO

CREATE OR ALTER PROCEDURE InsertSomething
@Parameter1 nvarchar(max),
@Result1 nvarchar(max) OUT,
@Result2 nvarchar(max) OUT
AS
BEGIN
  INSERT INTO Table1 (Name) VALUES (@Parameter1)
  SET @Result1 = 'Foo';
  SET @Result2 = 'Bar';
END;
GO

DECLARE @ReturnCode int;
DECLARE @Result1 nvarchar(max);
DECLARE @Result2 nvarchar(max);

EXECUTE @ReturnCode = InsertSomething 'Name1', @Result1 OUT, @Result2 OUT;

SELECT @ReturnCode, @Result1, @Result2;
SELECT * FROM Table1;
