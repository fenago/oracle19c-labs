#!/bin/sh
# use bash shell
#
#

export ORACLE_SID=fenagodb
export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

cd $HOME/labs/SEC
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @delete_replay.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @delete_rat.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @close_keystore2.sql

rm -rf /home/oracle/replay
rm -rf /tmp/replay_encrypt_cwallet

