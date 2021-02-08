SELECT COUNT(*)
FROM   products p, (SELECT prod_id, AVG(unit_cost) ac FROM costs GROUP BY prod_id) c
WHERE  p.prod_id = c.prod_id AND
       p.prod_list_price < 1.15 * c.ac;

