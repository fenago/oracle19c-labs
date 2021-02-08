set echo on 

CREATE BITMAP INDEX cust_cust_credit_limit_bidx ON customers(cust_credit_limit)
NOLOGGING COMPUTE STATISTICS;

