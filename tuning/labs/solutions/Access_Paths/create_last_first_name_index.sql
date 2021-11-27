set echo on

CREATE INDEX cust_last_first_name_idx
ON customers(cust_last_name,cust_first_name)
NOLOGGING COMPUTE STATISTICS;

