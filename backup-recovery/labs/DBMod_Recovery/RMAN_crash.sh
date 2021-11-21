#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
#
# Updated by D. Keesling, April 2018
#
# Modified by J. Spiller, Jun 2019

export NLS_DATE_FORMAT='DD-MM-YYYY HH:MI:SS'
export ORACLE_SID=orclcdb
ORAENV_ASK='NO'
. oraenv >/dev/null
ORAENV_ASK=''

$ORACLE_HOME/bin/sqlplus -s /nolog  <<EOF

CONNECT / as sysdba
ALTER SYSTEM SWITCH LOGFILE;
host rm /u01/app/oracle/oradata/ORCLCDB/system01.dbf
ALTER SYSTEM SWITCH LOGFILE;
Select username from dba_users where username = '1';
EXIT
EOF

