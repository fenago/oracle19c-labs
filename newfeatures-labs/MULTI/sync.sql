set echo on
CONNECT sys/fenago@operations AS SYSDBA
ALTER PLUGGABLE DATABASE APPLICATION hr_app SYNC;
CONNECT sys/fenago@sales AS SYSDBA
ALTER PLUGGABLE DATABASE APPLICATION hr_app SYNC;
exit
