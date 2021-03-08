set echo on

connect trace/trace@TRACESERV

alter session set tracefile_identifier='mytraceP6';

exec dbms_lock.sleep(30);

set termout off

select cust_id, sum(amount_sold) from sales group by cust_id order by cust_id;

set tournout on

exit;

