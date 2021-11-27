set echo on

set linesize 200 pagesize 1000

col sql_text format a50

select sql_id,plan_hash_value,sql_text from v$sql where sql_text like '%from test t1, test t2%';

select * from table(dbms_xplan.display_cursor('dkz7v96ym42c6',null,'TYPICAL'));

select * from table(dbms_xplan.display_cursor('8w580dd6ncgqw',null,'ADVANCED ALLSTATS LAST'));

