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
$ORACLE_HOME/bin/sqlplus "c##sec_admin/Welcome_1@PDB1" @$HOME/labs/SEC/disable_DV.sql
$ORACLE_HOME/bin/sqlplus "c##sec_admin/Welcome_1@ORCL" @$HOME/labs/SEC/disable_DV.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @$HOME/labs/SEC/shutdown.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @$HOME/labs/SEC/startup.sql
$ORACLE_HOME/bin/sqlplus "sys/Welcome_1@PDB1 AS SYSDBA" @$HOME/labs/SEC/drop_audit_pol.sql
