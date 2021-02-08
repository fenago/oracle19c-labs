set echo on

alter session set optimizer_dynamic_sampling = 0;

select count(*) from tabjfv where c1 = 1 and c2 = 1;

explain plan for select count(*) from tabjfv where c1 = 1 and c2 = 1;

select plan_table_output
from table(dbms_xplan.display('plan_table',null,'BASIC ROWS'));

