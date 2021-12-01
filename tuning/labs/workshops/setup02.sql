DROP TABLE hr.emp PURGE
/
CREATE TABLE emp (
   emp_id  varchar2(5) CONSTRAINT emp_id_pk PRIMARY KEY,
   emp_fn  varchar2(20),
   emp_ln  varchar2(20),
   dept_id  varchar2(5) 
)
/
INSERT INTO emp        
SELECT employee_id, first_name, last_name, department_id from employees
/
commit
/
exec DBMS_STATS.GATHER_TABLE_STATS('HR','EMP', METHOD_OPT => 'for all indexed columns', CASCADE => TRUE)
/

