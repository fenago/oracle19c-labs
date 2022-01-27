DECLARE
t_dept_no    STAFF.DEPT%type := 20;
e_job_error  EXCEPTION;
empjob       staff.job%type := '&NEWJOB';
TEMPJOB      STAFF.JOB%TYPE;
COUNTR        NUMBER(5) :=0;
newid         staff.id%type;
BEGIN
SELECT DISTINCT JOB INTO TEMPJOB
FROM STAFF
WHERE JOB = UPPER(EMPJOB); 
/* IF UPPER(empjob) = 'CEO  ' THEN
    raise e_job_error;   
END IF; */
SELECT MAX(ID) + 10 INTO NEWID FROM STAFF;
insert into staff (id,name,DEPT,YEARS,JOB,SALARY,COMM)
values  (newid,'RICHARD',10,14,'PROG',50000,5000);
EXCEPTION
  WHEN e_job_error then
    rollback work;
    insert into exception_table(message)
    values('This is an invalid job in staff. CEO is not allowed');
  WHEN NO_DATA_FOUND THEN
     INSERT INTO EXCEPTION_TABLE(MESSAGE)
     VALUES('COULD NOT FIND ANY DATA - TRY AGAIN');
  WHEN OTHERS THEN
    rollback work;
    insert into exception_table(message)
    values('Other error occurred.');
commit work;
END;
/
