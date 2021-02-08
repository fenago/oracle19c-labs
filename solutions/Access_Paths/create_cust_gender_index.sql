set echo on

CREATE INDEX cust_cust_gender_idx
ON customers(cust_gender)
NOLOGGING COMPUTE STATISTICS;

