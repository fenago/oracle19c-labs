set echo on

connect / as sysdba

alter system flush shared_pool;

--
-- Turn off AUTOTASK
--

alter system set "_enable_automatic_maintenance"=0;

alter session set container = orclpdb;

exec dbms_stats.delete_schema_stats('AGS');

exit;
