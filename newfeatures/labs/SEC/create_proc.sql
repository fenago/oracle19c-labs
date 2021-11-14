SET ECHO ON 
CREATE OR REPLACE PACKAGE hr.emp_admin AUTHID DEFINER AS
  TYPE EmpRecTyp IS RECORD (emp_id NUMBER, sal NUMBER);
  CURSOR desc_salary RETURN EmpRecTyp;
  invalid_salary EXCEPTION;

  PROCEDURE raise_salary (emp_id NUMBER, amount NUMBER);
END emp_admin;
/

CREATE OR REPLACE PACKAGE BODY hr.emp_admin AS
  number_hired  NUMBER;  

  CURSOR desc_salary RETURN EmpRecTyp IS
    SELECT employee_id, salary
    FROM employees
    ORDER BY salary DESC;

	FUNCTION sal_ok (
    jobid VARCHAR2,
    sal NUMBER
  ) RETURN BOOLEAN
  IS
    min_sal NUMBER;
    max_sal NUMBER;
  BEGIN
    SELECT MIN(salary), MAX(salary)
    INTO min_sal, max_sal
    FROM employees
    WHERE job_id = jobid;

    RETURN (sal >= min_sal) AND (sal <= max_sal);
  END sal_ok;
  
  PROCEDURE raise_salary (
    emp_id NUMBER,
    amount NUMBER
  )
  IS
    sal NUMBER(8,2);
    jobid VARCHAR2(10);
  BEGIN
    SELECT job_id, salary INTO jobid, sal
    FROM employees
    WHERE employee_id = emp_id;

    IF sal_ok(jobid, sal + amount) THEN  -- Invoke private function
      UPDATE employees
      SET salary = salary + amount
      WHERE employee_id = emp_id;
	  COMMIT;
    ELSE
      RAISE invalid_salary;
    END IF;
  EXCEPTION
    WHEN invalid_salary THEN
      DBMS_OUTPUT.PUT_LINE ('The salary is out of the specified range.');
  END raise_salary;

END emp_admin;
/
EXIT