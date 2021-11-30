connect / as sysdba;

alter session set container = orclpdb; 

alter system flush shared_pool;

alter system flush buffer_cache;

execute dbms_stats.delete_system_stats;

execute DBMS_STATS.SET_SYSTEM_STATS (pname => 'cpuspeednw', pvalue => 0);

select sname,pname,pval1 from aux_stats$;

exit;

