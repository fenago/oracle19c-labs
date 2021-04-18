#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
#

export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1

echo '' > /u01/app/oracle/product/18.0.0/dbhome_1/sqlplus/admin/glogin.sql
echo set pages 100 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set lines 68 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set tab off >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL owner FORMAT A14 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL username FORMAT A22 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL status FORMAT A18 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL WRL_PARAMETER format A44  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL key_id FORMAT A52 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL activating_pdbname  FORMAT A20 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL DEPARTMENT_NAME FORMAT A20 >> $ORACLE_HOME/sqlplus/admin/glogin.sql            
