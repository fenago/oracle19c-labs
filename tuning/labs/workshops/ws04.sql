SELECT (s.yyyy || s.mm || s.dd) TIME, s.prod_id, sum (amount_sold)
FROM   sh.sales1 s, sh.prod1 p
WHERE s.prod_id = p.prod_id
AND    s.yyyy || s.mm || s.dd BETWEEN '19980901' AND '19980907'
AND    p.prod_category = 'Hardware'
GROUP BY s.prod_id, s.yyyy || s.mm || s.dd
ORDER BY 1
/
