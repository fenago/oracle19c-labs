alter database commit to switchover to standby
/
shutdown immediate;
startup mount;

alter database recover managed standby database disconnect from session
/
