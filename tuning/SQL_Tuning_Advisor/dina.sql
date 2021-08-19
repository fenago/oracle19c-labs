DECLARE
 n number;
BEGIN
for i in 1..1000 loop
 select /*+ ORDERED USE_NL(c) FULL(c) FULL(s)*/ count(*) into n  
 from sales s, customers c 
 where c.cust_id = s.cust_id and CUST_FIRST_NAME='Dina'
 order by time_id;
 DBMS_LOCK.SLEEP(1);
end loop;
END;
/

