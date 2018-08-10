DROP TABLE IF EXISTS Table1
CREATE TABLE Table1
(
  Xml1 xml
)
GO

INSERT INTO Table1
  (Xml1)
VALUES
  (CAST('<Food><Bacon/><Lettuce>100</Lettuce><Tomato/></Food>' AS xml))

-- Result: 1
-- SELECT Xml1.exist('/Food/Lettuce') FROM Table1

-- Result: 0
-- SELECT Xml1.exist('/Food/Cabbage') FROM Table1

-- Result: Error because value(...) requires a singleton
-- SELECT Xml1.value('/Food/Lettuce/text()', 'nvarchar(max)') FROM Table1

-- Result: 100 as string
-- SELECT Xml1.value('(/Food/Lettuce)[1]', 'nvarchar(max)') FROM Table1

-- Result: 100 as xml
-- SELECT Xml1.query('/Food/Lettuce/text()') FROM Table1

-- Result: <Lettuce>100</Lettuce> as xml
-- SELECT Xml1.query('(/Food/Lettuce)[1]') FROM Table1

-- Example 1 (Query an xml column)

UPDATE Table1 SET Xml1.modify('replace value of (/Food/Lettuce/text())[1] with 123')

UPDATE Table1 SET Xml1.modify('delete /Food/Lettuce')

-- Insert Lettuce as the first child of Food
UPDATE Table1 SET Xml1.modify('insert <Lettuce>I am even before Bacon.</Lettuce> as first into (/Food)[1]')

-- Insert Lettuce after Bacon
UPDATE Table1 SET Xml1.modify('insert <Lettuce>I am after Bacon.</Lettuce> after (/Food/Bacon)[1]')

-- Insert Lettuce before Tomato
UPDATE Table1 SET Xml1.modify('insert <Lettuce>I am before Tomato.</Lettuce> before (/Food/Tomato)[1]')

-- Insert Lettuce as the last child of Food
UPDATE Table1 SET Xml1.modify('insert <Lettuce>I am even after Tomato.</Lettuce> into (/Food)[1]')

SELECT Xml1 FROM Table1

-- Example 2 (Query an xml variable)

DECLARE @x xml = '<Food><Bacon/><Lettuce>100</Lettuce><Tomato/></Food>'

SET @x.modify('replace value of (/Food/Lettuce/text())[1] with 123')

SET @x.modify('delete /Food/Lettuce')

-- Insert Lettuce as the first child of Food
SET @x.modify('insert <Lettuce>I am even before Bacon.</Lettuce> as first into (/Food)[1]')

-- Insert Lettuce after Bacon
SET @x.modify('insert <Lettuce>I am after Bacon.</Lettuce> after (/Food/Bacon)[1]')

-- Insert Lettuce before Tomato
SET @x.modify('insert <Lettuce>I am before Tomato.</Lettuce> before (/Food/Tomato)[1]')

-- Insert Lettuce as the last child of Food
SET @x.modify('insert <Lettuce>I am even after Tomato.</Lettuce> into (/Food)[1]')

UPDATE Table1 SET Xml1 = @x