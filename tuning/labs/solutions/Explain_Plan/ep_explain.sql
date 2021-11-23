set echo on

set linesize 200 pagesize 1000

explain plan for 
select count(*) from test t1, test t2 where t1.c=t2.c and t1.c=1;

select * from table(dbms_xplan.display);

