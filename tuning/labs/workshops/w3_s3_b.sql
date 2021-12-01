EXPLAIN PLAN FOR SELECT cust_first_name, cust_last_name, cust_credit_limit
FROM sh.cust
WHERE  cust_state_province='NJ'
ORDER BY cust_last_name, cust_first_name
/
SELECT * FROM TABLE(dbms_xplan.display);
