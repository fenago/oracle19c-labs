set echo on
ALTER PLUGGABLE DATABASE OPEN;
DROP TABLESPACE test INCLUDING CONTENTS AND DATAFILES;
host mkdir -p /u02/app/oracle/oradata/ORCL/pdb1
host mkdir -p /u02/app/oracle/oradata/ORCL/PDB1

CREATE TABLESPACE test DATAFILE '/u02/app/oracle/oradata/ORCL/pdb1/test01.dbf' SIZE 10M;
CREATE TABLE hr.tabenc (c1 NUMBER, label VARCHAR2(50) ENCRYPT) tablespace test;
INSERT INTO hr.tabenc VALUES (1,'DATA encrypted with column TDE');
COMMIT;
CREATE DIRECTORY dp_pdb1 AS '/tmp';
EXIT