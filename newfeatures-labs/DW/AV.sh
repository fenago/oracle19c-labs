#!/bin/sh
# use bash shell
#
#

export ORACLE_SID=ORCL
export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

cd $HOME/labs/DW

$ORACLE_HOME/bin/sqlplus "/ as sysdba" @$HOME/labs/admin/create_PDB1.sql
$ORACLE_HOME/bin/sqlplus "system/Welcome_1@PDB1" @create_AV_tables.sql
$ORACLE_HOME/bin/sqlldr av/Welcome_1@PDB1 table=geography_dim
$ORACLE_HOME/bin/sqlldr av/Welcome_1@PDB1 table=product_dim
$ORACLE_HOME/bin/sqlldr av/Welcome_1@PDB1 table=time_dim
$ORACLE_HOME/bin/sqlldr av/Welcome_1@PDB1 table=sales_fact
$ORACLE_HOME/bin/sqlplus "av/Welcome_1@PDB1" @create_attr_hierarchies.sql
$ORACLE_HOME/bin/sqlplus "av/Welcome_1@PDB1" @create_analytic_view.sql

