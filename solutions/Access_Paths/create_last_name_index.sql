set echo on

CREATE INDEX cust_cust_last_name_idx
ON customers(cust_last_name)
NOLOGGING COMPUTE STATISTICS;

