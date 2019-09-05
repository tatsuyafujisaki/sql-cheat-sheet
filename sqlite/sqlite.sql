-- Print version
SELECT sqlite_version();

-- Print tables information
SELECT * FROM sqlite_master;

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
