-- SQL Server 2016 or later
DROP TABLE IF EXISTS Table1;
DROP TABLE IF EXISTS #Table1; -- Note that you can dispense with the "tempdb.." prefix before #Table1.
DROP VIEW IF EXISTS View1;
DROP PROCEDURE IF EXISTS Procedure1;
DROP TABLE IF EXISTS Function1;
ALTER TABLE Table1 DROP CONSTRAINT IF EXISTS FK_Table1_Column1;
DROP TRIGGER IF EXISTS Trigger1;
DROP INDEX IF EXISTS Index1;
DROP SEQUENCE IF EXISTS Sequence1;
DROP SYNONYM IF EXISTS Synonym1;
IF SUSER_ID('Login1') IS NOT NULL DROP LOGIN Login1; -- Same as SQL Server 2014 or earlier
IF USER_ID('User1') IS NOT NULL DROP USER User1; -- Same as SQL Server 2014 or earlier

-- SQL Server 2014 or earlier
IF OBJECT_ID('Table1', 'U') IS NOT NULL DROP TABLE Table1;
IF OBJECT_ID('tempdb..#Table1', 'U') IS NOT NULL DROP TABLE #Table1; -- Note that you must prepend "tempdb.." to #Table1 to check the existence but can dispense with the prefix in DROP TABLE.
IF OBJECT_ID('View1', 'V') IS NOT NULL DROP VIEW View1;
IF OBJECT_ID('Procedure1', 'P') IS NOT NULL DROP PROCEDURE Procedure1;
IF OBJECT_ID('Function1', 'FN') IS NOT NULL DROP FUNCTION Function1;
IF EXISTS (SELECT NULL FROM sys.objects WHERE object_id = OBJECT_ID('Procedure1') AND type IN ('P', 'PC')) DROP PROCEDURE Procedure1;
IF EXISTS (SELECT NULL FROM sys.objects WHERE object_id = OBJECT_ID('Function1') AND type IN ('FN', 'FS', 'FT', 'IF', 'TF')) DROP FUNCTION Function1;
IF EXISTS (SELECT NULL FROM sys.objects WHERE name = 'FK_Table1_Column1' AND type = 'F') ALTER TABLE Table1 DROP CONSTRAINT FK_Table1_Column1;
IF EXISTS (SELECT NULL FROM sys.triggers WHERE name = 'Trigger1') DROP TRIGGER Trigger1;
IF EXISTS (SELECT NULL FROM sys.indexes WHERE name = 'Index1' AND object_id = OBJECT_ID('Table1')) DROP INDEX Index1 ON Table1;
IF OBJECT_ID('Sequence1', 'SO') IS NOT NULL DROP SEQUENCE Sequence1;
IF OBJECT_ID('Synonym1', 'SN') IS NOT NULL DROP SYNONYM Synonym1;
IF SUSER_ID('Login1') IS NOT NULL DROP LOGIN Login1; -- Same as SQL Server 2014 or later
IF USER_ID('User1') IS NOT NULL DROP USER User1; -- Same as SQL Server 2014 or later
