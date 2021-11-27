
-- ****************************************************************
-- Display hot blocks in recycle pool
--
-- Copyright (c) 2014 Jerry Richard - All Rights reserved.
-- ****************************************************************

set lines 80;
set pages 999;


column avg_touches format 999
column myname heading 'Name' format a30
column mytype heading 'Type' format a10
column buffers format 999,999

SELECT  
   object_type  mytype,
   object_name    myname,
   blocks,
   COUNT(1) buffers,
   100*(COUNT(1)/totsize) pct_cache
FROM 
   sys.x$bh    a,
   dba_objects b,
   dba_segments s,
   (select value totsize from v$parameter 
         where name = 'db_cache_size')
WHERE
   a.obj = b.object_id
and
   tch=1  -- This line only works in 8.1.6 and above
and
   b.object_name = s.segment_name
and
   b.owner not in ('SYS','SYSTEM')
GROUP BY 
   object_type,
   object_name,
   blocks,
   totsize
HAVING
   100*(COUNT(1)/totsize) > 5
;
