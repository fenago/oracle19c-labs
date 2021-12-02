select 
   * 
from (
   select 
      owner, 
      segment_name, 
      bytes/1024/1024 meg 
   from 
      dba_segments 
   where
      segment_type = 'TABLE'
   order by 
      bytes/1024/1024 desc) 
where 
   rownum <= 10;
