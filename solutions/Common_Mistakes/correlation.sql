SELECT COUNT(*)
FROM   products p
WHERE  prod_list_price < 1.15 * (SELECT avg(unit_cost)
                                 FROM costs c
                                 WHERE c.prod_id = p.prod_id);

