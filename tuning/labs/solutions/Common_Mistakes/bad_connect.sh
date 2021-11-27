#!/bin/bash

cd /home/oracle/labs/solutions/Common_Mistakes


STREAM_NUM=0
MAX_STREAM=500

date

while [ $STREAM_NUM -lt $MAX_STREAM ]; do

  # one more
  let STREAM_NUM="STREAM_NUM+1"

  # start one more stream
  sqlplus -s cm/cm @select.sql >> /tmp/bad_connect.log 2>&1

done

date

