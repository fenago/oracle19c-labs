
-- ****************************************************************
-- Display correct size for the KEEP pool
--
-- Copyright (c) 2014 Jerry Richard - All Rights reserved.
-- ****************************************************************

prompt The following will size your init.ora KEEP POOL, 
prompt based on Oracle KEEP Pool assignment values
prompt

select
'BUFFER_POOL_KEEP = ('||trunc(sum(s.blocks)*1.2)||',2)'
from
   dba_segments s
where
   s.buffer_pool = 'KEEP'; 
;
