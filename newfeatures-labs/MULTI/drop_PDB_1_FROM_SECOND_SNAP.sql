set echo on
ALTER PLUGGABLE DATABASE PDB_1_FROM_SECOND_SNAP CLOSE;
DROP PLUGGABLE DATABASE PDB_1_FROM_SECOND_SNAP INCLUDING DATAFILES;
EXIT