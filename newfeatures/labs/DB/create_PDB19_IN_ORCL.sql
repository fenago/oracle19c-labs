SET ECHO ON
HOST mkdir /u02/app/oracle/oradata/ORCL/pdb19_in_orcl

ALTER PLUGGABLE DATABASE pdb19_in_orcl CLOSE;
ALTER SESSION SET db_create_file_dest='/u02/app/oracle/oradata/ORCL/pdb19_in_orcl';
DROP PLUGGABLE DATABASE pdb19_in_orcl INCLUDING DATAFILES;
CREATE PLUGGABLE DATABASE pdb19_in_orcl
    ADMIN USER pdb_admin IDENTIFIED BY Welcome_1 ROLES=(CONNECT)
    CREATE_FILE_DEST='/u02/app/oracle/oradata/ORCL/pdb19_in_orcl';
	
ALTER PLUGGABLE DATABASE pdb19_in_orcl OPEN;
exit
