DROP TABLE IF EXISTS Table1;

CREATE TABLE Table1
(
  SalesName nvarchar(max),
  Product nvarchar(max),
  SalePrice int,
  SaleDate date
);

INSERT INTO Table1 (SalesName, Product, SalePrice, SaleDate) VALUES ('Taro', 'Apple', 100, CAST('2020-1-1' AS date));
INSERT INTO Table1 (SalesName, Product, SalePrice, SaleDate) VALUES ('Taro', 'Apple', 100, CAST('2020-1-1' AS date));
INSERT INTO Table1 (SalesName, Product, SalePrice, SaleDate) VALUES ('Taro', 'Orange', 100, CAST('2020-12-31' AS date));
INSERT INTO Table1 (SalesName, Product, SalePrice, SaleDate) VALUES ('Hanako', 'Apple', 100, CAST('2020-1-1' AS date));
INSERT INTO Table1 (SalesName, Product, SalePrice, SaleDate) VALUES ('Hanako', 'Orange', 100, CAST('2020-12-31' AS date));

-- Note
-- Apple and Orange are virtual columns.
-- SalePrice is the value of those virtual columns.
-- Non-pivot columns (all columns except SalePrice and Product) remain avaialble as columns.
-- Rows are aggregated if all values of non-pivot columns are the same.
SELECT * FROM Table1 PIVOT (SUM(SalePrice) FOR Product IN (Apple, Orange)) P;

-- Sum across SalesName and SalesDate.
SELECT * FROM (SELECT SalePrice, Product FROM Table1) S PIVOT (SUM(SalePrice) FOR Product IN (Apple, Orange)) P;
