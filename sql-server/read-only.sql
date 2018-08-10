-- Print SQL Server version
SELECT @@VERSION;

-- Print ServerName\InstanceName
SELECT @@SERVERNAME;

-- Print instancename
SELECT @@SERVICENAME;

-- Print a login user
SELECT SYSTEM_USER; -- ANSI-compliant

-- Print 'dbo' instead of a login user if your login user has the sysadmin fixed server-level role
SELECT CURRENT_USER; -- ANSI-compliant
SELECT USER_NAME(); -- Equivalent to CURRENT_USER but not ANSI-compliant

-- Print 'dbo' instead of a login user if your login user has the sysadmin fixed server-level role
SELECT SESSION_USER;

-- Print hostname
SELECT HOST_NAME();

-- Print current date and time
SELECT SYSDATETIME();

-- Print current date
SELECT CAST(SYSDATETIME() AS date);

-- Print current time
SELECT CAST(SYSDATETIME() AS time);

-- Print database name
SELECT DB_NAME();

-- Print the column names of a table
sp_columns Table1;

-- Print the constraints of a table
sp_helpconstraint Table1;

-- Print the disk space of the current datable or a table
EXECUTE sp_spaceused;
EXECUTE sp_spaceused Table1;

-- Print the definition of a procedure or a function
sp_helptext Procedure1;
sp_helptext Function1;

-- Print the detail of the current database including a transaction isolation level
DBCC USEROPTIONS;

-- Place the following in a procedure or a function to get the name of it
-- OBJECT_NAME(@@PROCID);

-- Print miscellaneous metadata
SELECT * FROM sys.database_files;
SELECT * FROM sys.databases;
SELECT * FROM sys.database_principals; -- Print principals such as users, database, and roles in the current database
SELECT * FROM sys.schemas;
SELECT * FROM sys.tables;
SELECT * FROM sys.views;
SELECT * FROM sys.triggers;
SELECT * FROM sys.messages; -- Error messages
SELECT * FROM sys.foreign_keys;
SELECT * FROM INFORMATION_SCHEMA.TABLES;
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS;
SELECT * FROM INFORMATION_SCHEMA.VIEWS;

-- Print user-defined functions
SELECT OBJECT_SCHEMA_NAME(object_id), name, OBJECT_DEFINITION(object_id)
FROM sys.objects
WHERE type IN ('FN', 'IF', 'TF')
    
-- Print callers in the current database, which call a specified callee (procedure, function, table, or view) in the current database.
SELECT referencing_schema_name, referencing_entity_name
FROM sys.dm_sql_referencing_entities('dbo.Callee1', 'OBJECT')
ORDER BY referencing_schema_name, referencing_entity_name;

-- Print callees, in all databases, a specified caller (procedure, function, table, or view) calls.
SELECT referenced_schema_name, referenced_entity_name, referenced_minor_name
FROM sys.dm_sql_referenced_entities('dbo.Caller1', 'OBJECT')
ORDER BY referenced_schema_name, referenced_entity_name, referenced_minor_name;

-- Check if Column1 is not NULL, zero-length string, spaces, or integer 0
SELECT CASE WHEN Column1 <> '' THEN 1 ELSE 0 END;

-- The following are true
-- '0'
-- 1

-- The following are false
-- NULL
-- ''
-- ' '
-- 0

-- Print all foreign keys pointing to a table
SELECT DISTINCT
  fk.name FK,
  tc1.TABLE_SCHEMA AS SchemaFrom,
  OBJECT_NAME(fk.parent_object_id) TableFrom,
  COL_NAME(fkc.parent_object_id, fkc.parent_column_id) ColFrom,
  tc2.TABLE_SCHEMA AS SchemaTo,
  OBJECT_NAME(fkc.referenced_object_id) TableTo,
  c.name ColTo
FROM sys.foreign_keys fk
  JOIN sys.foreign_key_columns fkc ON fkc.constraint_object_id = fk.OBJECT_ID
  JOIN sys.tables t ON t.OBJECT_ID = fkc.referenced_object_id
  JOIN sys.columns c ON c.OBJECT_ID = fkc.referenced_object_id AND c.column_id = fkc.referenced_column_id
  JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc1 ON tc1.TABLE_NAME = OBJECT_NAME(fk.parent_object_id)
  JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc2 ON tc2.TABLE_NAME = t.name
WHERE OBJECT_NAME(fk.referenced_object_id) = 'Table1';

-- Print the last access time and the last update time of a table since the SQL Server service started
SELECT (SELECT MAX(Column1) FROM (VALUES(MAX(last_user_lookup)), (MAX(last_user_seek)), (MAX(last_user_scan))) T(Column1)), MAX(last_user_update)
FROM sys.dm_db_index_usage_stats
WHERE database_id = DB_ID() AND OBJECT_NAME(object_id) = 'Table1';

-- Print the last execution times of procedures
SELECT DB_NAME(database_id), OBJECT_NAME(object_id), last_execution_time
FROM sys.dm_exec_procedure_stats
WHERE database_id = DB_ID()
ORDER BY last_execution_time DESC;

-- Print the last execution times of functions
SELECT DB_NAME(database_id), OBJECT_NAME(object_id), last_execution_time
FROM sys.dm_exec_function_stats
WHERE database_id = DB_ID()
ORDER BY last_execution_time DESC;

-- Compare two tables
(SELECT 1 AS TableName, * FROM Table1 EXCEPT SELECT 1 AS TableName, * FROM Table2)
UNION ALL
(SELECT 2 AS TableName, * FROM Table2 EXCEPT SELECT 2 AS TableName, * FROM Table1);

-- Subtract numbers between tables
SELECT T.Name, ISNULL(Table1.Price, 0) - ISNULL(Table2.Price, 0)
FROM (SELECT Name FROM Table1 UNION SELECT Name FROM Table2) T
LEFT JOIN Table1 ON T.Name = Table1.Name
LEFT JOIN Table2 ON T.Name = Table2.Name;
