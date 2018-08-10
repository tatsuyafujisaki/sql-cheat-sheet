DROP TABLE IF EXISTS Table2;
DROP TABLE IF EXISTS Table1;

CREATE TABLE Table1 (
  Column1 nvarchar(100) PRIMARY KEY
);

CREATE TABLE Table2 (
  Column1 int PRIMARY KEY,
  Column2 nvarchar(100) NOT NULL FOREIGN KEY REFERENCES Table1(Column1) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Table1 VALUES ('Delete me');
INSERT INTO Table1 VALUES ('Rename me');
INSERT INTO Table2 VALUES (1, 'Delete me');
INSERT INTO Table2 VALUES (2, 'Rename me');

SELECT * FROM Table1;
SELECT * FROM Table2;

DELETE FROM Table1 WHERE Column1 = 'Delete me';
UPDATE Table1 SET Column1 = 'I have been renamed' WHERE Column1 = 'Rename me';

SELECT * FROM Table1;
SELECT * FROM Table2;