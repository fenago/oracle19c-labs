#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
# 

export ORACLE_SID=ORCL
export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

$ORACLE_HOME/bin/sqlplus "/ as sysdba" @$HOME/labs/admin/close_TDE.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @$HOME/labs/admin/cleanup_PDBs.sql
rm -rf /u02/app/oracle/admin/ORCL/tde_wallet
rm -rf /u01/app/oracle/admin/ORCL/wallet
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @$HOME/labs/admin/create_PDB1.sql
$ORACLE_HOME/bin/sqlplus "sys/Welcome_1@pdb1 as sysdba" @/home/oracle/labs/admin/hr_main.sql Welcome_1 users temp /tmp



