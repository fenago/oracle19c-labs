alter session set nls_date_format='mm/dd hh24:mi:ss';

-- delete statistics
exec dbms_stats.delete_table_stats('stats', 'tabjfv');

-- public statistics: none
@ show_public_stats TABJFV

-- private statistics: none
@ show_pending_stats TABJFV

