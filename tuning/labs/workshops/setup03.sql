DROP TABLE sh.cust PURGE
/

CREATE TABLE sh.cust (
    cust_id number primary key,
    cust_first_name varchar(20),
    cust_last_name varchar(40),
    cust_credit_limit number,
    cust_state_province varchar2(40) 
)
/

INSERT INTO sh.cust 
SELECT cust_id, cust_first_name, cust_last_name, cust_credit_limit, cust_state_province
FROM  sh.customers
/

commit
/

CREATE INDEX sh.cust_cust_state_province_idx
ON sh.cust(cust_state_province)
NOLOGGING
COMPUTE STATISTICS
/

exec dbms_stats.gather_table_stats('SH','CUST',method_opt=>'for all indexed columns',cascade=>true)
/

DESC sh.cust

