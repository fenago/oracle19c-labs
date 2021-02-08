set echo on

alter user sh identified by sh account unlock;

grant dba to sh;

connect sh/sh

exec dbms_stats.delete_schema_stats('SH');

exec dbms_stats.set_table_stats('SH','SALES',null,null,null,10,5);

exit;

