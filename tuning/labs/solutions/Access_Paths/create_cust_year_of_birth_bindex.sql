set echo on

CREATE BITMAP INDEX cust_cust_year_of_birth_bidx
ON customers(cust_year_of_birth)
NOLOGGING COMPUTE STATISTICS;

