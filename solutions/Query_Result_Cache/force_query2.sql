set echo on

show parameter result_cache_mode

select type,status,name,object_no,row_count,row_size_avg from v$result_cache_objects order by 1;

alter session set result_cache_mode=force;

explain plan for
select count(*)
from cachejfv c1,cachejfv c2,cachejfv c3,cachejfv c4,cachejfv c5,cachejfv c6, cachejfv c7
where c1.c='b' and c2.c='b' and c3.c='b' and c4.c='b' and c5.c='b' and c6.c='b' and c7.c='b'; 

set linesize 180
set pagesize 200

select plan_table_output from table(dbms_xplan.display('plan_table',null,'ALL'));

select count(*)
from cachejfv c1,cachejfv c2,cachejfv c3,cachejfv c4,cachejfv c5,cachejfv c6, cachejfv c7
where c1.c='b' and c2.c='b' and c3.c='b' and c4.c='b' and c5.c='b' and c6.c='b' and c7.c='b';

select type,status,name,object_no,row_count,row_size_avg from v$result_cache_objects order by 1;

alter session set result_cache_mode=manual;

