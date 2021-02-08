set echo on

variable cnt number;

select sql_handle,plan_name
from dba_sql_plan_baselines
where sql_text like 'select /*SPM_USE*/%';


exec :cnt := dbms_spm.alter_sql_plan_baseline( -
      sql_handle        => 'SYS_SQL_0a9d872600ece455', -
      plan_name         => 'SQL_PLAN_0p7c74s0ftt2p54bc8843', -
      attribute_name    => 'ENABLED', -
      attribute_value   => 'NO');

select signature, sql_handle, sql_text, plan_name, 
      origin, enabled, accepted, fixed, autopurge
from dba_sql_plan_baselines
where sql_text like 'select /*SPM_USE*/%';


explain plan for select /*SPM_USE*/ * from sh.sales 
        where quantity_sold > 40 order by prod_id;

select * from table(dbms_xplan.display(null, null, 'BASIC NOTE'));

