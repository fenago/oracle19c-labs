drop package personnel;

CREATE OR REPLACE PACKAGE personnel
IS 
FUNCTION get_fullname (n_emp_id IN NUMBER) RETURN varchar2; 
FUNCTION get_salary (n_emp_id IN NUMBER) RETURN number; 
END;
/

CREATE OR REPLACE PACKAGE BODY personnel AS
  FUNCTION get_fullname(n_emp_id NUMBER) RETURN VARCHAR2 IS
      v_fullname VARCHAR2(46);
  BEGIN
    SELECT first_name || ',' ||  last_name
    INTO v_fullname
    FROM employees
    WHERE employee_id = n_emp_id;
    RETURN v_fullname;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN NULL;
  WHEN TOO_MANY_ROWS THEN
    RETURN NULL;
  END;
  FUNCTION get_salary(n_emp_id NUMBER) RETURN NUMBER IS
    n_salary NUMBER(8,2);
  BEGIN
    SELECT salary
    INTO n_salary
    FROM employees
    WHERE employee_id = n_emp_id;
    RETURN n_salary;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RETURN NULL;
      WHEN TOO_MANY_ROWS THEN
        RETURN NULL;
  END;
END personnel;


select personnel.get_salary(100) from dual;

declare
    v_name varchar2(100);
    v_emp_id number := 100;
begin
  v_name := personnel.get_fullname(v_emp_id);
  dbms_output.put_line(v_name);
  end;