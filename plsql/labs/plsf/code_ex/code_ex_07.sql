--This is the SQL Script to run the code_examples for Lesson 7

--Uncomment the code below to execute the code on slide 11_sa
/*


DECLARE
TYPE t_rec IS RECORD
  (
  v_first_name employees.first_name%TYPE,
  v_sal NUMBER(8),
  v_hire_date employees.hire_date%TYPE
  );
v_myrec t_rec;
BEGIN
  SELECT first_name, salary, hire_date INTO v_myrec
  FROM employees WHERE employee_id = 100;
  DBMS_OUTPUT.PUT_LINE('First name: ' || v_myrec.v_first_name|| '
Salary: '|| v_myrec.v_sal  ||'
Hire Date: '||v_myrec.v_hire_date);
END;
  

--Uncomment the code below to execute the code on slide 16_sa

/*
SET SERVEROUTPUT ON

DECLARE
type t_rec is record
(v_sal number(8),
v_minsal number(8) default 1000,
v_hire_date employees.hire_date%type,
v_rec1 employees%rowtype);
v_myrec t_rec;
BEGIN
v_myrec.v_sal := v_myrec.v_minsal + 500;
v_myrec.v_hire_date := sysdate;
SELECT * INTO v_myrec.v_rec1
FROM employees WHERE employee_id = 100;
DBMS_OUTPUT.PUT_LINE(v_myrec.v_rec1.last_name ||' '||
v_myrec.v_hire_date ||' '|| v_myrec.v_sal);
END;
/

*/

--Uncomment the code below to execute the code on slide 18_na

/*
SET VERIFY OFF

DROP TABLE retired_emps;

CREATE TABLE retired_emps
   (EMPNO      NUMBER(4),
    ENAME      VARCHAR2(10),
    JOB        VARCHAR2(9),
    MGR        NUMBER(4),
    HIREDATE   DATE,
    LEAVEDATE  DATE,
    SAL        NUMBER(7,2),
    COMM       NUMBER(7,2),
    DEPTNO     NUMBER(2))
/
*/
--Uncomment the code below to execute the code on slide 18_sa
/*
DECLARE
  v_employee_number number:= 124;
  v_emp_rec   employees%ROWTYPE;
BEGIN
 SELECT * INTO v_emp_rec FROM employees
 WHERE  employee_id = v_employee_number;
 INSERT INTO retired_emps(empno, ename, job, mgr,  hiredate,  
                                         leavedate, sal, comm, deptno)  
 VALUES (v_emp_rec.employee_id, v_emp_rec.last_name,  
 v_emp_rec.job_id, v_emp_rec.manager_id,  v_emp_rec.hire_date, SYSDATE, 
 v_emp_rec.salary,  v_emp_rec.commission_pct, v_emp_rec.department_id);
END;

/

SELECT * FROM retired_emps;
/
*/

--Uncomment the code below to execute the code on slide 18_na

/*
SET VERIFY OFF

DROP TABLE retired_emps;

CREATE TABLE retired_emps
   (EMPNO      NUMBER(4),
    ENAME      VARCHAR2(10),
    JOB        VARCHAR2(9),
    MGR        NUMBER(4),
    HIREDATE   DATE,
    LEAVEDATE  DATE,
    SAL        NUMBER(7,2),
    COMM       NUMBER(7,2),
    DEPTNO     NUMBER(2))
/

--Uncomment the code below to execute the code on slide 19_sa
DECLARE
  v_employee_number number:= 124;
  v_emp_rec   retired_emps%ROWTYPE;
BEGIN
 SELECT employee_id, last_name, job_id, manager_id, hire_date, hire_date,
  salary, commission_pct, department_id 
 INTO v_emp_rec FROM employees
 WHERE  employee_id = v_employee_number;
 INSERT INTO retired_emps  VALUES v_emp_rec;
END;

/

SELECT * FROM retired_emps;
/
*/

--Uncomment the code below to execute the code on slide 20_sa
/*

DECLARE
  v_employee_number number:= 124;
  v_emp_rec  retired_emps%ROWTYPE;
BEGIN
  SELECT * INTO v_emp_rec FROM retired_emps WHERE
  empno = v_employee_number;
  v_emp_rec.leavedate:= CURRENT_DATE;
  UPDATE retired_emps SET ROW = v_emp_rec WHERE
  empno = v_employee_number;
END;
/
SELECT * FROM retired_emps;

*/


--Uncomment the code below to execute the code on slide 26_sa
/*

DECLARE 
  TYPE email_table IS TABLE OF 
  employees.email%TYPE
  INDEX BY PLS_INTEGER;
  email_list email_table;
BEGIN
  email_list(100) := 'SKING';
  email_list(105) := 'DAUSTIN';
  email_list(110) := 'JCHEN';
  DBMS_OUTPUT.PUT_LINE(email_list(100));
  DBMS_OUTPUT.PUT_LINE(email_list(105));
  DBMS_OUTPUT.PUT_LINE(email_list(110));
END;
*/

--Uncomment the code below to execute the code on slide 27_sa
/*

SET SERVEROUTPUT ON

DECLARE
TYPE dept_table_type
IS
  TABLE OF departments%ROWTYPE INDEX BY VARCHAR2(20);
  dept_table dept_table_type;
  -- Each element of dept_table is a record
BEGIN
   SELECT * INTO dept_table(1) FROM departments WHERE department_id = 10;
   DBMS_OUTPUT.PUT_LINE(dept_table(1).department_id ||' '||
    dept_table(1).department_name ||' '|| dept_table(1).manager_id);
END;
/
*/

--Uncomment the code below to execute the code on slide 28_sa

/*
SET SERVEROUTPUT ON

DECLARE 
  TYPE email_table IS TABLE OF employees.email%TYPE
  INDEX BY PLS_INTEGER;
  email_list email_table;
BEGIN
  email_list(100) := 'SKING';
  email_list(105) := 'DAUSTIN';
  email_list(110) := 'JCHEN';
  DBMS_OUTPUT.PUT_LINE('The number of elements in the list ' || email_list.COUNT);
  DBMS_OUTPUT.PUT_LINE('The first index in the list ' || email_list.FIRST);
  DBMS_OUTPUT.PUT_LINE('The last index in the list ' || email_list.LAST);
END;  
/
*/

--Uncomment the code below to execute the code on slide 29_sa

/*
SET SERVEROUTPUT ON

DECLARE
  TYPE emp_table_type IS TABLE OF
  employees%ROWTYPE INDEX BY PLS_INTEGER;
  my_emp_table emp_table_type;
  max_count NUMBER(3) := 104;
BEGIN
  FOR i IN 100..max_count
  LOOP
    SELECT * INTO my_emp_table(i) FROM  employees
    WHERE employee_id = i;
    END LOOP;
  FOR  i IN my_emp_table.FIRST ..my_emp_table.LAST
  LOOP
    DBMS_OUTPUT.PUT_LINE(my_emp_table(i).last_name);
  END LOOP;
END;

/

--Execute the following code to drop the tables created earlier using this script.
DROP table retired_emps;
*/

--Uncomment the code below to execute the code on slide 31_sa
/*

DECLARE
TYPE dept_mail IS TABLE OF VARCHAR2(20);
mails dept_mail := dept_mail( 'SKING','NKOCHHAR','LDEHAAN', 'AHUNOLD');
BEGIN    
FOR i IN mails.FIRST..mails.LAST  LOOP
  DBMS_OUTPUT.PUT_LINE(mails(i));
  END LOOP;
END;
*/

--Uncomment the code below to execute the code on slide 34_sa
/*
DECLARE
TYPE emp_mail IS VARRAY(5) OF VARCHAR2(20);
mails emp_mail := emp_mail('NKOCHHAR','LDEHAAN', 'AHUNOLD');
BEGIN    FOR i IN mails.FIRST..mails.LAST  LOOP
  DBMS_OUTPUT.PUT_LINE(mails(i));
  END LOOP;
END;
*/