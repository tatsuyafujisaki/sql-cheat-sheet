.bail ON
.headers ON
.separator ,
.mode column
PRAGMA page_size = 8192;
VACUUM;

DROP TABLE IF EXISTS table1;

CREATE TABLE table1 (
  _id INTEGER PRIMARY KEY AUTO INCREMENT,
  name TEXT NOT NULL,
  age INTEGER CHECK(0 <= age),
  created_at INTEGER DEFAULT CURRENT_TIMESTAMP
);

BEGIN EXCLUSIVE;

INSERT INTO table1(name, age, pref) VALUES('Taro', 27, 'Yamanashi');
INSERT INTO table1(name, age, pref) VALUES('Jiro', 22, 'Gifu');
INSERT INTO table1(name, age, pref) VALUES('Saburo', 24, 'Shimane');

REPLACE INTO table1(id, name, age, pref) VALUES(3, 'Saburo', 24, 'Tokyo');

SELECT * FROM table1;
SELECT * FROM table1 WHERE name LIKE '%abu%';

CREATE INDEX index1 ON table1(name);
EXPLAIN QUERY PLAN SELECT * FROM table1 WHERE name = 'Saburo';
EXPLAIN QUERY PLAN SELECT * FROM table1 WHERE name LIKE '%abu%';

COMMIT;
