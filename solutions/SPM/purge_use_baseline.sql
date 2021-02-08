set echo on

variable cnt number;

exec :cnt := dbms_spm.drop_sql_plan_baseline(-
		'SYS_SQL_0a9d872600ece455');

print cnt;

select signature, sql_handle, sql_text, plan_name,
      origin, enabled, accepted, fixed, autopurge
from dba_sql_plan_baselines
where sql_text like 'select /*SPM_USE*/%';

