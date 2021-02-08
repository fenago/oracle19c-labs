set echo on 

CREATE BITMAP INDEX cust_cust_gender_bidx ON customers(cust_gender)
NOLOGGING COMPUTE STATISTICS;

