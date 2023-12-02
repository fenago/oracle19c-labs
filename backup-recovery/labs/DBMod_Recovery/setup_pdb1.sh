#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
#

export ORACLE_SID=orclcdb
ORAENV_ASK='NO'
. oraenv > /dev/null
ORAENV_ASK=''

mkdir -p /u01/app/oracle/oradata/ORCLCDB/orclpdb1
$ORACLE_HOME/bin/sqlplus -s /nolog  <<EOF
conn sys/fenago as sysdba 
ALTER SESSION set container=orclpdb1;
drop tablespace TBS_APP including contents and datafiles;
create tablespace TBS_APP datafile '/u01/app/oracle/oradata/ORCLCDB/orclpdb1/tbs_app01.dbf' size 800M;
drop user odr cascade;
create user odr identified by fenago default tablespace tbs_app;
grant create session, dba to odr;

create table odr.orders (
 ORDER_ID	  NUMBER(12),
 ORDER_DATE	  TIMESTAMP(6) WITH LOCAL TIME ZONE, 
 ORDER_MODE   VARCHAR2(8),
 CUSTOMER_ID  NUMBER(6),
 ORDER_STATUS NUMBER(2),
 ORDER_TOTAL  NUMBER(8,2),
 SALES_REP_ID NUMBER(6),
 PROMOTION_ID NUMBER(6)
 );
 
create table odr.order_items (
 ORDER_ID     NUMBER(12),
 LINE_ITEM_ID NUMBER(3),
 PRODUCT_ID   NUMBER(6),
 UNIT_PRICE   NUMBER(8,2),
 QUANTITY     NUMBER(8)
 );
 
@/home/oracle/labs/DBMod_Recovery/PERF_script_pdb1_orders.sql
@/home/oracle/labs/DBMod_Recovery/PERF_script_pdb1_order_items.sql

EXIT
EOF
