SELECT /*+ FULL(c) */ c.*                  
FROM   customers c
WHERE  cust_gender   = 'M'
AND    cust_postal_code = 40804
AND   cust_credit_limit = 10000
/


