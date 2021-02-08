set echo on

show parameter service_names

exec DBMS_SERVICE.START_SERVICE('TRACESERV');

show parameter service_names

