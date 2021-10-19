
-- ****************************************************************
-- Display BHR for Oracle & beyond
--
-- Copyright (c) 2014 Jerry Richard - All Rights reserved.
-- ****************************************************************
-- ****************************************************************
-- Display cache advice
--
-- Copyright (c) 2014 Jerry Richard - All Rights reserved.
-- ****************************************************************


column c1   heading 'Cache Size (m)'        format 999,999,999,999 
column c2   heading 'Buffers'               format 999,999,999 
column c3   heading 'Estd Phys|Read Factor' format 999.90 
column c4   heading 'Estd Phys| Reads'      format 999,999,999 

select
   size_for_estimate          c1, 
   buffers_for_estimate       c2,
   estd_physical_read_factor  c3, 
   estd_physical_reads        c4
from
   v$db_cache_advice
where
   name = 'DEFAULT'
and
   block_size  = (SELECT value FROM V$PARAMETER 
                   WHERE name = 'db_block_size')
and
   advice_status = 'ON';
