-- The value of an inserted element can be parameterized.
-- The name of an inserted element CANNOT be parameterized.
-- The insertion place CANNOT be parameterized.
CREATE PROCEDURE DeleteInsertXml
  @row_specifier nvarchar(max)
  @xml_value_to_insert nvarchar(max)
AS
BEGIN
  DECLARE @x xml = (SELECT Xml1 FROM Table1 WHERE Column1 = @row_specifier)

  SET @x.modify('delete /Foo/Bar')
  SET @x.modify('insert <Bar>{sql:variable("@xml_value_to_insert")}</Bar> into (/Foo)[1]')

  UPDATE Table1 SET Xml1 = @x WHERE Column1 = @row_specifier
END