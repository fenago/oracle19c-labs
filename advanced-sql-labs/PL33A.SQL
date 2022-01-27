DECLARE
t_dept_no    STAFF.DEPT%type := &p_dept_no;
e_dept_error  EXCEPTION;
COUNTR        NUMBER(5) :=0;
BEGIN
SELECT COUNT(*) INTO COUNTR FROM STAFF
where  dept = t_dept_no;
IF COUNTR > 0 THEN
    raise e_dept_error;
else
DELETE FROM ORG
WHERE DEPTNUMB = T_DEPT_NO;
endif;
END;
/
