#!/bin/bash

cd /home/oracle/solutions/Automatic_Gather_Stats

sqlplus / as sysdba @ags_cleanup.sql

