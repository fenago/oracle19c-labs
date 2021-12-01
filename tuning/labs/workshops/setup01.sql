set echo on

DROP TABLE hr.emp PURGE
/
CREATE TABLE hr.emp AS SELECT * FROM hr.employees
/
DROP TABLE hr.dept PURGE
/
CREATE TABLE hr.dept AS
SELECT (department_id||'-'||department_name) dept_id, manager_id, location_id
FROM  hr.departments
/

DROP INDEX hr.dept_dept_id_idx1
/
CREATE INDEX hr.dept_dept_id_idx1
ON hr.dept (dept_id)

NOLOGGING 
COMPUTE STATISTICS
/
exec DBMS_STATS.GATHER_TABLE_STATS('HR','EMP')
/
exec DBMS_STATS.GATHER_TABLE_STATS('HR','DEPT')
/

set echo off
