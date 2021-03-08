select dbms_stats.get_prefs('PUBLISH', 'stats', 'tabjfv') publish
from dual;

exec dbms_stats.set_table_prefs('stats','tabjfv','PUBLISH','TRUE');

select dbms_stats.get_prefs('PUBLISH', 'stats', 'tabjfv') publish
from dual;

