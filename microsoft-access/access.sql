-- Use Col2 if Col1 is null or empty
SELECT IIf(IsNull(Col1) Or Trim(Col1) = '', Col2, Col1) FROM Table1