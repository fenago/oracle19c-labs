#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
#

export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1

echo '' > /u01/app/oracle/product/19.3.0/dbhome_1/sqlplus/admin/glogin.sql
echo set pages 100 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set lines 68 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set tab off >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL username FORMAT A24 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL pdb_name FORMAT A14 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL segment_name FORMAT A14 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL TABLESPACE_NAME FORMAT A24 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL action_name FORMAT A12 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL object_name FORMAT A12 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL name FORMAT A24 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL status FORMAT A14 >> $ORACLE_HOME/sqlplus/admin/glogin.sql