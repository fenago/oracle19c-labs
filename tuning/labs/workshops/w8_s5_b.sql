select sql_text, sql_handle, plan_name, enabled, accepted 
from dba_sql_plan_baselines
where sql_text like 'SELECT /* ACS %';
