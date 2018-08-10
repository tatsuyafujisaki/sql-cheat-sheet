DROP TABLE IF EXISTS Table1

CREATE TABLE Table1
(
  Id int IDENTITY(1, 1),
  Column1 nvarchar(max)
);

INSERT INTO Table1 VALUES('Foo');
INSERT INTO Table1 VALUES('Bar');
DELETE Table1 WHERE Column1 = 'Bar';

-- Print the last IDENTITY
-- Result: 2
SELECT IDENT_CURRENT('Table1');

-- Set IDENTITY to the highest to avoid a gap between IDs after some records are added and then deleted.
DECLARE @MaxID int = (SELECT MAX(Id) FROM Table1);
DBCC CHECKIDENT('Table1', RESEED, @MaxID);

-- Print the last IDENTITY
-- Result: 1
SELECT IDENT_CURRENT('Table1');

INSERT INTO Table1 VALUES('Bar');

SELECT * FROM Table1;
