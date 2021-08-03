set echo on
SELECT a.table_name,b.table_name,c.table_name  FROM dba_tables a,dba_tables b,dba_tables c ;
SELECT a.object_name,b.object_name,c.object_name FROM dba_objects a,dba_objects b,dba_objects c;
CREATE TABLE replay_tab (c NUMBER);
INSERT INTO replay_tab VALUES (1);
COMMIT;
exit