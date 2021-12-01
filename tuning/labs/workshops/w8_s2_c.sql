SELECT country_id, count(*), (count(*)*100)/55500 PCT
FROM sh.customers
GROUP BY country_id
ORDER BY country_id
/
