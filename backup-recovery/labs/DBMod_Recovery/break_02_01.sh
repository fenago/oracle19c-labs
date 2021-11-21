#!/bin/sh
#  -- DISCLAIMER:
#  -- This script is provided for educational purposes only. It is NOT
#  -- supported by Oracle World Wide Technical Support.
#  -- The script has been tested and appears to work as intended.
#  -- You should always run new scripts on a test instance initially.
#
# Shutdown the database abort
export ORACLE_SID=orclcdb    > /tmp/break.log
chmod 777 /tmp/break.log
ORAENV_ASK='NO'
. oraenv >>/dev/null
ORAENV_ASK=''
echo $ORACLE_SID >> /tmp/break.log
echo "Abort $ORACLE_SID database " >> /tmp/break.log

#srvctl stop database -d orcl -o abort
# replace svrctl with sqlplus shutdown abort
sqlplus / as sysdba >> /tmp/break.log <<EOF
shutdown abort
exit
EOF
sleep 30

rm /u01/app/oracle/oradata/ORCLCDB/orclpdb1/bar91tbs01.dbf
echo 'Issue created.'  >> /tmp/break.log
exit
