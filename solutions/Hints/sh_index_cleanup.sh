#!/bin/bash

cd /home/oracle/solutions/SQL_Access_Advisor/sh

cp * $ORACLE_HOME/demo/schema/sales_history

sqlplus / as sysdba <<FIN!

SET ECHO ON
SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 8000
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100
SET LONG 1000

CONNECT / AS SYSDBA

alter user sh identified by sh account unlock;

@sh_main sh example temp oracle_4U /u01/app/oracle/product/11.2.0/dbhome_1/demo/schema/sales_history/ /home/oracle/ v3

exit;

FIN!

