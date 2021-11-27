#!/bin/bash

cd /home/oracle/labs/solutions/Application_Tracing

sqlplus / as sysdba @run_tracep6a.sql &

sqlplus / as sysdba @run_tracep6b.sql

