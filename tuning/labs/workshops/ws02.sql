variable empid number
exec :empid := 190

EXPLAIN PLAN FOR 
SELECT * FROM hr.emp WHERE emp_id = :empid
/
Select * from table(dbms_xplan.display);
