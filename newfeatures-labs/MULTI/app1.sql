set echo on

DROP USER schema_app1 CASCADE;

CREATE USER schema_app1 IDENTIFIED BY Welcome_1;
GRANT create session, create table, unlimited tablespace TO schema_app1;
CREATE TABLE schema_app1.tab1 (C number, label VARCHAR2(40));
INSERT INTO schema_app1.tab1 VALUES (1,'Label1');
COMMIT;
SELECT * FROM schema_app1.tab1;


