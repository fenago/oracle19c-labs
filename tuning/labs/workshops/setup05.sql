DROP TABLE sh.cust PURGE
/
CREATE TABLE sh.cust as SELECT * FROM sh.customers
/

DROP INDEX sh.cust_state_idx 
/

CREATE INDEX sh.cust_state_idx 
ON sh.cust(cust_state_province)
NOLOGGING
COMPUTE STATISTICS
/

DROP INDEX sh.cust_state_gender_idx
/

CREATE INDEX sh.cust_state_gender_idx  
ON sh.cust(cust_state_province,cust_gender)
NOLOGGING
COMPUTE STATISTICS
/

ALTER INDEX sh.cust_state_gender_idx INVISIBLE
/

DROP INDEX sh.cust_income_state_idx
/

CREATE INDEX sh.cust_income_state_idx 
ON sh.cust(cust_income_level,cust_state_province)
NOLOGGING
COMPUTE STATISTICS
/

ALTER INDEX sh.cust_income_state_idx INVISIBLE
/

exec DBMS_STATS.GATHER_TABLE_STATS('SH','CUST', METHOD_OPT => 'FOR ALL INDEXED COLUMNS', CASCADE => TRUE)
/

