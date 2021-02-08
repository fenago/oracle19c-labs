-- table publish mode should be TRUE, for now
select dbms_stats.get_prefs('PUBLISH', 'stats', 'tabjfv') publish from dual;

-- set table value to false, i.e, do not publish statistics
exec dbms_stats.set_table_prefs('stats', 'tabjfv', 'PUBLISH', 'FALSE');

-- table publish mode should be FALSE now
select dbms_stats.get_prefs('PUBLISH', 'stats', 'tabjfv') publish from dual;

