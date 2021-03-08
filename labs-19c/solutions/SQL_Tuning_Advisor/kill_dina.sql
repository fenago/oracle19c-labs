
set head off
set timing off
set feedback off;
set pagesize 0
set verify off
 
spool /tmp/drop_dina.sql;

select 'connect / as sysdba;' from dual;

select 'alter system kill session ''' || sid || ',' || serial# || ''';'
from v$session
where process=&1;  

select 'exit;' from dual;

spool off

exit;

