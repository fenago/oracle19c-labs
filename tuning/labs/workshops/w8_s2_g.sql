SELECT cust_city,sum(amount_sold)
FROM sales s, customers c
WHERE s.cust_id=c.cust_id  and country_id = 52787
GROUP BY cust_city
ORDER BY 2
/
SELECT * FROM table(dbms_xplan.display_cursor);

