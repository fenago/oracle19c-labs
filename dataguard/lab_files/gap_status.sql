select applied_seq#,gap_status,error,archived_seq#
from v$archive_dest_status
where dest_id = 2
/
