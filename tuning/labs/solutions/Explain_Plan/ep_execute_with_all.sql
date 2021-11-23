set echo on

set timing on

select /*+ gather_plan_statistics */ count(*) from test t1, test t2 where t1.c=t2.c and t1.c=1;

