
set echo off

-- tables
select table_name, last_analyzed "analyze time", num_rows, blocks, avg_row_len
from user_tab_pending_stats
where table_name = '&1' and partition_name is null;

-- indexes
select index_name, last_analyzed "analyze time", num_rows, 
       leaf_blocks, distinct_keys
from user_ind_pending_stats
where table_name = '&1' and partition_name is null
order by index_name;

-- columns
select column_name, last_analyzed "analyze time", num_distinct, 
       num_nulls, density
from user_col_pending_stats
where table_name = '&1' and partition_name is null
order by column_name;

set echo on

