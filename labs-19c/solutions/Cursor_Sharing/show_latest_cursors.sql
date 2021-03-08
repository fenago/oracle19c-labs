set echo on

col sql_text format a70

select sql_text,hash_value
from v$sql
where sql_text like '%select /*CS%';
