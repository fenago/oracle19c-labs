set echo on

explain plan for
select /*+ USE_NL(s c) FULL(s) FULL(c) */ 
	c.cust_id, sum(s.quantity_sold)
from sh.sales s, sh.customers c
where s.cust_id = c.cust_id and c.cust_id < 2
group by c.cust_id;

select * from table(dbms_xplan.display(null, null));

