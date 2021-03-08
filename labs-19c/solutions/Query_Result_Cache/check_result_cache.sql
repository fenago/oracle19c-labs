SELECT type, status, name, object_no, row_count,row_size_avg
FROM v$result_cache_objects
ORDER BY 1;
