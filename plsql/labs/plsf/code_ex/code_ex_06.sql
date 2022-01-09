--This is the SQL Script to run the code_examples for Lesson 6

--Uncomment the code below to execute the code on slide 8_sa

/*
SET SERVEROUTPUT ON

DECLARE
v_myage number:=10;
BEGIN
IF v_myage < 11
 THEN
    DBMS_OUTPUT.PUT_LINE(' I am a child ');  
END IF;
END;
/
*/

--Uncomment the code below to execute the code on slide 9_sa

/*
SET SERVEROUTPUT ON

DECLARE
v_myage number:=31;
BEGIN
IF v_myage < 11
 THEN
    DBMS_OUTPUT.PUT_LINE(' I am a child ');  
 ELSE
    DBMS_OUTPUT.PUT_LINE(' I am not a child ');
END IF;
END;
/
*/

--Uncomment the code below to execute the code on slide 10_sa

/*

SET SERVEROUTPUT ON

DECLARE
v_myage number:=31;
BEGIN
IF v_myage < 11
 THEN
       DBMS_OUTPUT.PUT_LINE(' I am a child ');
   ELSIF v_myage < 20 
     THEN 
       DBMS_OUTPUT.PUT_LINE(' I am young ');
   ELSIF v_myage < 30
     THEN
       DBMS_OUTPUT.PUT_LINE(' I am in my twenties');
   ELSIF v_myage < 40
     THEN
       DBMS_OUTPUT.PUT_LINE(' I am in my thirties');
 ELSE
    DBMS_OUTPUT.PUT_LINE(' I am always young ');
END IF;
END;
/
*/

--Uncomment the code below to execute the code on slide 11_sa
/* 

SET SERVEROUTPUT ON

DECLARE
v_myage number;
BEGIN
IF v_myage < 11
 THEN
    DBMS_OUTPUT.PUT_LINE(' I am a child ');  
 ELSE
    DBMS_OUTPUT.PUT_LINE(' I am not a child ');
END IF;
END;
/
*/

--Uncomment the code below to execute the code on slide 14_sa
/*

SET SERVEROUTPUT ON

SET VERIFY OFF
DECLARE
   v_grade CHAR(1) := UPPER('&grade');
   v_appraisal VARCHAR2(20);
BEGIN
   v_appraisal := 
      CASE v_grade
         WHEN 'A' THEN 'Excellent'
         WHEN 'B' THEN 'Very Good'
         WHEN 'C' THEN 'Good'
         ELSE 'No such grade'
      END;
DBMS_OUTPUT.PUT_LINE ('Grade: '|| v_grade || '   Appraisal ' || v_appraisal);
END;
/
*/

--Uncomment the code below to execute the code on slide 15_sa

/*
SET SERVEROUTPUT ON

DECLARE
   v_grade CHAR(1) := UPPER('&grade');
   v_appraisal VARCHAR2(20);
BEGIN
    v_appraisal := 
      CASE 
         WHEN v_grade = 'A' THEN 'Excellent'
         WHEN v_grade IN ('B','C') THEN 'Good'                  
         ELSE 'No such grade'   
     END;
DBMS_OUTPUT.PUT_LINE ('Grade: '|| v_grade || '  Appraisal ' || v_appraisal);
END;
/
*/

--Uncomment the code below to execute the code on slide 16_sa
/*

SET SERVEROUTPUT ON

DECLARE
   v_deptid NUMBER;
   v_deptname VARCHAR2(20);
   v_emps NUMBER;
   v_mngid NUMBER:= 108;
   
BEGIN
     CASE  v_mngid
         WHEN  108 THEN 
            SELECT department_id, department_name INTO v_deptid, v_deptname 
                FROM departments WHERE manager_id=108;
            SELECT count(*) INTO v_emps FROM employees WHERE 
               department_id=v_deptid;
         WHEN  200 THEN 
            SELECT department_id, department_name INTO v_deptid, v_deptname 
                FROM departments WHERE manager_id=200;
            SELECT count(*) INTO v_emps FROM employees WHERE 
               department_id=v_deptid;
         WHEN  121 THEN 
            SELECT department_id, department_name INTO v_deptid, v_deptname 
                FROM departments WHERE manager_id=121;
            SELECT count(*) INTO v_emps FROM employees WHERE 
               department_id=v_deptid;        
     END CASE;
DBMS_OUTPUT.PUT_LINE ('You are working in the '|| v_deptname||' department. There are '||v_emps ||' employees in this department');

END;
/
*/

--Uncomment the code below to execute the code on slide 23_sa

/*
select * FROM locations;
DECLARE
v_countryid locations.country_id%TYPE := 'CA';
v_loc_id locations.location_id%TYPE;
v_counter NUMBER(2) := 1;
v_new_city locations.city%TYPE := 'Montreal';
BEGIN
SELECT MAX(location_id) INTO v_loc_id FROM locations
WHERE country_id = v_countryid;
LOOP
INSERT INTO locations(location_id, city, country_id)
VALUES((v_loc_id + v_counter), v_new_city, v_countryid);
v_counter := v_counter + 1;
EXIT WHEN v_counter > 3;
END LOOP;
DBMS_OUTPUT.PUT_LINE(v_counter-1 || ' rows added');
END;
/
select * FROM locations;
rollback;
/
*/

--Uncomment the code below to execute the code on slide 25_sa
/*

SELECT * FROM locations;
DECLARE
v_countryid locations.country_id%TYPE := 'CA';
v_loc_id locations.location_id%TYPE;
v_new_city locations.city%TYPE := 'Montreal';
v_counter NUMBER := 1;
BEGIN
SELECT MAX(location_id) INTO v_loc_id FROM locations
WHERE country_id = v_countryid;
WHILE v_counter <= 3 LOOP
INSERT INTO locations(location_id, city, country_id)
VALUES((v_loc_id + v_counter), v_new_city, v_countryid);
v_counter := v_counter + 1;
END LOOP;
DBMS_OUTPUT.PUT_LINE(v_counter-1 || ' rows added');
END;
/
SELECT * FROM locations;
ROLLBACK;
/
*/

--Uncomment the code below to execute the code on slide 28_sa
/*


DECLARE
v_countryid locations.country_id%TYPE := 'CA';
v_loc_id locations.location_id%TYPE;
v_new_city locations.city%TYPE := 'Montreal';
BEGIN
SELECT MAX(location_id) INTO v_loc_id
FROM locations
WHERE country_id = v_countryid;
FOR i IN 1..3 LOOP
INSERT INTO locations(location_id, city, country_id)
VALUES((v_loc_id + i), v_new_city, v_countryid );
END LOOP;
END;
/
select * FROM locations;
/
ROLLBACK;
/
*/

--Uncomment the code below to execute the code on slide 34_sa
/*

SET SERVEROUTPUT ON

DECLARE
  v_total SIMPLE_INTEGER := 0;
BEGIN
  FOR i IN 1..10 LOOP
    v_total := v_total + i;
    dbms_output.put_line
     ('Total is: '|| v_total);
    CONTINUE WHEN i > 5;
    v_total := v_total + i; 
    dbms_output.put_line
     ('Out of Loop Total is:
      '|| v_total);    
  END LOOP;
END;
/
*/

--Uncomment the code below to execute the code on slide 35_sa
/*

SET SERVEROUTPUT ON

DECLARE 
 v_total NUMBER := 0;
BEGIN
 <<BeforeTopLoop>>
 FOR i IN 1..5 LOOP
   v_total := v_total + 1;
   dbms_output.put_line 
     ('v_total( in  BeforeTopLoop is): ' || v_total);
   FOR j IN 1..5 LOOP
     CONTINUE BeforeTopLoop WHEN i + j > 5;
     v_total := v_total + 1;
     dbms_output.put_line 
     ('v_total (in the innerloop is): ' || v_total);
   END LOOP;
 END LOOP BeforeTopLoop;
END;
/
*/






