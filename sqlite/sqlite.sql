-- Show help
.help

-- Quit
.quit

-- print version
SELECT sqlite_version();

-- print tables information
SELECT * FROM sqlite_master;

-- backup & restore database
.backup db1.sqlite3
.restore db1.sqlite3

-- print database content
.dump

-- dump table
.output table1.dmp
.dump table1
.output stdout

-- Open a database or create it if it does not exist.
.open database1.db

-- print databases
.databases

-- print tables
.tables

-- Create a table
CREATE TABLE pets (
    _id INTEGER PRIMARY KEY AUTO INCREMENT,
    name TEXT NOT NULL,
    age INTEGER NOT NULL DEFAULT 0
);

-- Print a table schema in one line
.schema table1

-- Print a table schema
PRAGMA TABLE_INFO(table1);

-- Drop a table
DROP TABLE table1;

-- print table indices
.indices table1

-- run sql
.read sql1.sql

-- import csv
.import table1.csv table1

-- export csv
.mode csv
.output table1.csv
SELECT * FROM table1;
.output stdout

-- attach db2 to current db
ATTACH DATABASE db2 AS db2

-- specify db if there is a table of the same name in both current db and db2
SELECT * FROM db2.table2

-- detach db
DETACH DATABASE db2

-- create temporary table
CREATE TEMP TABLE temp1(column1, column2, column3);

-- functions
SELECT datetime('now', 'localtime');
SELECT datetime(CURRENT_DATE, 'localtime');
SELECT datetime(CURRENT_TIME, 'localtime');
SELECT datetime(CURRENT_TIMESTAMP, 'localtime');

-- get yyyymmdd
SELECT strftime('%Y%m%d', CURRENT_DATE);
