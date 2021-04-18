#!/bin/sh
# use bash shell
#
#

export ORACLE_SID=ORCL
export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

cd $HOME/labs/DW

$ORACLE_HOME/bin/sqlplus "/ as sysdba" @$HOME/labs/admin/create_PDB1.sql
$ORACLE_HOME/bin/sqlplus "system/Welcome_1@pdb1" @create_SCOTT.sql
$ORACLE_HOME/bin/sqlplus "system/Welcome_1@pdb1" @create_directory.sql
$ORACLE_HOME/bin/sqlplus "scott/Welcome_1@pdb1" @create_SCOTT_tables.sql
