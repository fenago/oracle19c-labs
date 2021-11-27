set echo on

select name from dba_services;

exec DBMS_SERVICE.DELETE_SERVICE('TRACESERV');

select name from dba_services;

