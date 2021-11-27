#!/bin/bash

cd /home/oracle/labs/solutions/SQL_Access_Advisor/sh

cp * $ORACLE_HOME/demo/schema/sales_history

sqlplus / as sysdba @/home/oracle/labs/solutions/Access_Paths/ap_cleanup.sql

