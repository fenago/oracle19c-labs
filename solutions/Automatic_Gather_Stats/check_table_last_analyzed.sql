set echo on

set linesize 200 pagesize 1000

SELECT last_analyzed,sample_size,monitoring,num_rows,blocks,table_name
FROM user_tables
WHERE table_name = 'EMP';

