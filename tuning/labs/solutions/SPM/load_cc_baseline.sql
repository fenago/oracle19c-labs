set echo on

variable cnt number;

variable sqlid varchar2(20);

begin
 select distinct sql_id into :sqlid from v$sql 
  where sql_text like 'select /*LOAD_CC*/%';
end;
/

print sqlid;

exec :cnt := dbms_spm.load_plans_from_cursor_cache(-
		sql_id => :sqlid);

