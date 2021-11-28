col table_name format a10
col extension format a12

select * from user_stat_extensions;

-- Create extention on the 2 columns
select dbms_stats.create_extended_stats(null,'tabjfv','(c1,c2)') from dual;

select * from user_stat_extensions;

-- Collect stats
begin
  dbms_stats.gather_table_stats(null, 'tabjfv', 
    method_opt => 'for all columns size 1 for columns (c1,c2) size 254');
end;
/

-- public statistics: still nothing
@ show_public_stats  TABJFV

-- private statistics: should see values and also the new virtual column! Density=0.2 for all except virtual one: 0.001
@ show_pending_stats TABJFV

