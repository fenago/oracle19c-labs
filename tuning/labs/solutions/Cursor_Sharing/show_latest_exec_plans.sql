set echo on

col child_number Heading 'CHILD|NUMBER'
col object_name format a6
col operation format a16
col options format a15

select address,hash_value,child_number, operation,options,object_name
from v$sql_plan
where (address,hash_value) in
  (select address,hash_value
   from v$sql
   where sql_text like '%select /*CS%');

