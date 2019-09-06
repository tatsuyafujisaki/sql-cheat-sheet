/*
 * Read-only
 */

-- Print version
SELECT sqlite_version();

-- Print information about tables
SELECT * FROM sqlite_master;

-- Print a table schema
PRAGMA TABLE_INFO(table1);

-- Get today in yyyymmdd
SELECT strftime('%Y%m%d', CURRENT_DATE);

-- Specify a database if multiple databases have the same table name.
SELECT * FROM database1.table1

-- Use GLOB as an expression in a SELECT statement
SELECT column1 GLOB '*[a-zA-Z]*' FROM table1

/*
 * Not read-only
 */

-- Compact the database file
VACUUM;

-- Add or remove another database file to the current database connection
ATTACH DATABASE another_database AS another_database
DETACH DATABASE another_database

-- Drop a datable if it exists
DROP TABLE IF EXISTS table1;

-- Create a table that is dropped after the current database connection
CREATE TEMP TABLE temp1(column1, column2);

-- Functions
SELECT datetime('now', 'localtime');
SELECT datetime(CURRENT_DATE, 'localtime');
SELECT datetime(CURRENT_TIME, 'localtime');
SELECT datetime(CURRENT_TIMESTAMP, 'localtime');

CREATE TABLE IF NOT EXISTS table1 (
  _id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  age INTEGER NOT NULL CHECK(0 <= age),
  created_at INTEGER NOT NULL DEFAULT CURRENT_TIMESTAMP
);

BEGIN EXCLUSIVE;

INSERT INTO table1(name, age) VALUES('Bacon', 30);
INSERT INTO table1(name, age) VALUES('Lettuce', 20);
INSERT INTO table1(name, age) VALUES('Tomato', 10);

REPLACE INTO table1(name, age) VALUES('Tomato', 25);

SELECT * FROM table1 WHERE name LIKE '%tom%';

CREATE INDEX index1 ON table1(name);

COMMIT;
