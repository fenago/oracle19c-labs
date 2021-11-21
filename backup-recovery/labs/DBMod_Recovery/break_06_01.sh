#!/bin/sh
#  -- DISCLAIMER:
#  -- This script is provided for educational purposes only. It is
#  -- NOT supported by Oracle World Wide Technical Support.
#  -- The script has been tested and appears to work as intended.
#  -- You should always run new scripts on a test instance initially.
#
# Written by Jim Spiller, Modified for 12c by MBillings, 18c by D. Keesling

LABS=$HOME/labs/DBMod_Recovery

ORACLE_SID=orclcdb
ORAENV_ASK='NO'
. oraenv >>/dev/null
ORAENV_ASK=''

echo "ORACLE_SID is $ORACLE_SID" > /tmp/break.log
# Shutdown the database abort
#srvctl stop database -d orcl -o abort
# Lines added by DKK for non-ASM database
sqlplus / as sysdba >> /tmp/break.log << EOF
shutdown abort
exit
EOF

sleep 10
echo 'orclcdb should not be listed:'   >>/tmp/break.log
pgrep -lf pmon >>/tmp/break.log

# delete the SPFILE from ASM
# Lines commented out for non-ASM database
#su - grid -c $LABS/rm_asm_spfile.sh >> /tmp/break.log

# Lines added by DKK for non-ASM database
# Lines modified by Jeff Ferreira to make removal of initorcl.ora conditional
# on its existence.
cp $ORACLE_HOME/dbs/spfileorclcdb.ora /tmp/spfileorclcdb.ora
rm -f $ORACLE_HOME/dbs/spfileorclcdb.ora >> /tmp/break.log
if [ -e $ORACLE_HOME/dbs/initorclcdb.ora ]
then
	cp $ORACLE_HOME/dbs/initorclcdb.ora /tmp/initorclcdb.ora
	rm -f $ORACLE_HOME/dbs/initorclcdb.ora >> /tmp/break.log
fi
echo 'Issue created.'  >> /tmp/break.log

exit
