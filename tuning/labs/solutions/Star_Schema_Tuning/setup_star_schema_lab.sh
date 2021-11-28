#!/bin/bash

cd /home/oracle/labs/solutions/Star_Schema_Tuning

sqlplus / as sysdba <<FIN!

set echo on

grant dba to sh;

alter user sh identified by sh account unlock;

FIN!

