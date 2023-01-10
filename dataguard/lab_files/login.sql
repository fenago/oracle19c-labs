set numwidth 20
set linesize 132
set pagesize 200
var serv_name varchar2(20)
select value into :serv_name
from v$parameter
where name='service_names';
column salary format $999,999.99
column comm format $99,999.99
define gname = 'NOT A DBA'
column global_name new_value gname
set termout off
SELECT
user || ' (' ||  :serv_name || ')'  global_name
FROM
 global_name;
set termout on
set sqlprompt '&&gname >'
set termout on
COLUMN TABLE_NAME FORMAT A15
column file_name format a65
column tablespace_name format a20
column name format a11
set feedback on
set serveroutput on

