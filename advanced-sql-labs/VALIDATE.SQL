select height,blocks,name,distinct_keys,most_repeated_key MRP,
PCT_used from sys.index_stats where name = 'DEPTINDX'
/
