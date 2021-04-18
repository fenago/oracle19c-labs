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
echo COL username FORMAT A22 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL DEPARTMENT_NAME FORMAT A20 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col sid format 999 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo  col SERIAL#  format 999999  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo  col OWNER format A5  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo  col TABLE_NAME format A13  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo  col TABLESPACE_NAME FORMAT A15  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo  col duration format A11  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo  col SAVE_POINT_NUM format 999  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo  COL PARTITION_NAME format A30  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo  COL HIGH_VALUE format A20  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo  COL owner FORMAT A6   >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo  col type format A5    >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo  col autolist format A8  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo  col interval format A15   >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo  col interval_subpartition format A12   >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo  col autolist_subpartition format A12    >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo  COL partition_NAME FORMAT A14  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo  COL subpartition_NAME FORMAT A13  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo  COL high_value FORMAT A14  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo  col channel format A7  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo  col state format A7  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo  col index_name format A20  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
