set echo on

set linesize 200 pagesize 1000

SELECT index_name name,num_rows,
       last_analyzed,distinct_keys,leaf_blocks,
       avg_leaf_blocks_per_key,join_index
FROM user_indexes
WHERE table_name = 'EMP';      

