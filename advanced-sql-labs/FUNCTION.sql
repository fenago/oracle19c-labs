select /*+ index (PERSON_NAME_IX) */ name_ind
              from pers_person_tbl
              where name_ind like upper('jer%')
/
