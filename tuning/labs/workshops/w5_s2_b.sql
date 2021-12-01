EXPLAIN PLAN FOR SELECT cust_first_name, cust_last_name, cust_income_level, cust_credit_limit
FROM  sh.cust
WHERE cust_income_level like 'F%'
AND   cust_state_province||'' in ('NJ', 'NY')
AND   cust_gender ||'' = 'M'
/
SELECT * FROM TABLE(dbms_xplan.display);