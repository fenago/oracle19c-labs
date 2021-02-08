set echo on

execute DBMS_STATS.GATHER_SYSTEM_STATS(gathering_mode => 'NOWORKLOAD');

select sname,pname,pval1 from aux_stats$;

