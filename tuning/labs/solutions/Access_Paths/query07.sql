SELECT  c.*                
FROM  customers c
WHERE  (c.cust_year_of_birth = '1970' And c.cust_postal_code  = 40804 )
AND NOT  cust_credit_limit = 15000
/

