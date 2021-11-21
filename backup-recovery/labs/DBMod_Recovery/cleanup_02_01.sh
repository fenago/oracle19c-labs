#!/bin/sh
#  -- DISCLAIMER:
#  -- This script is provided for educational purposes only. It is
#  -- NOT supported by Oracle World Wide Technical Support.
#  -- The script has been tested and appears to work as intended.
#  -- You should always run new scripts on a test instance initially.
#
# cleanup

# rman target / > /tmp/cleanup.log 2>&1 <<EOF
 rman target "'sys/cloud_4U@orclpdb1 as sysdba'" > /tmp/cleanup.log 2>&1 <<EOF
delete NOPROMPT copy of tablespace bar91tbs;
exit;
EOF

sqlplus sys/cloud_4U@orclpdb1 as sysdba >>/tmp/cleanup.log 2>&1 <<EOF
show con_name
-- CLEANUP from previous run
DROP USER bar91 CASCADE;
DROP TABLESPACE bar91tbs INCLUDING CONTENTS AND DATAFILES;
EXIT;
EOF
echo "Cleanup complete." >> /tmp/cleanup.log
