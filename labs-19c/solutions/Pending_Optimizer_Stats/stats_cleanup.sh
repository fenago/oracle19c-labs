#!/bin/bash

cd /home/oracle/solutions/Pending_Optimizer_Stats

sqlplus / as sysdba <<FIN!

set echo on

drop user stats cascade;

FIN!

