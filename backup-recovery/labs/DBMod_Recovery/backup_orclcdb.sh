#!/bin/sh
#  -- DISCLAIMER:
#  -- This script is provided for educational purposes only. It is
#  -- NOT supported by Oracle World Wide Technical Support.
#  -- The script has been tested and appears to work as intended.
#  -- You should always run new scripts on a test instance initially.
#
# backup_orclcdb.sh.sh
cd $HOME/labs/DBMod_Recovery

export ORACLE_SID=orclcdb
ORAENV_ASK='NO'
. oraenv >> /dev/null
ORAENV_ASK=''

rman target "'/ as sysbackup'" catalog rco/fenago@rcatpdb  > /tmp/backup.log 2>&1 <<EOF
BACKUP DATABASE PLUS ARCHIVELOG delete input;
exit;
EOF
echo "End of backup_orclcdb.sh"  >> /tmp/backup.log
exit
