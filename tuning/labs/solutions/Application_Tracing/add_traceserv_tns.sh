#!/bin/ksh

y=`hostname`

DBNAME=orcl

sed 's/NODE/'$y'/' /home/oracle/labs/solutions/Application_Tracing/wrong_tnstraceserv.ora > /home/oracle/labs/solutions/Application_Tracing/tnstraceserv.ora

cp $ORACLE_HOME/network/admin/tnsnames.ora $ORACLE_HOME/network/admin/tnsnames.ora.bak1
cat /home/oracle/labs/solutions/Application_Tracing/tnstraceserv.ora >> $ORACLE_HOME/network/admin/tnsnames.ora
