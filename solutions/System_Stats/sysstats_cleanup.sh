#!/bin/bash

cd /home/oracle/solutions/System_Stats

sqlplus / as sysdba @sysstats_cleanup.sql

