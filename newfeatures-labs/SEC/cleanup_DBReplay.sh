#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
# 

export ORACLE_SID=ORCL
export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1
PATH=$ORACLE_HOME/bin:$PATH; export PATH

cd $HOME/labs/SEC
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @delete_replay.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @delete_rat.sql
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @close_keystore2.sql

rm -rf /home/oracle/replay
rm -rf /tmp/replay_encrypt_cwallet

