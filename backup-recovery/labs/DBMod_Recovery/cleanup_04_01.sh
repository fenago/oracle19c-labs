#!/bin/bash
#  -- DISCLAIMER:
#  -- This script is provided for educational purposes only. It is
#  -- NOT supported by Oracle World Wide Technical Support.
#  -- The script has been tested and appears to work as intended.
#  -- You should always run new scripts on a test instance initially.
#
#-- Cleanup the tablespace, and user 

rm -f  /u01/app/oracle/backup/*bartest* > /tmp/cleanup.log

sqlplus /nolog >> /tmp/cleanup.log <<EOF
connect / as sysdba

ALTER SESSION set container=orclpdb1;

-- CLEANUP from previous run
DROP USER bar CASCADE;
DROP TABLESPACE bartbs INCLUDING CONTENTS AND DATAFILES;
EXIT
EOF

echo 'Cleanup complete.' >> /tmp/cleanup.log
