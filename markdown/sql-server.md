# Best practices
* Use ANSI-compliant syntax
  * [BNF grammar for SQL:2003](https://ronsavage.github.io/SQL)
  * Use `<>` rather than `!=`

# How to import WideWorldImporters or AdventureWorks
1. Download the following `C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup`
   1. [WideWorldImporters-Full.bak](https://github.com/Microsoft/sql-server-samples/tree/master/samples/databases/wide-world-importers)
   2. [AdventureWorks2017.bak](https://github.com/Microsoft/sql-server-samples/tree/master/samples/databases/adventure-works)
2. Start SQL Server Management Studio
3. Connect to `.\SQLEXPRESSS`
4. Right-click on `Databases` > `Restore Database` > `Devide` checkbox > `...` button > `Add` button > Navigate to `C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup`
5. Double-click on either `WideWorldImporters-Full.bak` or `AdventureWorks2017.bak` because you can import one database at a time
