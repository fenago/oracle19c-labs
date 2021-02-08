
set echo off

-- tables
select table_name, last_analyzed analyze_time, num_rows, blocks, avg_row_len
from user_tables
where table_name = '&1';

-- indexes
select index_name, last_analyzed ANALYZE_TIME, num_rows, 
       leaf_blocks, distinct_keys
from user_indexes
where table_name = '&1'
order by index_name;

-- columns
select column_name, last_analyzed ANALYZE_TIME, num_distinct, 
       num_nulls, density
from user_tab_columns
where table_name = '&1'
order by column_name;

set echo on

