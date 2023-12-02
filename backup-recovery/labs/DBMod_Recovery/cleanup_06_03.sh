#!/bin/sh
#  -- DISCLAIMER:
#  -- This script is provided for educational purposes only. It is
#  -- NOT supported by Oracle World Wide Technical Support.
#  -- The script has been tested and appears to work as intended.
#  -- You should always run new scripts on a test instance initially.
#
# Written by Jim Spiller, Modified for 12c by MBillings
#
 echo $ORACLE_SID > /tmp/cleanup.log

rman target "'sys/fenago@orclpdb1 as sysdba'" > /tmp/cleanup.log 2>&1 <<EOF
delete NOPROMPT copy of tablespace bartbs;
exit;
EOF

sqlplus -S /nolog >> /tmp/cleanup.log 2>&1 <<EOF
connect / as sysdba

ALTER SESSION set container=orclpdb1;

ALTER PLUGGABLE DATABASE ORCLPDB1 OPEN;

-- CLEANUP from previous run
DROP USER bar CASCADE;
DROP TABLESPACE bartbs INCLUDING CONTENTS AND DATAFILES;
EXIT;
EOF
rm /tmp/control01.ctl /tmp/control02.ctl
echo "Cleanup done." >> /tmp/cleanup.log
