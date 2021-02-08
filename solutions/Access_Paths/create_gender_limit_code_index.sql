set echo on

CREATE INDEX cust_gender_limit_code_idx
ON customers(cust_gender,cust_credit_limit,cust_postal_code)
NOLOGGING COMPUTE STATISTICS;

