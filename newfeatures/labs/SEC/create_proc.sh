#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
#

export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
export ORACLE_SID=ORCL
PATH=$ORACLE_HOME/bin:$PATH; export PATH

cd $HOME/labs/SEC
$ORACLE_HOME/bin/sqlplus "sys/Welcome_1@pdb1 as sysdba" @$HOME/labs/admin/hr_main.sql Welcome_1 users temp /tmp
$ORACLE_HOME/bin/sqlplus "hr/Welcome_1@PDB1" @create_proc.sql
