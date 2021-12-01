variable country_id number
exec :country_id:= 52790

SELECT /* ACS */ cust_city, sum(amount_sold)
FROM sales s, customers c
WHERE s.cust_id=c.cust_id  and country_id = :country_id
GROUP BY cust_city
ORDER BY 2
/
SELECT * FROM table(dbms_xplan.display_cursor)
/
