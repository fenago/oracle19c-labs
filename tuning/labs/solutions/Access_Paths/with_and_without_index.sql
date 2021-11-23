set echo on

set timing on
set autotrace traceonly
set linesize 200 pagesize 1000

alter system flush shared_pool;
alter system flush buffer_cache;

select * from mysales where prod_id=0;

set timing off
set autotrace off

