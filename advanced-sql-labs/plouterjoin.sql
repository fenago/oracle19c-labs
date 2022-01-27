DECLARE
   CNT     number :=1;
   CURSOR soldier_cursor IS
      SELECT p.name_ind, p.ssn_sm, cum_ret_pt 
FROM   pers_person_tbl p LEFT OUTER JOIN pers_svcmbr_tbl a
ON     p.ssn_sm = a.ssn_sm and p.rec_prec = a.rec_prec 
where
p.ssn_sm not in (select ssn_sm from pers_svcmbr_tbl);
  BEGIN
	FOR soldier_record IN  soldier_cursor LOOP
    dbms_output.put_line(soldier_record.name_ind ||
                         soldier_record.ssn_sm ||
                         soldier_record.cum_ret_pt);
              CNT := CNT + 1;
	END LOOP;
   END;   --see plouterjoin.sql
/
