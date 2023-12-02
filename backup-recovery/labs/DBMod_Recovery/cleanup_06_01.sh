#!/bin/sh
#  -- DISCLAIMER:
#  -- This script is provided for educational purposes only. It is
#  -- NOT supported by Oracle World Wide Technical Support.
#  -- The script has been tested and appears to work as intended.
#  -- You should always run new scripts on a test instance initially.
#
# Cleanup of practice
echo $ORACLE_SID > /tmp/cleanup.log

export ORACLE_PDB_SID=ORCLPDB1
rman target "'sys/fenago as sysdba'" > /tmp/cleanup.log 2>&1 <<EOF
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
echo "Cleanup done." >> /tmp/cleanup.log
