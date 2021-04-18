#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
# 

export ORACLE_SID=ORCL
export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

mkdir -p /u02/app/oracle/oradata/ORCL/pdb1

cd $HOME/labs/SEC
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @create_PDB1.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @close_keystore.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @shutdown.sql
rm -rf /u01/app/oracle/admin/ORCL/tde_keystore
rm -rf /home/oracle/replay
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @startup.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @open_keystore2.sql

cd $HOME/labs/RMAN
$ORACLE_HOME/bin/sqlplus "system/Welcome_1@PDB1" @hr_main.sql Welcome_1 users temp /tmp

$ORACLE_HOME/bin/rman target / <<EOF
 CONFIGURE ARCHIVELOG DELETION POLICY TO none;
exit
EOF

