#!/bin/sh
# use bash shell
#
#

export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1

echo '' > /u01/app/oracle/product/18.0.0/dbhome_1/sqlplus/admin/glogin.sql
echo set pages 100 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set lines 68 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set tab off >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL owner FORMAT A14 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL table_name FORMAT A21 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL column_name FORMAT A24 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL object_name FORMAT A30 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL username FORMAT A35 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL segment_name FORMAT A12 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL display_name FORMAT A42 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL time FORMAT A6 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL GEOGRAPHY  FORMAT A16 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL member_name FORMAT A8 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL YEAR_NAME FORMAT A8 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL QUARTER_NAME FORMAT A8 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col MONTH_NAME FORMAT A8 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL empno FORMAT 99999 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL sal FORMAT 99999 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL mgr FORMAT 99999 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL comm FORMAT 99999 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
