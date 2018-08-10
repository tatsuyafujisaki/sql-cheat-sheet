-- Create user (user1 can access db remotely. user2 cannot.)
GRANT ALL PRIVILEGES ON *.* TO 'user1'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'user2'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;