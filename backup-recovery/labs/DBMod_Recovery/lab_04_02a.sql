-- DISCLAIMER:
-- This script is provided for educational purposes only. It is 
-- NOT supported by Oracle World Wide Technical Support.
-- The script has been tested and appears to work as intended.
-- You should always run new scripts on a test instance initially

-- Confirm test setup as SYSDBA

set echo on
COL TABLE_NAME      FORMAT A30
COL TABLESPACE_NAME FORMAT A15
COL OWNER           FORMAT A10

SELECT TABLE_NAME, TABLESPACE_NAME, STATUS
FROM DBA_TABLES
WHERE OWNER = 'BAR'
/
