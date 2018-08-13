DROP TABLE IF EXISTS Table1;

CREATE TABLE Table1
(
  Xml1 xml
);

INSERT INTO Table1 (Xml1)
VALUES (CAST('<People><Person>Tom</Person><Person>Jerry</Person></People>' AS xml));

SELECT Person.query('.')
FROM Table1
CROSS APPLY Xml1.nodes('/People/Person') T(Person);
