.headers ON

VACUUM;

DROP TABLE IF EXISTS table1;

CREATE TABLE table1 (
  _id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  age INTEGER NOT NULL CHECK(0 <= age),
  created_at INTEGER NOT NULL DEFAULT CURRENT_TIMESTAMP
);

BEGIN EXCLUSIVE;

INSERT INTO table1(name, age) VALUES('Bacon', 30);
INSERT INTO table1(name, age) VALUES('Lettuce', 20);
INSERT INTO table1(name, age) VALUES('Tomato', 10);

REPLACE INTO table1(name, age) VALUES('Tomato', 25);

SELECT * FROM table1 WHERE name LIKE '%tom%';

CREATE INDEX index1 ON table1(name);

COMMIT;
