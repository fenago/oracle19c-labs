
-- ****************************************************************
-- Display hot buffer detail
--
-- Copyright (c) 2014 Jerry Richard - All Rights reserved.
-- ****************************************************************
--
-- You MUST connect as SYS to run this script
connect sys/manager;

set lines 80;
set pages 999;

column avg_touches           format 999
column myname heading 'Name' format a30
column mytype heading 'Type' format a10
column buffers               format 999,999

SELECT  
   object_type  mytype,
   object_name    myname,
   blocks,
   COUNT(1) buffers,
   AVG(tch) avg_touches
FROM 
   sys.x$bh    a,
   dba_objects b,
   dba_segments s
WHERE
   a.obj = b.object_id
and
   b.object_name = s.segment_name
and
   b.owner not in ('SYS','SYSTEM')
GROUP BY 
   object_name,
   object_type,
   blocks,
   obj
HAVING 
   AVG(tch) > 5
AND 
   COUNT(1) > 20;

