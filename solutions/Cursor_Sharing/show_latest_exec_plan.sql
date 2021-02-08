set echo on

select * from table(dbms_xplan.display_cursor);

