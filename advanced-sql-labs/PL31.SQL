DECLARE
t_dept_no    STAFF.DEPT%type := &p_dept_no;
temp_dept    staff.dept%type;
BEGIN
select distinct dept into temp_dept
from staff
where dept = t_dept_no;
delete from staff
where  dept = t_dept_no;
commit work;
EXCEPTION
  WHEN NO_DATA_FOUND then
    rollback work;
    insert into exception_table(message)
    values('Department number is invalid');
    COMMIT;
  WHEN OTHERS THEN
    rollback work;
    insert into exception_table(message)
    values('Other error occurred.');
commit work;
END;
/
