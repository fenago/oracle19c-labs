#!/bin/sh
# use bash shell
#
#

export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1

echo '' > /u01/app/oracle/product/19.3.0/dbhome_1/sqlplus/admin/glogin.sql
echo set pages 100 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set lines 68 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set tab off >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL owner FORMAT A5  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL TABLE_NAME FORMAT A15  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL PARTITION_NAME FORMAT A14  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL SEGMENT_NAME FORMAT A12  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL pool FORMAT A12  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL populate_status FORMAT A16  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL NAME FORMAT A14  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL OBJECT_NAME FORMAT A14  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL TABLE_NAME FORMAT A14  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL joingroup_owner FORMAT A16  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL joingroup_name FORMAT A16  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL table_owner FORMAT A12  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL column_name FORMAT A12  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL flags FORMAT A6  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL col# FORMAT 9999  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL expression_text FORMAT A44  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col SUM_BASE_PRICE FORMAT 999999999999999 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col SUM_DISC_PRICE FORMAT 999999999999999 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col charge FORMAT 9999999999999999 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col revenue FORMAT 9999999999999999 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL SELECTED_FOR_EXECUTION format A26 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL SQL_EXPRESSION FORMAT A50  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL DISPLAY_NAME FORMAT A40  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL OWNER FORMAT a6  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL TABLE_NAME FORMAT a9  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL COLUMN_NAME FORMAT a23  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
