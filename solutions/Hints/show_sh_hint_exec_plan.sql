select /*+ LEADING(c s) USE_HASH(s) */ count(*) 
 from sales s, customers c 
 where s.cust_id=c.cust_id;
