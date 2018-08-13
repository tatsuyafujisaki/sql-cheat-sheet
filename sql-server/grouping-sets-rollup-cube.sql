-- Example of GROUPING SETS and CUBE

DROP TABLE IF EXISTS Sales;

CREATE TABLE Sales
(
  ID int IDENTITY(1, 1) PRIMARY KEY,
  SalespersonID int NOT NULL,
  CustomerID int NOT NULL,
  Amount int NOT NULL
);

INSERT INTO Sales VALUES
(1, 1, 10),
(1, 2, 20),
(2, 1, 30),
(2, 2, 40);

SELECT SalespersonID, CustomerID, SUM(Amount) TotalAmount
FROM Sales
GROUP BY
GROUPING SETS(SalespersonID, CustomerID, ());

SELECT SalespersonID, CustomerID, SUM(Amount) TotalAmount
FROM Sales
GROUP BY
CUBE(SalespersonID, CustomerID);

-- Example of ROLLUP

DROP TABLE IF EXISTS Area;

CREATE TABLE Area
(
  ID int IDENTITY(1, 1) PRIMARY KEY,
  Country nvarchar(max) NOT NULL,
  City nvarchar(max) NOT NULL,
  Population int NOT NULL
);

INSERT INTO Area VALUES
('Japan', 'Tokyo', 10),
('Japan', 'Osaka', 20),
('USA', 'New York', 30),
('USA', 'San Francisco', 40);

SELECT Country, City, SUM(Population)
FROM Area
GROUP BY ROLLUP(Country, City);