set echo on

set linesize 200
set timing on
set autotrace traceonly

alter session set workarea_size_policy=manual;
alter session set sort_area_size=50000;

alter system flush shared_pool;
alter system flush buffer_cache;


select * from bigemp_fact where deptno=10;

set autotrace off
set timing off

