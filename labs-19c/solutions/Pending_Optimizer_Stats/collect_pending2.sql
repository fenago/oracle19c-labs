-- Collect stats
begin
  dbms_stats.gather_table_stats(null, 'tabjfv', 
    method_opt => 'for all columns size 1 for columns (c1,c2) size 254');
end;
/

-- public statistics: still nothing
@ show_public_stats  TABJFV

-- private statistics: should see values (0.001 for density for both C1 and C2, 0.2 for others)
@ show_pending_stats TABJFV

-- Should be false: use public statistics
show parameter optimizer_use_pending_statistics

