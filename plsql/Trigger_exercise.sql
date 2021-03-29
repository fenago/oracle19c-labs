CREATE OR REPLACE PACKAGE BODY dfas_get_set
		IS	
	PROCEDURE set_record(p_emp_rec IN emp%ROWTYPE)
	IS
	PRAGMA AUTONOMOUS_TRANSACTION;
	BEGIN
		INSERT INTO employees
	VALUES(p_emp_rec.emp_name,p_emp_rec.emp_no; p_emp_rec.salary,p_emp_rec.manager);
	COMMIT;
	END set_record;
	FUNCTION get_record(p_emp_no IN NUMBER)
	RETURN emp%ROWTYPE
	IS
	l_emp_rec emp%ROWTYPE;
	BEGIN
	SELECT * INTO l_emp_rec FROM employees where emp_no=p_emp_no
	RETURN l_emp_rec;
	END get_record;
