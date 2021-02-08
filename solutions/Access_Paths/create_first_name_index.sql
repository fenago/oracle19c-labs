set echo on

CREATE INDEX cust_cust_first_name_idx
ON customers(cust_first_name)
NOLOGGING COMPUTE STATISTICS;

