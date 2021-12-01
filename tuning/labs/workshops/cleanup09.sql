select sql_text, sql_handle, plan_name, enabled, accepted 
from dba_sql_plan_baselines 
where sql_text like 'SELECT /*+ INDEX_COMBINE(cust%'
/
var res number;
exec :res :=DBMS_SPM.DROP_SQL_PLAN_BASELINE(<<'Please enter the SQL_HANDLE value'>>);

DROP TABLE sh.cust
/
