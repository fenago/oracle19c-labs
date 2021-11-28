#!/bin/bash

cd /home/oracle/labs/solutions/Common_Mistakes


date

sqlplus -s cm/cm @select2.sql >> /tmp/better_connect.log 2>&1

date

