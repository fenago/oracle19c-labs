EXPLAIN PLAN FOR SELECT /*+ INDEX_COMBINE(cust cust_gender_bix, cust_yob_bix) */ *
FROM sh.cust
WHERE cust_year_of_birth < 70
AND cust_gender = 'M'
/

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
