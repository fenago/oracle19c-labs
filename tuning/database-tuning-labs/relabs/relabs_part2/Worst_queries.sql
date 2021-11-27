select b.username username, a.disk_reads reads,
a.executions exec, a.disk_reads /decode
(a.executions, 0, 1,a.executions) rds_exec_ratio,
a.sql_text Statement
from V$sqlarea a, dba_users b
where a.parsing_user_id = b.user_id
and a.disk_reads > 100000
order by a.disk_reads desc;