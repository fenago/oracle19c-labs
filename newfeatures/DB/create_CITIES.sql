set echo on
ALTER PLUGGABLE DATABASE OPEN;
DROP TABLESPACE test INCLUDING CONTENTS AND DATAFILES;
CREATE TABLESPACE test DATAFILE '/u02/app/oracle/oradata/ORCL/pdb1/test01.dbf' SIZE 10M;
CREATE USER hr IDENTIFIED BY Welcome_1 default tablespace test;
GRANT create session, unlimited tablespace, create table TO hr;
DROP TABLE hr.cities;
CREATE TABLE hr.cities (code NUMBER, name CHAR(14));
EXIT