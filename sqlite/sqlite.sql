-- Show help
.help

-- Quit
.quit

-- Show settings
.show

-- Print a database content
.dump

-- Print databases
.databases

-- Print tables
.tables

-- Print a table schema in one line
.schema table1

-- Print indices of a table
.indices table1

-- Run sql
.read sql1.sql

-- Import csv
.import table1.csv table1

-- Export csv
.mode csv
.output table1.csv
SELECT * FROM table1;
.output stdout

-- Backup and restore a database
.backup database1.sqlite3
.restore database1.sqlite3

-- Print version
SELECT sqlite_version();

-- Print tables information
SELECT * FROM sqlite_master;

-- Dump a table
.output table1.dmp
.dump table1
.output stdout

-- Open a database or create it if it does not exist.
.open database1.db

-- Print a table schema
PRAGMA TABLE_INFO(table1);

-- Attach db2 to current db
ATTACH DATABASE database2 AS database2

-- Specify db if there is a table of the same name in both current db and db2
SELECT * FROM database2.table2

-- Detach db
DETACH DATABASE database2

-- Create a temporary table
CREATE TEMP TABLE temp1(column1, column2, column3);

-- Functions
SELECT datetime('now', 'localtime');
SELECT datetime(CURRENT_DATE, 'localtime');
SELECT datetime(CURRENT_TIME, 'localtime');
SELECT datetime(CURRENT_TIMESTAMP, 'localtime');

-- Get yyyymmdd
SELECT strftime('%Y%m%d', CURRENT_DATE);
