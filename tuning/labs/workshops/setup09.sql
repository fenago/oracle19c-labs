DROP TABLE sh.cust    
/
CREATE TABLE sh.cust AS SELECT * FROM sh.customers
/
DROP INDEX sh.cust_yob_bix
/
CREATE BITMAP INDEX sh.cust_yob_bix 
ON sh.cust(cust_year_of_birth)
NOLOGGING
COMPUTE STATISTICS
/
DROP INDEX sh.cust_gender_bix
/
CREATE BITMAP INDEX sh.cust_gender_bix
ON sh.cust(cust_gender)
NOLOGGING
COMPUTE STATISTICS
/
exec DBMS_STATS.GATHER_TABLE_STATS('SH','CUST')
/


