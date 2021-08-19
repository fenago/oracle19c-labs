-- Try without dynamic sampling
--
explain plan for select * from tabjfv where c1 = 1 and c2 = 1;

select plan_table_output from table(dbms_xplan.display('plan_table',null,'BASIC ROWS'));


-- Try the queries with dynamic sampling level 3. Dynamic sampling will not
-- kick in. It will use multi column stats and produce the same estimate 
-- (100 rows) as before.
explain plan for select /*+ dynamic_sampling(3) */ * from tabjfv where c1 = 1 and c2 = 1;

select plan_table_output from table(dbms_xplan.display('plan_table',null,'BASIC ROWS'));


-- Try with level 4. Dynamic sampling kicks in. we should see the improved
-- estimate (200 rows)
explain plan for select /*+ dynamic_sampling(4) */ * from tabjfv where c1 = 1 and c2 = 1;

select plan_table_output from table(dbms_xplan.display('plan_table',null,'BASIC ROWS'));

