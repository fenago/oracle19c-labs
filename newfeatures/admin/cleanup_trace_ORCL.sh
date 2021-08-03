#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
# to cleanup archivelogs and trace files for CDBEM
#
export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
export ORACLE_SID=ORCL

PATH=$ORACLE_HOME/bin:$PATH; export PATH

rm /u01/app/oracle/diag/rdbms/orcl/ORCL/trace/*
$ORACLE_HOME/bin/rman target /  <<EOF
DELETE ARCHIVELOG ALL;
EXIT
EOF

