select applied_seq#,
gap_status, archived_seq#
from v$archive_dest_status
where dest_id=2
/
