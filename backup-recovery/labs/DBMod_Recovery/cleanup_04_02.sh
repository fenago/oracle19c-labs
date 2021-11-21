#!/bin/sh
#  -- DISCLAIMER:
#  -- This script is provided for educational purposes only. It is
#  -- NOT supported by Oracle World Wide Technical Support.
#  -- The script has been tested and appears to work as intended.
#  -- You should always run new scripts on a test instance initially.
#  -- Run as ORACLE OS user

#  -- rman target / > /tmp/cleanup.log 2>&1 <<EOF
#  -- delete NOPROMPT copy of tablespace bartbs;
#  -- exit;
#  -- EOF

ORACLE_SID=orclcdb
ORAENV_ASK='NO'
. oraenv >>/dev/null
ORAENV_ASK=''

sqlplus -S /nolog >> /tmp/cleanup.log 2>&1 <<EOF
connect sys/cloud_4U@orclpdb1 as sysdba

-- CLEANUP from previous run
DROP USER bar CASCADE;
DROP TABLESPACE bartbs INCLUDING CONTENTS AND DATAFILES;
EXIT;
EOF
rm -rf /u01/app/oracle/backup/test/*
echo 'Cleanup complete.' >> /tmp/cleanup.log
