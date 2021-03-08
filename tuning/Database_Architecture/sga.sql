set echo on

select * from v$sgainfo;

col component format a30

select component,current_size,min_size,max_size from v$memory_dynamic_components;

exit;
