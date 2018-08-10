DROP TABLE IF EXISTS Table3;
DROP TABLE IF EXISTS Table2;
DROP TABLE IF EXISTS Table1;

CREATE TABLE Table1
(
  Column1 int PRIMARY KEY
);

CREATE TABLE Table2
(
  Column1 int,
  Column2 int CONSTRAINT UQ_Table2_Column2 UNIQUE,
  Column3 int CONSTRAINT FK_Table2_Table1 REFERENCES Table1(Column1) ON UPDATE CASCADE ON DELETE CASCADE
  CONSTRAINT PK_Table2 PRIMARY KEY (Column1, Column2)
);

CREATE TABLE Table3 -- Meaningless set of columns
(
  Id int IDENTITY(1,1) CONSTRAINT PK_Table3 PRIMARY KEY,
  Age int NOT NULL,
  IndividualNumber nvarchar(12) NOT NULL,
  Ticker nvarchar(5) NOT NULL, -- 1 to 5 alphabets
  BinaryFile varbinary(max) NOT NULL,
  Hostname nvarchar(max) NOT NULL CONSTRAINT DF_Table3_Hostname DEFAULT HOST_NAME(),
  UpdatedBy nvarchar(max) NOT NULL CONSTRAINT DF_Table3_UpdatedBy DEFAULT CURRENT_USER,
  UpdatedAt datetime2 NOT NULL CONSTRAINT DF_Table3_UpdatedAt DEFAULT CURRENT_TIMESTAMP, -- Use CURRENT_TIMESTAMP rather than SYSDATETIME() because datetime2 uses less memory for lower precision
  CONSTRAINT CK_Table3_Age CHECK(0 <= Age),
  CONSTRAINT CK_Table3_IndividualNumber CHECK(IndividualNumber LIKE REPLICATE('[0-9]', 12)),
  CONSTRAINT CK_Table3_Ticker CHECK(0 < LEN(Ticker) AND Ticker NOT LIKE '%[^a-zA-Z]%') -- Note the double negative
);
