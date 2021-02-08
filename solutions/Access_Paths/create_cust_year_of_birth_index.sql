set echo on

CREATE INDEX cust_cust_year_of_birth_idx
ON customers(cust_year_of_birth)
NOLOGGING COMPUTE STATISTICS;

