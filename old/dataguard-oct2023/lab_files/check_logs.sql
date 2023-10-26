select thread#,max(sequence#) "Last Standby Seq Applied"
from v$archive_log val, v$database vdb where val.resetlogs_change#=vdb.resetlogs_change#
/
