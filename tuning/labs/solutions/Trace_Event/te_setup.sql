set echo on

ALTER SESSION SET container=orclpdb;

ALTER SESSION SET TRACEFILE_IDENTIFIER = 'MYOPTIMIZER';

alter session set events '10053 trace name context forever, level 1';

SELECT ch.channel_class, c.cust_city, t.calendar_quarter_desc, SUM(s.amount_sold) sales_amount
FROM   sh.sales s,sh.times t,sh.customers c,sh.channels ch
WHERE  s.time_id = t.time_id AND 
       s.cust_id = c.cust_id AND
       s.channel_id = ch.channel_id AND 
       c.cust_state_province = 'CA' AND 
       ch.channel_desc IN ('Internet','Catalog') AND 
       t.calendar_quarter_desc IN ('1999-01','1999-02')
GROUP BY ch.channel_class, c.cust_city, t.calendar_quarter_desc;
COMMIT;

exit;
