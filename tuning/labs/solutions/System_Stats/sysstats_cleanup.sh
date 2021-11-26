#!/bin/bash

cd /home/oracle/labs/solutions/System_Stats

sqlplus / as sysdba @sysstats_cleanup.sql

