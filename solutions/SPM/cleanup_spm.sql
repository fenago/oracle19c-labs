set echo on

exec dbms_sqltune.drop_sql_profile(-
	name => 'SPM_SQL_PROF');

exec :cnt := dbms_spm.drop_sql_plan_baseline(-
		'SYS_SQL_18a1ef14c17f5b75');

select signature, sql_handle, sql_text, plan_name,
	 origin, enabled, accepted, fixed, autopurge
from dba_sql_plan_baselines
where sql_text like 
	'select /*+ USE_NL(s c) FULL(s) FULL(c) */%';

select signature, category, name, sql_text 
from dba_sql_profiles where name like 'SPM%';

alter system set optimizer_use_sql_plan_baselines=FALSE;

