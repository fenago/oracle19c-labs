set echo on

select * from table(dbms_xplan.display_cursor);

col operations  format a20
col object_name format a11
col options     format a15
col cost_cpu_io format a30


select operation operations, object_name, options,
       cost||' -- '||cpu_cost||' -- '||io_cost cost_cpu_io
from (select * from v$sql_plan where address in (select address
                                                 from v$sql
                                                 where sql_text like '%system stats%' and 
                                                       sql_text not like '%connect%'));

