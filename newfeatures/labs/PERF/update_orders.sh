#!/bin/bash
#
# wkld_sess.sh
# this is a session driver that will run a SQL script repeatedly
# with a  delay between runs
#
#Usage: update_orders.sh <NumberOfRcords> <delayInSeconds> <serviceName>
#
#set -x

file='./runload'
delay=$2

param1=$1

service=$3

while [[ -f $file ]]

do

sqlplus -S /nolog <<-EOF
        connect oe/Welcome_1@$service
		set echo on
	@update_orders $param1
	EOF

sleep $delay

done 

