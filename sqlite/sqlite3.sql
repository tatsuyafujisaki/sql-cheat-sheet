sqlite3 newdb1
sqlite3 db1 .dump > db1.sqlite3
sqlite3 db1 < sql1.sql
sqlite3 db1 "CREATE TABLE table1(id, name, home)"
sqlite3 :memory