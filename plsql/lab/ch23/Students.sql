CREATE TABLE students
(student_id    NUMBER,
 Operation     CHAR(1),
 subject_id    NUMBER,
 time          DATE, 
 CONSTRAINT students_pk PRIMARY KEY (student_id,operation, time)
);
INSERT INTO students VALUES (15420,'R',55,'08-AUG-15');
INSERT INTO students VALUES (15420,'R',62,'09-AUG-15');
INSERT INTO students VALUES (22111,'D',55,'10-AUG-15');
INSERT INTO students VALUES (15444,'D',55,'11-AUG-15');
INSERT INTO students VALUES (15420,'D',62,'12-AUG-15');
INSERT INTO students VALUES (11105,'W',55,'13-AUG-15');
INSERT INTO students VALUES (22111,'D',55,'14-AUG-15');
INSERT INTO students VALUES (15444,'R',62,'15-AUG-15');
INSERT INTO students VALUES (15420,'R',62,'16-AUG-15');
INSERT INTO students VALUES (15420,'W',62,'17-AUG-15');
INSERT INTO students VALUES (22111,'R',55,'18-AUG-15');
INSERT INTO students VALUES (15444,'R',55,'19-AUG-15');
INSERT INTO students VALUES (11105,'D',55,'20-AUG-15');
INSERT INTO students VALUES (15420,'W',62,'21-AUG-15');
INSERT INTO students VALUES (15444,'W',55,'22-AUG-15');
INSERT INTO students VALUES (22111,'W',62,'23-AUG-15');
INSERT INTO students VALUES (11105,'R',62,'08-AUG-15');
COMMIT;

