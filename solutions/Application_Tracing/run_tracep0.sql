set echo on

connect trace/trace@TRACESERV

alter session set tracefile_identifier='mytraceP0';

set termout off

select count(*) from dba_objects;
select count(*) from dba_objects;
select count(*) from dba_objects;
select count(*) from dba_objects;
select count(*) from dba_objects;
select count(*) from dba_objects;
select count(*) from dba_objects;
select count(*) from dba_objects;
select count(*) from dba_objects;
select count(*) from dba_objects;
select count(*) from dba_objects;
select count(*) from dba_objects;
select count(*) from dba_objects;
select count(*) from dba_objects;
select count(*) from dba_objects;
select count(*) from dba_objects;
select count(*) from dba_objects;
select count(*) from dba_objects;
select count(*) from dba_objects;
select count(*) from dba_objects;

exec dbms_lock.sleep(60);

set termout on

exit;

