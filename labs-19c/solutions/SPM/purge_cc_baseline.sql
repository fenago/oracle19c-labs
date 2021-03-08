set echo on

variable cnt number;

exec :cnt := dbms_spm.drop_sql_plan_baseline(-
		'SYS_SQL_f6cb7f742ef93547');

print cnt;

REM Check that plan baselines were purged:

select signature, sql_handle, sql_text, plan_name,
	 origin, enabled, accepted, fixed, autopurge
from dba_sql_plan_baselines
where sql_text like 'select /*LOAD_CC*/%';

