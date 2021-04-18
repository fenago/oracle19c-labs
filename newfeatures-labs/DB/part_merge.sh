#!/bin/sh
# use bash shell
#
#

export ORACLE_SID=fenagodb
export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH


cd $HOME/labs/DB

$ORACLE_HOME/bin/sqlplus "sys/fenago@pdb1 AS SYSDBA" @part_merge.sql
$ORACLE_HOME/bin/impdp sh/Welcome_1@PDB1 DIRECTORY=dp_dir DUMPFILE=exp_sh_pdb1.dmp remap_tablespace=USERS:SYSTEM TABLE_EXISTS_ACTION=replace
$ORACLE_HOME/bin/sqlplus "sys/fenago@pdb1 AS SYSDBA" @index_merge.sql
