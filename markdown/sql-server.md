# Best practices
* Use ANSI-compliant syntax.
  * [BNF grammar for SQL:2003](https://ronsavage.github.io/SQL)
  * Use `<>` rather than `!=`
  
# Note
* `CROSS JOIN`
  * returns a Cartesian product that includes every combination of the selected columns from both tables.
  * is useful to generate test data.
* Correlated subqueries reference objects in the outer query.
* `APPLY`
  * Trying to `JOIN` or `OUTER JOIN` a table-valued function causes a syntax error because a column cannot be passed to a function as a parameter.
  * Use `CROSS APPLY` when you want to `JOIN` a table and a table-valued function.
  * Use `OUTER APPLY` when you want to `LEFT JOIN` a table and a table-valued function.
  * [Using APPLY](https://docs.microsoft.com/en-us/previous-versions/sql/sql-server-2008-r2/ms175156(v=sql.105))


# Serial date
Serial date|SQL Server datetime|Excel 1900 date system|Excel 1904 date system
---|---|---|---
0|1900-01-01|1900-01-00|1904-01-01
1|1900-01-02|1900-01-01|1904-01-02
58|1900-02-28|1900-02-27|1904-02-28
59|1900-03-01|1900-02-28|1904-02-29
60|1900-03-02|1900-02-29 (non-existing)|1904-03-01
61|1900-03-03|1900-03-01|1904-03-02

## How to convert int to datetime
```sql
SELECT CAST(0 AS datetime)
```

# How to import WideWorldImporters or AdventureWorks
1. Download the following to `C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup`.
   1. [WideWorldImporters-Full.bak](https://github.com/Microsoft/sql-server-samples/tree/master/samples/databases/wide-world-importers)
   2. [AdventureWorks2017.bak](https://github.com/Microsoft/sql-server-samples/tree/master/samples/databases/adventure-works)
2. Start SQL Server Management Studio.
3. Connect to `.\SQLEXPRESSS`.
4. Right-click on `Databases` > `Restore Database` > `Devide` checkbox > `...` button > `Add` button > Navigate to the backup folder
5. Double-click on either `WideWorldImporters-Full.bak` or `AdventureWorks2017.bak` because you can import one database at a time.
