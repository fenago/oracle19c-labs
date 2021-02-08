#!/bin/bash

cd /home/oracle/solutions/SQL_Access_Advisor/sh

cp * $ORACLE_HOME/demo/schema/sales_history

sqlplus / as sysdba @/home/oracle/solutions/Access_Paths/ap_cleanup.sql

