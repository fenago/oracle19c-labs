-- 1st Query

SELECT cust_first_name, cust_last_name, cust_income_level, cust_credit_limit
FROM  sh.cust
WHERE cust_income_level like 'F%'
AND   cust_state_province||'' in ('NJ', 'NY')
AND   cust_gender ||'' = 'M'
/

--2nd Query
 
SELECT cust_first_name, cust_last_name, cust_income_level, cust_credit_limit
FROM  sh.cust
WHERE cust_income_level like 'F%'
AND   cust_state_province in ('NJ', 'NY')
AND   cust_gender = 'M'
AND   rownum < 31
/
 
--3rd Query

SELECT cust_first_name, cust_last_name, cust_income_level, cust_credit_limit
FROM  ( SELECT cust_first_name, cust_last_name, cust_income_level, cust_credit_limit
FROM   sh.cust
WHERE cust_income_level like 'F%' AND cust_state_province = 'NJ'
AND cust_gender= 'M'
union all
SELECT cust_first_name, cust_last_name, cust_income_level, cust_credit_limit
FROM sh.cust
WHERE cust_income_level like 'F%' AND cust_state_province = 'NY'
AND cust_gender= 'M' )
WHERE     rownum < 31
/


