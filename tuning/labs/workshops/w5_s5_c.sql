DROP INDEX sh.cust_state_income_idx
/
CREATE INDEX sh.cust_state_income_idx
ON sh.cust (cust_state_province, cust_income_level)
NOLOGGING
COMPUTE STATISTICS
/
exec DBMS_STATS.GATHER_TABLE_STATS('SH','CUST', METHOD_OPT => 'FOR ALL INDEXED COLUMNS', CASCADE => TRUE)
/
