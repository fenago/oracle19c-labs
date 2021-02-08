set echo on

select child_number, executions, buffer_gets
from v$sql
where sql_text like 'select /*ACS_1%';

