set echo on

select signature, sql_handle, sql_text, plan_name,
 origin, enabled, accepted, fixed, autopurge
from dba_sql_plan_baselines
where sql_text like 
  'select /*+ USE_NL(s c) FULL(s) FULL(c) */%';

exec dbms_sqltune.accept_sql_profile(-
	task_name => :spmtune,-
	 name => 'SPM_SQL_PROF');

select signature, category, name, sql_text 
from dba_sql_profiles where name like 'SPM%';

select signature, sql_handle, sql_text, plan_name, 
origin, enabled, accepted, fixed, autopurge
from dba_sql_plan_baselines
where sql_text like 
   'select /*+ USE_NL(s c) FULL(s) FULL(c) */%';

