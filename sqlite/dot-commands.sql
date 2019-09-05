-- Show help
.help

-- Quit
.quit

-- Show settings
.show

-- Open a database or create it if it does not exist.
.open database1.db

-- Print a database content
.dump

-- Print databases
.databases

-- Print tables
.tables

-- Print CREATE TABLE for tables
.schema

-- Print CREATE TABLE for a table
.schema table1

-- Print indices of a table
.indices table1

-- Run an SQL
.read sql1.sql

-- Import a CSV file as a table
.import table1.csv table1

-- Export a table as a CSV file
.mode csv
.output table1.csv
SELECT * FROM table1;
.output stdout

-- Dump a table
.output table1.dmp
.dump table1
.output stdout

-- Back up and restore a database
.backup database1.sqlite3
.restore database1.sqlite3

-- Display header in the result of SELECT statement
.headers ON

-- Align columns in the result of SELECT statement
.mode column
