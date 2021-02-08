set echo on

connect trace/trace@TRACESERV

alter session set tracefile_identifier='mytraceP5';

insert into sales2 select * from sh.sales union all select * from sales;
commit;


connect trace/trace@TRACESERV

alter session set tracefile_identifier='mytraceS5';

insert into sales3 select * from sh.sales union all select * from sales;
commit;

exit;

