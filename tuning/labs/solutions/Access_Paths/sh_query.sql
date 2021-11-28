SELECT p.prod_name, p.prod_id
FROM sh.products p, sh.sales s where p.prod_id = s.prod_id
and s.prod_id < 100;
