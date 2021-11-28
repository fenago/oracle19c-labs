set echo on

set timing on

select count(*) from test t1, test t2 where t1.c=t2.c and t1.c=1;

