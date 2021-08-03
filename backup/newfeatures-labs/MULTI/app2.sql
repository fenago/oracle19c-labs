set echo on

INSERT INTO schema_app1.tab1 VALUES (2,'Label2');
CREATE TABLE schema_app1.tab2 (C number, description VARCHAR2(40));
INSERT INTO schema_app1.tab2 VALUES (1,'Description1');
COMMIT;
SELECT * FROM schema_app1.tab2;
set echo off
DROP USER hr CASCADE;
set echo on
SELECT * FROM HR.departments;

