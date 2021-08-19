set echo on

select name from dba_services;

exec DBMS_SERVICE.CREATE_SERVICE('TRACESERV','TRACESERV');

select name from dba_services;

