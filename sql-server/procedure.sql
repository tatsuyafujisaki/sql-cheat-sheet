-- How to parameterize a column name.
EXECUTE sp_executesql N'SELECT * FROM sys.objects WHERE type = @type', N'@type nvarchar(max)', @type = 'U';

-- How to parameterize a table name.
DECLARE @Table nvarchar(max) = 'sys.objects';
DECLARE @SQL nvarchar(max) = CONCAT(N'SELECT * FROM ', @Table, ' WHERE type = ''U''');

EXECUTE sp_executesql @SQL;

--

CREATE OR ALTER PROCEDURE ReturnNothing
AS
BEGIN
  SELECT 'Hello, world!';
  RETURN 0;
END;

DECLARE @ReturnCode int;

EXECUTE @ReturnCode = ReturnNothing;

SELECT @ReturnCode;

--

CREATE OR ALTER PROCEDURE ReturnsScalarValue
@Result nvarchar(100) OUT
AS
BEGIN
  SET @Result = 'Hello, world!';
  RETURN 0;
END;
GO

DECLARE @ReturnCode int;
DECLARE @Result nvarchar(max);

EXECUTE @ReturnCode = ReturnsScalarValue @Result OUT;

SELECT @ReturnCode, @Result;

--

CREATE OR ALTER PROCEDURE ReturnsMultipleValues
@Result1 nvarchar(100) OUT,
@Result2 nvarchar(100) OUT
AS
BEGIN
  SET @Result1 = 'Hello';
  SET @Result2 = 'World';
  RETURN 0;
END;
GO

DECLARE @ReturnCode int;
DECLARE @Result1 nvarchar(max);
DECLARE @Result2 nvarchar(max);

EXECUTE @ReturnCode = ReturnsMultipleValues @Result1 OUT, @Result2 OUT;

SELECT @ReturnCode, @Result1, @Result2;

--

CREATE OR ALTER PROCEDURE TryCatch
@Error nvarchar(max) OUTPUT
AS
BEGIN
  BEGIN TRY
    SELECT 1 / 0;
  END TRY
  BEGIN CATCH
    SET @Error = CONCAT('ERROR_NUMBER = ', CAST(ERROR_NUMBER() AS nvarchar(max)), ', ERROR_MESSAGE = ', ERROR_MESSAGE(), ', ERROR_PROCEDURE = ', ERROR_PROCEDURE(), ', ERROR_LINE = ', CAST(ERROR_LINE() AS nvarchar(max)))
    RETURN -1;
  END CATCH;
END;
GO

DECLARE @ReturnCode int;
DECLARE @Error nvarchar(max);

EXECUTE @ReturnCode = TryCatch @Error OUT;

SELECT @ReturnCode, @Error;

--

CREATE OR ALTER PROCEDURE BackupTable
  @Table nvarchar(max)
AS
BEGIN
  DECLARE @BackupTable nvarchar(max) = CONCAT(@Table, '_', CONVERT(varchar, GETDATE(), 112));
  DECLARE @SQL nvarchar(max) = N'DROP TABLE IF EXISTS ' + @BackupTable;
  
  EXECUTE sp_executesql @SQL;
  
  SET @SQL = CONCAT('SELECT * INTO ', @BackupTable, ' FROM ', @Table);
  
  EXECUTE sp_executesql @SQL;
END;

CREATE OR ALTER PROCEDURE RestoreTable
  @Table nvarchar(max),
  @YYYYMMDD nvarchar(8) -- Backup date
AS
BEGIN
  DECLARE @BackupTable nvarchar(max) = CONCAT(@Table, '_', @YYYYMMDD);
  DECLARE @SQL nvarchar(max) = N'TRUNCATE TABLE ' + @Table;
  
  EXECUTE sp_executesql @SQL;
  
  DECLARE @Columns nvarchar(max);

  SELECT @Columns = COALESCE(@Columns + ', ', '') + COLUMN_NAME
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_NAME = @Table;
  
  SET @SQL = CONCAT('INSERT INTO ', @Table, ' (', @Columns, ') SELECT * FROM ', @BackupTable);

  EXECUTE sp_executesql @SQL;
END;

--

CREATE OR ALTER PROCEDURE PrintDiskUsageByTable
AS
BEGIN
	DECLARE @Table table (
	  Name varchar(128),
	  Rows char(20),
	  Reserved varchar(18),
	  Data varchar(18),
	  IndexSize varchar(18),
	  Unused varchar(18)
	);

	INSERT INTO @Table
	EXECUTE sp_MSforeachtable 'sp_spaceused ''?''';

	SELECT
	name,
	rows,
	CAST(REPLACE(Reserved, ' KB', '') AS int) / 1024 ReservedInMB,
	CAST(REPLACE(Data, ' KB', '') AS int) / 1024 DataInMB,
	CAST(REPLACE(IndexSize, ' KB', '') AS int) / 1024 IndexSizeInMB,
	CAST(REPLACE(Unused, ' KB', '') AS int) / 1024 UnusedMB
	FROM @Table
	ORDER BY ReservedInMB DESC;
END;
