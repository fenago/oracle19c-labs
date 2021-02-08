set echo on
set long 10000000
set longchunksize 10000000
set linesize 200
set pagesize 1000

exec dbms_lock.sleep(8);

select dbms_sqltune.report_sql_monitor(sql_id=>'dkz7v96ym42c6',report_level=>'ALL') from dual;

