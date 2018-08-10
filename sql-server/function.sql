CREATE OR ALTER FUNCTION ScalarValuedFunction(@S1 nvarchar(max), @S2 nvarchar(max))
RETURNS nvarchar(max)
AS
BEGIN
  DECLARE @S3 nvarchar(max);
  SET @S3 = @S1 + @S2;
  RETURN @S3;
END;
GO

SELECT dbo.ScalarValuedFunction('Foo', 'Bar');

--

CREATE OR ALTER FUNCTION InlineTableValuedFunction()
RETURNS TABLE
AS  
RETURN
  SELECT 1 Id, 'Foo' Name
  UNION ALL
  SELECT 2 Id, 'Bar' Name
  UNION ALL
  SELECT 3 Id, 'Baz' Name;
GO

SELECT * FROM InlineTableValuedFunction();

--

CREATE OR ALTER FUNCTION MultiStatementTableValuedFunction()
RETURNS @Table
TABLE
(
  Id int IDENTITY PRIMARY KEY,
  Name varchar(max) NOT NULL
)
AS
BEGIN
  INSERT INTO @Table VALUES('Foo');
  INSERT INTO @Table VALUES('Bar');
  INSERT INTO @Table VALUES('Baz');
  RETURN;
END;
GO

SELECT * FROM MultiStatementTableValuedFunction();

--

CREATE OR ALTER FUNCTION IsBetween(@From decimal, @X decimal, @To decimal)
RETURNS bit
AS
BEGIN
  RETURN IIF(@From <= @X AND @X <= @To, 1, 0);

  -- Earlier than SQL Server 2012
  -- RETURN CASE WHEN @From <= @X AND @X <= @To THEN 1 ELSE 0 END;
END;

-- Though the return type is bit, dbo.IsBetween(...) requires '= 1' to be used as boolean.
SELECT 'Foo' WHERE dbo.IsBetween(1, 2, 3) = 1

--

CREATE OR ALTER FUNCTION SplitLast(@XPath nvarchar(max), @Separator nchar(1))
RETURNS @Table TABLE
(
  ExceptLastElement nvarchar(max),
  LastElement nvarchar(max)
)
BEGIN
  DECLARE @Index int;
  SET @Index = CHARINDEX(@Separator, REVERSE(@XPath));

  IF @Index <> 0
  BEGIN
    INSERT INTO @Table VALUES(LEFT(@XPath, LEN(@XPath) - @Index), RIGHT(@XPath, @Index - 1))
  END;
  
  RETURN;
END;
GO

SELECT * FROM SplitLast('/Foo/Bar/Baz', '/')

--

CREATE OR ALTER FUNCTION JapaneseTrim(@S nvarchar(max))
RETURNS nvarchar(max)
BEGIN
  RETURN TRIM(REPLACE(@S, N'　', ' ')));
END;
