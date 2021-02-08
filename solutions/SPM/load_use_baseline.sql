set echo on

variable cnt number;

variable sqlid varchar2(20);

begin
 select distinct sql_id into :sqlid from v$sql 
   where sql_text like 'select /*SPM_USE*/%';
end;
/

print sqlid;

exec :cnt := dbms_spm.load_plans_from_cursor_cache(-
		sql_id => :sqlid);

print cnt;

select signature, sql_handle, sql_text, plan_name,
	 origin, enabled, accepted, fixed, autopurge
from dba_sql_plan_baselines
where sql_text like 'select /*SPM_USE*/%';

