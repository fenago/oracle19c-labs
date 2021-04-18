SET ECHO ON
ALTER PLUGGABLE DATABASE pdb1 CLOSE;
ALTER SESSION SET db_create_file_dest='/u02/app/oracle/oradata/ORCL/pdb1';
DROP PLUGGABLE DATABASE pdb1 INCLUDING DATAFILES;
CREATE PLUGGABLE DATABASE pdb1
    ADMIN USER pdb_admin IDENTIFIED BY Welcome_1 ROLES=(CONNECT)
    CREATE_FILE_DEST='/u02/app/oracle/oradata/ORCL/pdb1';
	
ALTER PLUGGABLE DATABASE pdb1 OPEN;
exit
