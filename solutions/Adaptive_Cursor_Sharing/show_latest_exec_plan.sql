set echo on

select * from table(dbms_xplan.display_cursor(null,null,'TYPICAL +PEEKED_BINDS'));

