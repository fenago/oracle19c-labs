DECLARE
                v_error_code  number;
                v_error_message  varchar2(255);
             CNT     number :=1;
           CURSOR soldier_cursor IS
           Select p.ssn_sm,p.name_ind,s.gr_abbr_code
                     From pers_person_tbl p, pers_svcmbr_tbl s
           Where p.ssn_sm = s.ssn_sm and s.gr_abbr_code = 'MSG8';
BEGIN
   FOR soldier_record IN  soldier_cursor LOOP
   Insert into sergeant   -- need to create sergeant table first
           Values (soldier_record.ssn_sm,soldier_record.name_ind,
                        Soldier_record.gr_abbr_code);
          CNT := CNT + 1;
   END LOOP;
   EXCEPTION
   WHEN OTHERS THEN
           v_error_code := SQLCODE;
           v_error_message := SQLERRM;
           ROLLBACK WORK;
           INSERT INTO exception_table(message)
           VALUES(TO_CHAR(v_error_code) || ':' ||v_error_message ||
            ':' || 'Soldiers Inserted' || to_char(CNT));
           COMMIT WORK;
END;
/
