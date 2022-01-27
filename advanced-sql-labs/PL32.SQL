DECLARE
t_dept_no    STAFF.DEPT%type := &p_dept_no;
e_dept_error  EXCEPTION;
/*  -2292 is ORACLE error number for integrity constraint violated */
   PRAGMA EXCEPTION_INIT  (e_dept_error, -2292);
BEGIN
delete from ORG
where  deptNUMB = t_dept_no;
commit work;
EXCEPTION
  WHEN e_dept_error then
    rollback work;
    insert into exception_table(message)
    values('Referential integrity constraint violated.');
  WHEN OTHERS THEN
    rollback work;
    insert into exception_table(message)
    values('Other error occurred.');
commit work;
END;
/
