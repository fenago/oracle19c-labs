SELECT /*+ INDEX(c) */ c.*                  
FROM   customers c
WHERE cust_gender = 'M'
AND   cust_postal_code = 40804
/

