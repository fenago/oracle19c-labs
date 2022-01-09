--This is the SQL Script to run the code_examples for Lesson 3

--Uncomment the code below to execute the code on slide 12_sa

/*
SET SERVEROUTPUT ON

DECLARE
  v_myName  VARCHAR2(20);
BEGIN
  DBMS_OUTPUT.PUT_LINE('My name is: '||v_myName );
  v_myName  := 'John';
  DBMS_OUTPUT.PUT_LINE('My name is: '||v_myName );
END;
/
*/

--Uncomment the code below to execute the code on slide 12_sb

/*
SET SERVEROUTPUT ON

DECLARE
  v_myName VARCHAR2(20):= 'John';
BEGIN
  v_myName:= 'Steven';
  DBMS_OUTPUT.PUT_LINE('My name is: '||v_myName);
END; 
/
*/

--Uncomment the code below to execute the code on slide 21_sa

/*
SET SERVEROUTPUT ON

DECLARE
   v_event VARCHAR2(15);
BEGIN
  v_event := q'!Father's day!';
  DBMS_OUTPUT.PUT_LINE('3rd Sunday in June is : '||v_event);
  v_event := q'[Mother's day]';
  DBMS_OUTPUT.PUT_LINE('2nd Sunday in May is : '||v_event);
END;
/
*/

--Uncomment the code below to execute the code on slide 25_na
/*
DECLARE
 		 v_salary NUMBER(6):=6000;
 		 v_sal_hike VARCHAR2(5):='1000';
 		 v_total_salary v_salary%TYPE;
		BEGIN
 		 v_total_salary:=v_salary + v_sal_hike;
 		 DBMS_OUTPUT.PUT_LINE(v_total_salary);
		END;
    /
  */


--Uncomment the code below to execute the code on slide 36_sa

/*
VARIABLE b_result NUMBER
BEGIN
  SELECT (SALARY*12) + NVL(COMMISSION_PCT,0) INTO :b_result
  FROM employees WHERE employee_id = 144;
END;
/
PRINT b_result
/
*/

--Uncomment the code below to execute the code on slide 36_sb

/*
VARIABLE b_emp_salary NUMBER
BEGIN
   SELECT salary  INTO :b_emp_salary 
   FROM  employees WHERE employee_id = 178;  
END;
/
Print b_emp_salary
SELECT first_name, last_name
FROM  employees
WHERE salary = :b_emp_salary;
*/

--Uncomment the code below to execute the code on slide 37_sa

/*
VARIABLE b_emp_salary NUMBER
SET AUTOPRINT ON
DECLARE
  v_empno NUMBER(6):=&empno;
BEGIN
   SELECT salary  INTO :b_emp_salary 
   FROM  employees WHERE employee_id = v_empno;  
END;
/
*/



