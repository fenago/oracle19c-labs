#!/bin/sh
#  -- DISCLAIMER:
#  -- This script is provided for educational purposes only. It is
#  -- NOT supported by Oracle World Wide Technical Support.
#  -- The script has been tested and appears to work as intended.
#  -- You should always run new scripts on a test instance initially.
#  -- Run as ORACLE OS user

rman target sys/fenago@orclpdb1 > /home/oracle/labs/DBMod_Flashback/cleanup.log 2>&1 <<EOF
delete NOPROMPT copy of tablespace bartbs;
exit;
EOF

sqlplus -S /nolog >> /home/oracle/labs/DBMod_Flashback/cleanup.log 2>&1 <<EOF
connect sys/fenago@orclpdb1 as sysdba

-- CLEANUP from previous run
DROP USER bar CASCADE;
DROP TABLESPACE bartbs INCLUDING CONTENTS AND DATAFILES;
PURGE DBA_RECYCLEBIN;
EXIT;
EOF
