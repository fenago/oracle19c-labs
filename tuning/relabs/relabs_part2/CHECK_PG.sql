
-- ****************************************************************
-- Display detailed PGA statistics
--
-- Copyright (c) 2014 Jerry RIchard - All Rights reserved.
-- ****************************************************************
column name  format a30
column value format 999,999,999

select
   name, 
   value 
from
   v$pgastat
;
