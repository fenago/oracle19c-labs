SELECT /*+ INDEX_JOIN(c cust_cust_first_name_idx cust_cust_last_name_idx) */ c.cust_last_name          
,      c.cust_first_name
FROM   customers c
/
