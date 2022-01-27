DECLARE
t_dept_no    STAFF.DEPT%type := &p_dept_no;
temp_dept    staff.dept%TYPE;
v_error_code    number;
v_error_message  varchar(255);
e_dept_error  EXCEPTION;
COUNTR        NUMBER(5) :=0;
BEGIN
SELECT COUNT(*) INTO COUNTR FROM STAFF
where  dept = t_dept_no;
IF COUNTR > 0 THEN
    raise e_dept_error;
END IF;
SELECT DEPT INTO TEMP_DEPT FROM STAFF WHERE DEPT = T_DEPT_NO;
DELETE FROM ORG
WHERE DEPTNUMB = T_DEPT_NO;
EXCEPTION
WHEN NO_DATA_FOUND THEN
    ROLLBACK WORK;
    INSERT INTO EXCEPTION_TABLE(MESSAGE)
    VALUES(TO_CHAR(T_DEPT_NO)||'INVALID DEPTARTMENT NO');
    COMMIT WORK;
  WHEN e_dept_error then
    rollback work;
    insert into exception_table(message)
    values('There are still employees with that department no in staff.');
  WHEN OTHERS THEN
    rollback work;
    v_error_code := SQLCODE;
    v_error_message := SQLERRM;
    insert into exception_table(message)
    values(to_char(v_error_code)||':'||v_error_message);
commit work;
END;
/
