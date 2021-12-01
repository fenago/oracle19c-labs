EXPLAIN PLAN FOR SELECT (s.yyyy || s.mm || s.dd) TIME, s.prod_id, sum(amount_sold)
FROM   sh.sales1 s, sh.prod1 p
WHERE  s.prod_id = p.prod_id
AND (s.yyyy = '1998' AND s.mm = '09' AND s.dd BETWEEN '01' AND '07')
AND    p.prod_category = 'Hardware'
GROUP BY  s.yyyy || s.mm || s.dd, s.prod_id
ORDER BY 1
/
SELECT * FROM TABLE(dbms_xplan.display);
