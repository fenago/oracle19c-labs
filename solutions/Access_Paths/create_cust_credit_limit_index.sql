set echo on

CREATE INDEX cust_cust_credit_limit_idx
ON customers(cust_credit_limit)
NOLOGGING COMPUTE STATISTICS;

