#!/bin/sh
#  -- DISCLAIMER:
#  -- This script is provided for educational purposes only. It is NOT
#  -- supported by Oracle World Wide Technical Support.
#  -- The script has been tested and appears to work as intended.
#  -- You should always run new scripts on a test instance initially.
#
#-- Cleanup_09_03.sh: cleanup backup copy, tablespace, and user

export ORACLE_SID=orclcdb    > /tmp/break.log
chmod 777 /tmp/break.log
ORAENV_ASK='NO'
. oraenv >>/dev/null
ORAENV_ASK=''
echo $ORACLE_SID >> /tmp/break.log

export ORACLE_PDB_SID=ORCLPDB1
rman target "'sys/fenago as sysdba'" > /tmp/cleanup.log 2>&1 <<EOF
delete NOPROMPT copy of tablespace bctbs;
exit;
EOF

sqlplus -S /nolog >> /tmp/cleanup.log 2>&1 <<EOF
connect / as sysdba

ALTER SESSION set container=orclpdb1;
DROP USER bc CASCADE;
DROP TABLESPACE bctbs INCLUDING CONTENTS AND DATAFILES;
EXIT;
EOF

# Shutdown the database 
echo "Shutdown $ORACLE_SID database " >> /tmp/break.log

sqlplus / as sysdba >> /tmp/break.log <<EOF
shutdown immediate
startup
exit
EOF

echo "End of cleanup_05_01.sh" >> /tmp/cleanup.log

