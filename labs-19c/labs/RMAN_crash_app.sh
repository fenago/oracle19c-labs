#!/bin/sh
# use bash shell
#
#

export NLS_DATE_FORMAT='DD-MM-YYYY HH:MI:SS'
export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1
export ORACLE_SID=ORCL
PATH=$ORACLE_HOME/bin:$PATH; export PATH
$ORACLE_HOME/bin/sqlplus -s /nolog  <<EOF

CONNECT / as sysdba
ALTER SYSTEM SWITCH LOGFILE;
host rm /u02/app/oracle/oradata/ORCL/PDB1/tbs_app01.dbf
ALTER SYSTEM SWITCH LOGFILE;
EXIT
EOF
