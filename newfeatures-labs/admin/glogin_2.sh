#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
#

export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1

echo '' > /u01/app/oracle/product/18.0.0/dbhome_1/sqlplus/admin/glogin.sql
echo set pages 100 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set lines 68 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set long 20000 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set tab off >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL owner FORMAT A14 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL table_name FORMAT A21 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL column_name FORMAT A24 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL object_name FORMAT A30 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL username FORMAT A35 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col PROPERTY_NAME format A40 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col PROPERTY_VALUE format A20  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col username FORMAT A22 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col CDB$NAME FORMAT A8 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col CON$NAME FORMAT A8  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col pdb_name format A8  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col "IS_PROXY_PDB" format A12  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col name format A12  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col "MEMBER_CDB" format A12  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col con_name FORMAT A8 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col snapshot_name FORMAT A25 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col snapshot_scn FORMAT 99999999999 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col snapshot_time FORMAT 9999999999 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col department_name FORMAT A20 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL PROFILE_NAME format A17 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL RULE format A24 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL CLAUSE format A18 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL STATUS format A7 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL partition_name format A14 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL high_value format A30 >> $ORACLE_HOME/sqlplus/admin/glogin.sql

$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/admin/snapshot.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/SEC/shutdown.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/SEC/startup.sql
