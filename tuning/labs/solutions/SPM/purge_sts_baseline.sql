set echo on

variable cnt number;

exec :cnt := dbms_spm.drop_sql_plan_baseline(-
		'SYS_SQL_a8632bd857a4a25e');

print cnt;

select signature, sql_handle, sql_text, plan_name,
       origin, enabled, accepted, fixed, autopurge
from dba_sql_plan_baselines
where sql_text like 'select /*LOAD_STS*/%';

exec sys.dbms_sqltune.drop_sqlset(-
		sqlset_name  => 'SPM_STS', -
                sqlset_owner => 'SPM');

