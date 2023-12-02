#!/bin/sh
# use bash shell
#
# Written by: 
#

export NLS_DATE_FORMAT='DD-MM-YYYY HH:MI:SS'

export ORACLE_SID=orclcdb
ORAENV_ASK='NO'
. oraenv > /dev/null
ORAENV_ASK=''

$ORACLE_HOME/bin/sqlplus -s /nolog  <<EOF

CONNECT / as sysdba
ALTER SYSTEM SWITCH LOGFILE;
host rm /u01/app/oracle/oradata/ORCLCDB/orclpdb1/tbs_app01.dbf
ALTER SYSTEM SWITCH LOGFILE;
EXIT
EOF
