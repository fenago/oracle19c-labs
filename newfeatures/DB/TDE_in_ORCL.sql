set echo on

ADMINISTER KEY MANAGEMENT SET KEYSTORE CLOSE CONTAINER = ALL;
ADMINISTER KEY MANAGEMENT SET KEYSTORE CLOSE IDENTIFIED BY Welcome_1 CONTAINER = ALL;

ALTER SYSTEM RESET wallet_root SCOPE=SPFILE;
ALTER SYSTEM RESET tde_configuration SCOPE=BOTH;

shutdown immediate

host rm -rf  /u02/app/oracle/admin/ORCL/tde_wallet
host rm -rf  /u02/app/oracle/admin/ORCL/tde_keystore
host rm -rf /u01/app/oracle/admin/ORCL/tde_keystore
host mkdir -p  /u02/app/oracle/admin/ORCL/tde_wallet

startup
ADMINISTER KEY MANAGEMENT CREATE KEYSTORE '/u02/app/oracle/admin/ORCL/tde_wallet' IDENTIFIED BY Welcome_1;

CREATE PLUGGABLE DATABASE pdb1 ADMIN USER pdb_admin IDENTIFIED BY Welcome_1 ROLES=(CONNECT)
   CREATE_FILE_DEST='/u02/app/oracle/oradata/ORCL/pdb1';
ALTER PLUGGABLE DATABASE pdb1 open;

ADMINISTER KEY MANAGEMENT SET KEYSTORE OPEN IDENTIFIED BY Welcome_1 CONTAINER = ALL;
ADMINISTER KEY MANAGEMENT SET KEY IDENTIFIED BY Welcome_1 WITH BACKUP CONTAINER = ALL;

ALTER SESSION SET CONTAINER=pdb1;
ADMINISTER KEY MANAGEMENT SET KEYSTORE OPEN IDENTIFIED BY Welcome_1;
ADMINISTER KEY MANAGEMENT SET KEY IDENTIFIED BY Welcome_1 WITH BACKUP;

DROP TABLESPACE test INCLUDING CONTENTS AND DATAFILES;
CREATE TABLESPACE test DATAFILE '/u02/app/oracle/oradata/ORCL/pdb1/test01.dbf' SIZE 10M;
CREATE USER hr IDENTIFIED BY Welcome_1 default tablespace test;
ALTER USER hr default tablespace test;
GRANT create session, unlimited tablespace, create table TO hr;
CREATE TABLE hr.tabenc (c1 NUMBER, label VARCHAR2(50) ENCRYPT);
INSERT INTO hr.tabenc VALUES (1,'DATA encrypted with column TDE');
COMMIT;
CREATE DIRECTORY dp_pdb1 AS '/tmp';
exit
