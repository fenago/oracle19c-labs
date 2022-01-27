declare
emp_id  staff.id%TYPE := &p_emp_id;
BEGIN
DELETE FROM STAFF WHERE id = emp_id;
COMMIT WORK;
END;
/
