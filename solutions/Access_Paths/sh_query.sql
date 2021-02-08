SELECT c.cust_first_name, c.cust_last_name, c.cust_id, COUNT(s.prod_id)
FROM sh.customers c, sh.sales s
where c.cust_id = s.cust_id
and c.cust_id < 100 
GROUP BY c.cust_first_name, c.cust_last_name, c.cust_id