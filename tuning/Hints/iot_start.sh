#!/bin/sh

# Flush buffer cache and shared pool

sqlplus / as sysdba <<-EOF
set echo on
alter system flush shared_pool;
alter system flush buffer_cache;
exit
EOF
