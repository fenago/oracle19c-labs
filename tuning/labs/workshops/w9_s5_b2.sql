SET LINESIZE 150
SET PAGESIZE 2000
SELECT t.* FROM TABLE(DBMS_XPLAN.DISPLAY_SQL_PLAN_BASELINE(<<'Please enter the SQL_HANDLE value'>>)) t;