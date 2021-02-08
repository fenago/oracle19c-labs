set echo on

execute dbms_stats.gather_table_stats('SH','T',cascade=>TRUE);

