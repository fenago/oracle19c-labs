-- DISCLAIMER:
-- This script is provided for educational purposes only. It is 
-- NOT supported by Oracle World Wide Technical Support.
-- The script has been tested and appears to work as intended.
-- You should always run new scripts on a test instance initially.

connect sys/cloud_4U@orclpdb1 as sysdba

-- Find the file and block numbers

SELECT DISTINCT 
   MIN(DBMS_ROWID.ROWID_RELATIVE_FNO(rowid)) as FILE_NO,
   MIN(DBMS_ROWID.ROWID_BLOCK_NUMBER(rowid)) as BLOCK_NO
 FROM bc.bccopy;

ALTER SYSTEM FLUSH BUFFER_CACHE;
-- corrupt the first 2 blocks
PROMPT 'Enter Block number when prompted'

! ./bc_corrupt.sh "/u01/app/oracle/oradata/ORCLCDB/orclpdb1/bctbs01.dbf" &block_no 8196

SELECT * from bc.bccopy;

exit;
