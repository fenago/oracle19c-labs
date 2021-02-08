set echo on

show parameter service_names

exec DBMS_SERVICE.STOP_SERVICE('TRACESERV');

show parameter service_names

