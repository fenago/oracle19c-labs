#!/bin/sh
#  -- DISCLAIMER:
#  -- This script is provided for educational purposes only. It is
#  -- NOT supported by Oracle World Wide Technical Support.
#  -- The script has been tested and appears to work as intended.
#  -- You should always run new scripts on a test instance initially.
#
# Written by Jim Spiller, Modified for 12c by MBillings

ORACLE_SID=orclcdb
ORAENV_ASK='NO'
. oraenv >>/dev/null
ORAENV_ASK=''

echo $ORACLE_SID > /tmp/break.log

# Shutdown the database abort
#srvctl stop database -d orcl -o abort

# Lines added by DKK for non-ASM database
sqlplus / as sysdba >> /tmp/break.log << EOF
shutdown abort
exit
EOF

sleep 10
pgrep -lf pmon >>/tmp/break.log

# Lines added by DKK for non-ASM database
# rm -f /u01/app/oracle/fast_recovery_area/ORCLCDB/control02.ctl >> /tmp/break.log
# Replaced above rm command with the following conditional rm, to account for possibility
# that the control file might not exist in this location. Jeff Ferreira
if [ -e /u01/app/oracle/fast_recovery_area/ORCLCDB/control02.ctl ]
then
	rm -f /u01/app/oracle/fast_recovery_area/ORCLCDB/control02.ctl >> /tmp/break.log
fi
echo 'Issue created.'  >> /tmp/break.log

exit
