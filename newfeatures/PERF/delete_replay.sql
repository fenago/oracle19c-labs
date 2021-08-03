set echo on
exec DBMS_WORKLOAD_REPLAY.DELETE_REPLAY_INFO(replay_dir =>'OLTP')
exit