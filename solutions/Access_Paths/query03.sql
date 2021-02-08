SELECT /*+ INDEX(c) */ c.*   
FROM   customers c      
WHERE  cust_gender   = 'M'
AND   cust_credit_limit = 10000
/