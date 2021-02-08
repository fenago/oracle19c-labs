#!/bin/bash

cd /home/oracle/solutions/SQL_Tuning_Advisor


PIDLST=`cat /tmp/dina_pids`

#
# Kill all these processes
#
for PID in $PIDLST; do
  echo "Killing stream with pid=$PID"
  sqlplus / as sysdba @kill_dina.sql $PID >> /tmp/stop_dina.log 2>&1
  sqlplus /nolog @/tmp/drop_dina.sql >> /tmp/stop_dina.log 2>&1
  kill -9 $PID >> /tmp/stop_dina.log 2>&1
done

