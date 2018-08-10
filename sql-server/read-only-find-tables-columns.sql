-- Print tables in the current database by descending order of size
DECLARE @Table TABLE
(
  name nvarchar(128),
  row char(20),
  reserved varchar(18),
  data varchar(18),
  index_size varchar(18),
  unused varchar(18)
);

INSERT INTO @Table
EXECUTE sp_MSforeachtable 'sp_spaceused ''?''';

;WITH T AS
(
  SELECT name,
         row,
         CAST(REPLACE(reserved, ' KB', '') AS int) reserved,
         CAST(REPLACE(data, ' KB', '') AS int) data,
         CAST(REPLACE(index_size, ' KB', '') AS int) index_size,
         CAST(REPLACE(unused, ' KB', '') AS int) unused
  FROM @Table
)

SELECT * FROM T ORDER BY reserved DESC;

-- Print tables and views, across databases, which have a given string in table/view name or column name
DECLARE @Table TABLE
(
  DatabaseName nvarchar(max) NOT NULL,
  TableOrView nvarchar(max) NOT NULL,
  SchemaName nvarchar(max) NOT NULL, -- There may be duplicate table/view names with different schemas
  TableOrViewName nvarchar(max) NOT NULL,
  ColumnName nvarchar(max) NOT NULL
);

INSERT INTO @Table
EXECUTE sp_MSforeachdb '
IF ''?'' NOT IN (''InaccessibleDatabase1'', ''InaccessibleDatabase2'') -- Avoid permission errors
BEGIN
  USE ?;
  
  ;WITH T(DatabaseName, TableOrView, SchemaName, TableOrViewName, ColumnName) AS
  (
    SELECT DB_NAME(), ''Table'', SCHEMA_NAME(schema_id), t.name, c.name
    FROM sys.columns c
    JOIN sys.tables t
    ON c.object_id = t.object_id

    UNION ALL

    SELECT DB_NAME(), ''View'', SCHEMA_NAME(schema_id), v.name, c.name
    FROM sys.columns c
    JOIN sys.views v
    ON c.object_id = v.object_id
  )
  SELECT * FROM T
  WHERE TableOrViewName LIKE ''%Foo'' OR ColumnName LIKE ''%Foo%'';
END;
';

SELECT * FROM @Table;

-- Print procedures and functions, across databases, which contain a given string in procedure/function name or definition
DECLARE @Table TABLE
(
  DatabaseName nvarchar(max) NOT NULL,
  ProcedureOrFunction nvarchar(max) NOT NULL,
  SchemaName nvarchar(max) NOT NULL, -- There may be duplicate procedure/function names with different schemas
  ProcedureOrFunctionName nvarchar(max) NOT NULL,
  ProcedureOrFunctionDefinition nvarchar(max) NOT NULL
);

INSERT INTO @Table
EXECUTE sp_MSforeachdb '
IF ''?'' NOT IN (''InaccessibleDatabase1'', ''InaccessibleDatabase2'') -- Avoid permission errors
BEGIN
  USE ?;
  
  ;WITH T(DatabaseName, ProcedureOrFunction, SchemaName, ProcedureOrFunctionName, ProcedureOrFunctionDefinition) AS
  (
    SELECT DB_NAME(), ''Procedure'', SCHEMA_NAME(schema_id), OBJECT_NAME(object_id), OBJECT_DEFINITION(object_id)
    FROM sys.procedures

    UNION ALL

    SELECT DB_NAME(), ''Function'', OBJECT_SCHEMA_NAME(object_id), name, OBJECT_DEFINITION(object_id)
    FROM sys.objects
    WHERE type IN (''FN'', ''IF'', ''TF'')
  )
  SELECT * FROM T
  WHERE ProcedureOrFunctionName LIKE ''%Foo%'' OR ProcedureOrFunctionDefinition LIKE ''%Foo%'';
END;
';

SELECT * FROM @Table;
