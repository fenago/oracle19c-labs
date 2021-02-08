select type,status,name,object_no,
row_count,row_size_avg
from v$result_cache_objects
order by 1;

