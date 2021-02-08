set echo on
set pagesize 30

select signature, sql_handle, sql_text, plan_name,
     origin, enabled, accepted, fixed, autopurge 
from dba_sql_plan_baselines 
where sql_text like 'select /*LOAD_STS*/%';

