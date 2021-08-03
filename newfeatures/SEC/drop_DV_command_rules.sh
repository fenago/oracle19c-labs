#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
#

export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
export ORACLE_SID=ORCL
PATH=$ORACLE_HOME/bin:$PATH; export PATH
cd $HOME/labs/SEC
$ORACLE_HOME/bin/sqlplus "c##sec_admin/Welcome_1@PDB1" @$HOME/labs/SEC/drop_DV_command_rule.sql
