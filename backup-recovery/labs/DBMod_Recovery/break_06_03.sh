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

LABS=$HOME/labs/DBMod_recovery

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

#echo 'delete controlfiles from +FRA and +DATA in ASM' >> /tmp/break.log
#su - grid -c $LABS/rm_asm_2_ctl.sh
cp /u01/app/oracle/oradata/ORCLCDB/control01.ctl /tmp
rm -f /u01/app/oracle/oradata/ORCLCDB/control01.ctl >> /tmp/break.log
# Moved commands to remove control01.ctl to the two lines above, and 
# made removal of control02.ctl conditional for two possible locations, below. Jeff Ferreira
if [ -e /u01/app/oracle/fast_recovery_area/ORCLCDB/control02.ctl ]
then
	cp /u01/app/oracle/fast_recovery_area/ORCLCDB/control02.ctl /tmp
	rm -f /u01/app/oracle/fast_recovery_area/ORCLCDB/control02.ctl >> /tmp/break.log
echo 'Issue created.'  >> /tmp/break.log
fi

exit
