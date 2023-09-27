CREATE DATABASE assignment;
USE assignment;
-- create a table student with under mentained structuer

CREATE TABLE STUDENT(
StdID int primary key,
StdName VARCHAR(30) NOT NULL,
SEX VARCHAR(8) CHECK (SEX IN('Male','Female')),
Percentage int,
SClass int,
Sec CHAR,
Stream VARCHAR(10) CHECK (Stream IN ('Science','Commerce')),
DOB DATE NOT NULL

)
INSERT INTO STUDENT (StdID,StdName,SEX,Percentage,SClass,Sec,Stream,DOB)
VALUES (1,'ARUN','Female',88,5,'A','Science','2000-05-12'),
(2,'NURA' ,'Male',89,6,'B','Science','2000-05-18');
SELECT *
FROM STUDENT;
-- alter table with new field as teacher_id
ALTER TABLE STUDENT
ADD teacher_id INT;
-- create a table with teachers details
CREATE TABLE teacherdetails(
Name VARCHAR(100),
email VARCHAR(100),
subject VARCHAR(100),
Class VARCHAR(8))
ALTER TABLE teacherdetails
ADD tID INT primary key;
SELECT *
FROM teacherdetails;
-- insert into teachers table and apply insert into student table with teacher's ID as foreign key
ALTER TABLE STUDENT
ADD FOREIGN KEY (teacher_id) REFERENCES teacherdetails(tID);
-- insert the deail in teacherdetails
INSERT INTO teacherdetails(tID,Name,email,subject,Class)
VALUES (5,'anjali','anjali@gmail.com','maths','6'),
(8,'Ram','ram@gmail.com','science','7'),
(10,'aaru','aaru@gmail.com','science','9');
-- inner join in both tables
SELECT *
FROM STUDENT s
JOIN teacherdetails t
ON s.teacher_id = t.tID;
-- find distinct name from table
SELECT DISTINCT StdName
FROM STUDENT;
-- no of students that are male
select SEX, COUNT(*)
FROM STUDENT
GROUP BY SEX
HAVING SEX='Male';
-- the number of students having sex as male and stream as science using group by having
SELECT SEX,Stream,COUNT(*)
FROM STUDENT
GROUP BY SEX,Stream
HAVING SEX='Male' AND Stream='Science';
-- Read students having their birth year as 2020.
SELECT *
FROM STUDENT
WHERE year(DOB)='2020';
-- create a table  with features available at the school
CREATE TABLE Features(
feature_id int primary key,
feature_type varchar(100) not null
);
INSERT INTO Features (feature_id,feature_type)
VALUES (5,'swimming'),
(8,'cricket');
-- create a table to keep many to many relationships between student and feature
CREATE TABLE Student_features(
feature_id INT,
student_id INT,
foreign key (feature_id) references Features(feature_id),
foreign key (student_id) references STUDENT(StdID)
);
INSERT INTO Student_features (feature_id,student_id)
VALUES (5,1),
(8,2);
-- Fetch all the students having swimming as a choice.
SELECT s.StdName
FROM STUDENT s
JOIN Student_features sf ON s.StdID = sf.student_id
JOIN Features f ON sf.feature_id = f.feature_id
WHERE f.feature_type = 'swimming';
-- find teachers whose students are into cricket.
SELECT t.Name
FROM teacherdetails t
JOIN STUDENT s ON s.teacher_id =t.tID
JOIN Student_features sf ON s.StdID = sf.student_id
JOIN Features f ON sf.feature_id = f.feature_id
WHERE f.feature_type = 'cricket';
-- Write a view having columns as students, sex, percentage, class, section, teach,activity, stream.
CREATE VIEW student_view AS
SELECT s.StdName AS students,
   s.SEX AS sex,
   s.Percentage AS percentage,
   s.SClass AS class,
   s.Sec AS section,
   t.Name AS teach,
   f.feature_type AS activity,
   s.Stream AS stream
   FROM STUDENT s
   JOIN teacherdetails t
   ON s.teacher_id = t.tID
   JOIN Student_features sf
   ON sf.student_id= s.StdID
   JOIN Features f
   ON f.feature_id = sf.feature_id;
-- Find a student having 3rd height percentage.
SELECT *
FROM STUDENT
ORDER BY Percentage DESC
LIMIT 1 OFFSET 2;
-- Give me and example of Union query in this used case
SELECT * FROM STUDENT
UNION 
SELECT * FROM STUDENT ORDER BY StdID;
   
   
   