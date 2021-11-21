#!/bin/sh
# use bash shell
#
#

export ORACLE_SID=fenagodb
export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

mkdir -p /u02/app/oracle/oradata/ORCL/pdb1

cd $HOME/labs/RMAN
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @$HOME/labs/admin/create_PDB1.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @close_keystore.sql
rm -rf /u01/app/oracle/admin/ORCL/tde_keystore
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @open_keystore.sql
$ORACLE_HOME/bin/sqlplus "sys/fenago@PDB1 as sysdba" @set_key.sql
$ORACLE_HOME/bin/sqlplus "system/fenago@PDB1" @hr_main.sql Welcome_1 users temp /tmp

