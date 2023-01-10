select dest_id, sequence#, applied from v$archived_log
where dest_id=2 and
sequence# > (select max(sequence#) - 10 from v$archived_log)
order by sequence#
/
