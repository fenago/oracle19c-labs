set echo on

connect trace/trace@TRACESERV

alter session set workarea_size_policy=manual;

alter session set sort_area_size=50000;

alter session set hash_area_size=5000;


alter session set tracefile_identifier='mytraceP1';


set timing on

select /*+ ORDERED USE_HASH(s2) */ count(*) from sales s1, sales s2 where s1.cust_id=s2.cust_id;



connect trace/trace@TRACESERV

alter session set tracefile_identifier='mytraceS1';

set timing on

select /*+ ORDERED USE_HASH(s2) S1 */ count(*) from sales s1, sales s2 where s1.cust_id=s2.cust_id;

exit;

