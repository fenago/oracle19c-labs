set echo on

CREATE INDEX lower_cust_last_name_idx ON
customers(LOWER(cust_last_name))
/

