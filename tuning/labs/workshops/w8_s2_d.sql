exec DBMS_STATS.GATHER_TABLE_STATS(OWNNAME=>'SH', TABNAME=>'CUSTOMERS', METHOD_OPT => 'FOR COLUMNS SIZE 25 country_id', CASCADE => TRUE)

SELECT column_name, histogram, num_buckets
FROM user_tab_columns
WHERE table_name = 'CUSTOMERS'
/
