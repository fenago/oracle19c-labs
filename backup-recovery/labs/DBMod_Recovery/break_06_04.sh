#!/bin/sh
#  -- DISCLAIMER:
#  -- This script is provided for educational purposes only. It is
#  -- NOT supported by Oracle World Wide Technical Support.
#  -- The script has been tested and appears to work as intended.
#  -- You should always run new scripts on a test instance initially.
#
# Written by Jim Spiller, Modified for 12c by MBillings

LABS=$HOME/labs/DBMod_Recovery

ORACLE_SID=orclcdb
ORAENV_ASK='NO'
. oraenv >>/dev/null
ORAENV_ASK=''

echo $ORACLE_SID > /tmp/break.log

echo 'Delete this password file:'  >> /tmp/break.log
ls $ORACLE_HOME/dbs/orapworclcdb >> /tmp/break.log
cp $ORACLE_HOME/dbs/orapworclcdb /tmp
rm $ORACLE_HOME/dbs/orapworclcdb
echo 'Issue created.'  >> /tmp/break.log
exit
