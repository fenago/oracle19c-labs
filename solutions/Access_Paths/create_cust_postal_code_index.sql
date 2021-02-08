set echo on

CREATE INDEX cust_cust_postal_code_idx
ON customers(cust_postal_code)
NOLOGGING COMPUTE STATISTICS;

