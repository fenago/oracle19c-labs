--The SQL Script to run the code_examples for Lesson 2

--Uncomment code below to run the code for slide 7_sa for lesson 2


/* 
                    SELECT *
                    FROM   departments;
*/

--Uncomment code below to run the code for slide 7_na for lesson 2


/*	
                    SELECT  department_id, department_name, manager_id, location_id 
                    FROM    departments;

*/


--Uncomment code below to run the code for slide 8_sa for lesson 2


/*	             SELECT department_id, location_id
                 FROM   departments;
*/


--Uncomment code below to run the code for slide 9_sa for lesson 2


/*	
                     SELECT *
                     FROM   dual;

*/

--Uncomment code below to run the code for slide 9_sb for lesson 2


/*	
                     SELECT sysdate
                     FROM   dual;

*/
--Uncomment code below to run the code for slide 9_na for lesson 2


/*	                
					select  12*4/5+5*8 
					from dual;


--Uncomment code below to run the code for slide 11_na for lesson 2


/*	                SELECT last_name, hire_date, salary
	                   FROM   employees;
*/

--Uncomment code below to run the code for slide 14_sa for lesson 2


/*	
                     SELECT last_name, salary, salary + 300
                     FROM   employees;
*/

--Uncomment code below to run the code for slide 15_sa for lesson 2


/*	
                     SELECT last_name, salary, 12*salary+100
                     FROM   employees;
*/   

--Uncomment code below to run the code for slide 15_sb for lesson 2


/*	                 SELECT last_name, salary, 12*(salary+100)
                     FROM   employees;
*/

--Uncomment code below to run the code for slide 16_sa for lesson 2


/*	
                     SELECT last_name, job_id, salary, commission_pct
                     FROM   employees;

*/
--Uncomment code below to run the code for slide 17_sa for lesson 2

/*
	                    SELECT last_name, 12*salary*commission_pct
                      FROM   employees;
*/

--Uncomment code below to run the code for slide 20_sa for lesson 2


/*	             
                     SELECT last_name AS name, commission_pct comm
                     FROM   employees;
*/

--Uncomment code below to run the code for slide 20_sb for lesson 2


/*	                 SELECT last_name "Name" , salary*12 "Annual Salary"
                     FROM   employees;
*/


--Uncomment code below to run the code for slide 22_sa for lesson 2


/*	 
                    SELECT last_name||job_id AS "Employees"
                    FROM 	employees;
*/

--Uncomment code below to run the code for slide 24_sa for lesson 2


/*	            
                    SELECT last_name ||' is a '||job_id 
                     AS "Employee Details"
                    FROM   employees;
*/

--Uncomment code below to run the code for slide 24_na for lesson 2


/*	
                    SELECT last_name ||': 1 Month salary = '||salary Monthly
                    FROM   employees;
*/

--Uncomment code below to run the code for slide 25_sa for lesson 2

/*
                    SELECT department_name || q'[ Department's Manager Id: ]' || manager_id 
                    AS "Department and Manager" 
                    FROM departments;
*/

--Uncomment code below to run the code for slide 26_sa for lesson 2

/*
                    SELECT department_id
                    FROM   employees;

/*

--Uncomment code below to run the code for slide 26_sb for lesson 2

/*
                    SELECT DISTINCT department_id
                    FROM   employees;
*/

--Uncomment code below to run the code for slide 26_na for lesson 2

/*
                    SELECT  DISTINCT department_id, job_id
                    FROM    employees;
*/


--Uncomment code below to run the code for slide 29_sa for lesson 2	

/*                 DESCRIBE employees

*/

