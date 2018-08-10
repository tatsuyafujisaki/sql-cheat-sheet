DROP TABLE IF EXISTS Table1;

CREATE TABLE Table1
(
  Column1 nvarchar(max)
);

-- Example 1: Partially committed because XACT_ABORT is OFF and TRY...CATCH is not used.
SET XACT_ABORT OFF;

BEGIN TRANSACTION
  INSERT INTO Table1 VALUES ('I am committed.');
  INSERT INTO Table1 VALUES (1/0); -- Error and continue because XACT_ABORT is OFF.
  INSERT INTO Table1 VALUES ('I am committed too.');
COMMIT;
GO

-- Example 2: All committed or all rolled back because XACT_ABORT is ON.
SET XACT_ABORT ON;

BEGIN TRANSACTION
  INSERT INTO Table1 VALUES ('I am rolled back.');
  INSERT INTO Table1 VALUES (1/0); -- Error and roll back because XACT_ABORT is ON.
  PRINT 'I am not reached.';
COMMIT;

SELECT * FROM Table1;

-- Example 3: All committed or all rolled back because TRY...CATCH is used.
SET XACT_ABORT OFF;

BEGIN TRY
  BEGIN TRANSACTION
    INSERT INTO Table1 VALUES ('I am rolled back.');
    INSERT INTO Table1 VALUES (1/0); -- Error and jump to the CATCH clause.
    PRINT 'I am not reached.';
  COMMIT;
END TRY
BEGIN CATCH
  IF XACT_STATE() = 1
  BEGIN
    PRINT ERROR_MESSAGE();
    ROLLBACK;
  END;
END CATCH;
