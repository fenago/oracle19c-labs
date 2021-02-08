set echo on 

CREATE BITMAP INDEX cust_cust_postal_code_bidx ON customers(cust_postal_code)
NOLOGGING COMPUTE STATISTICS;

