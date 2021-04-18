#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
# 

export ORACLE_SID=ORCL
export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH


cd $HOME/labs/DB

$ORACLE_HOME/bin/sqlplus "sys/Welcome_1@pdb1 AS SYSDBA" @part_merge.sql
$ORACLE_HOME/bin/impdp sh/Welcome_1@PDB1 DIRECTORY=dp_dir DUMPFILE=exp_sh_pdb1.dmp remap_tablespace=USERS:SYSTEM TABLE_EXISTS_ACTION=replace
$ORACLE_HOME/bin/sqlplus "sys/Welcome_1@pdb1 AS SYSDBA" @index_merge.sql
