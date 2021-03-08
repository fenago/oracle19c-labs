SELECT cust_id, country_id 
FROM customers              
WHERE LOWER( cust_last_name) LIKE 'gentle'
/
