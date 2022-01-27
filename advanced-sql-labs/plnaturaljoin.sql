DECLARE
   CNT     number :=1;
   CURSOR soldier_cursor IS
      SELECT name_ind, ssn_sm, dob,cum_ret_pt 
FROM   pers_person_tbl  NATURAL JOIN pers_svcmbr_tbl;
  BEGIN
	FOR soldier_record IN  soldier_cursor LOOP
    dbms_output.put_line(soldier_record.ssn_sm ||
                                          soldier_record.dob ||
                                          soldier_record.cum_ret_pt ||
                                          soldier_record.name_ind);
END LOOP;
END;
/
