SET ECHO ON
ALTER PLUGGABLE DATABASE ALL CLOSE;
DROP PLUGGABLE DATABASE pdb1 INCLUDING DATAFILES;
DROP PLUGGABLE DATABASE pdb2 INCLUDING DATAFILES;

DROP PLUGGABLE DATABASE pdb_1 INCLUDING DATAFILES;
DROP PLUGGABLE DATABASE pdb_2 INCLUDING DATAFILES;
DROP PLUGGABLE DATABASE pdb_1_from_first_snap INCLUDING DATAFILES;
DROP PLUGGABLE DATABASE pdb_1_from_second_snap INCLUDING DATAFILES;
DROP PLUGGABLE DATABASE pdb_1b INCLUDING DATAFILES;

DROP PLUGGABLE DATABASE pdb_refreshed INCLUDING DATAFILES;

DROP PLUGGABLE DATABASE devt INCLUDING DATAFILES;
DROP PLUGGABLE DATABASE administration INCLUDING DATAFILES;
DROP PLUGGABLE DATABASE sales INCLUDING DATAFILES;
DROP PLUGGABLE DATABASE research INCLUDING DATAFILES;
DROP PLUGGABLE DATABASE operations INCLUDING DATAFILES;
DROP PLUGGABLE DATABASE accounting INCLUDING DATAFILES;
DROP PLUGGABLE DATABASE test INCLUDING DATAFILES;
DROP PLUGGABLE DATABASE hr_root INCLUDING DATAFILES;

DROP PLUGGABLE DATABASE pdb_isolated INCLUDING DATAFILES;
DROP PLUGGABLE DATABASE new_pdb1 INCLUDING DATAFILES;

DROP PLUGGABLE DATABASE orcl_pdb1 INCLUDING DATAFILES;
DROP PLUGGABLE DATABASE pdb1_dup INCLUDING DATAFILES;

EXIT