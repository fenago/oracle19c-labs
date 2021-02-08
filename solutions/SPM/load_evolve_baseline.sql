set echo on

variable cnt number;

variable sqlid varchar2(20);

select /*+ USE_NL(s c) FULL(s) FULL(c) */ 
       c.cust_id, sum(s.quantity_sold)
from sh.sales s, sh.customers c
where s.cust_id = c.cust_id and c.cust_id < 2
group by c.cust_id;

begin
 select sql_id into :sqlid from v$sql 
 where sql_text like 'select /*+ USE_NL(s c) FULL(s) FULL(c) */%';
end;
/

exec :cnt := dbms_spm.load_plans_from_cursor_cache(-
		sql_id => :sqlid);

select signature, sql_handle, sql_text, plan_name, 
	origin, enabled, accepted, fixed, autopurge
from dba_sql_plan_baselines
where sql_text like 'select /*+ USE_NL(s c) FULL(s) FULL(c) */%';

