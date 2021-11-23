SELECT u.unit_owner || '.' || u.unit_name unit, line#,
     ROUND (d.total_time / 1000000000) total_time_s, d.total_occur tc,
     SUBSTR(s.text, 1, 40) stext
   FROM  plsql_profiler_runs r,
  plsql_profiler_units u,
  plsql_profiler_data d,
  all_source s
  WHERE r.run_comment = 'FIRSTRUN'
        AND  r.runid = u.runid
        AND  d.runid = u.runid
        AND  u.unit_number = d.unit_number
        AND  s.owner = u.unit_owner
        AND  s.TYPE = u.unit_type
        AND  s.NAME = u.unit_name
        AND  s.line = d.line#
ORDER BY line#
/
