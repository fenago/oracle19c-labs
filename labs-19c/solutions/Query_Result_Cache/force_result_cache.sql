set echo on

show parameter result_cache_mode

select type,status,name,object_no,row_count,row_size_avg from v$result_cache_objects order by 1;

alter session set result_cache_mode=force;

