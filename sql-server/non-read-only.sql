-- Insert multiple rows
INSERT INTO Table1 VALUES
('Foo', 123),
('Bar', 456);

-- Use a newline in a value
INSERT INTO Table1 VALUES(CONCAT('First line', NCHAR(13), NCHAR(10), N'Second line'));

-- Insert a record without explicit parameters
INSERT INTO Table1 DEFAULT VALUES;

-- Drop all foreign keys
WHILE(EXISTS(SELECT NULL FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_TYPE='FOREIGN KEY'))
BEGIN
  DECLARE @SQL nvarchar(max)
  SELECT @SQL = CONCAT('ALTER TABLE ', TABLE_SCHEMA, '.[', TABLE_NAME, '] DROP CONSTRAINT [', CONSTRAINT_NAME, ']')
  FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
  WHERE CONSTRAINT_TYPE = 'FOREIGN KEY';
  
  EXECUTE sp_executesql @SQL;
END;

SET XACT_ABORT ON;

BEGIN TRANSACTION
  -- Test a destructive change you want to test here.
ROLLBACK;

SET XACT_ABORT OFF;

-- Copy a record in Database1.dbo.Table1 to Datababse2.dbo.Table1
INSERT INTO Database2.dbo.Table1
SELECT * FROM Database1.dbo.Table1
WHERE Column1 = 'Foo';
