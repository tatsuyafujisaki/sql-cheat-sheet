-- Use a sequence between two tables

DROP TABLE IF EXISTS Table1;
DROP TABLE IF EXISTS Table2;
DROP SEQUENCE IF EXISTS Sequence1;

CREATE SEQUENCE Sequence1 START WITH 0;

CREATE TABLE Table1
(
  Id int DEFAULT NEXT VALUE FOR Sequence1,
  Column1 nvarchar(max)
);

CREATE TABLE Table2
(
  Id int DEFAULT NEXT VALUE FOR Sequence1,
  Column1 nvarchar(max)
);

INSERT INTO Table1 (Column1) VALUES('Rooster');
INSERT INTO Table2 (Column1) VALUES('Cat');
INSERT INTO Table1 (Column1) VALUES('Dog');
INSERT INTO Table2 (Column1) VALUES('Donkey');

SELECT * FROM Table1
UNION ALL
SELECT * FROM Table2
ORDER BY Id;
