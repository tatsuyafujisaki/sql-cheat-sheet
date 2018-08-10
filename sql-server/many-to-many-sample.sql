DROP TABLE IF EXISTS Enrolment;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Student;

CREATE TABLE Student
(
  ID int IDENTITY(1, 1) PRIMARY KEY,
  Name nvarchar(max) NOT NULL,
);

CREATE TABLE Course
(
  ID int IDENTITY(1, 1) PRIMARY KEY,
  Name nvarchar(max) NOT NULL
);

CREATE TABLE Enrolment
(
  StudentID int REFERENCES Student(ID) ON UPDATE CASCADE ON DELETE CASCADE,
  CourseID int REFERENCES Course(ID) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY(StudentID, CourseID)
);

INSERT INTO Student VALUES
('Tom'),
('Jerry');

INSERT INTO Course VALUES
('Math'),
('English');

INSERT INTO Enrolment VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2);

SELECT * FROM Student;
SELECT * FROM Course;
SELECT * FROM Enrolment;
