#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
#

export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
export ORACLE_SID=ORCL
echo '' > /u01/app/oracle/product/19.3.0/dbhome_1/sqlplus/admin/glogin.sql
echo set pages 100 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set lines 68 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set tab off >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set long 20000 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL username FORMAT A24 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL pdb_name FORMAT A14 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL segment_name FORMAT A14 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL TABLESPACE_NAME FORMAT A24 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL action_name FORMAT A12 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL object_name FORMAT A12 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL name FORMAT A24 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL status FORMAT A14 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL display_name FORMAT A34 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL occupant_name FORMAT A34 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL con_id FORMAT 999 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL task_name FORMAT A34 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL grantee FORMAT A7 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL grantor FORMAT A7 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL owner FORMAT A7 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL privilege FORMAT A14 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL table_name FORMAT A10 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL sql_text FORMAT a57  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL username FORMAT a12  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL sid FORMAT 9999  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL key FORMAT 99999999999999  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col module FORMAT a18  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col operation FORMAT a18  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col plan_options FORMAT a14  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col plan_object_name FORMAT a16  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col id FORMAT 999  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col value FORMAT A12  >> $ORACLE_HOME/sqlplus/admin/glogin.sql

$ORACLE_HOME/bin/sqlplus "/ as sysdba" @/home/oracle/labs/PERF/defer_seg.sql