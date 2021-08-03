set echo on
drop tablespace tbsinmem including contents and datafiles;
create bigfile tablespace tbsinmem datafile '/u02/app/oracle/oradata/ORCL/pdb1/tbsinmem01.dbf' size 1000m
DEFAULT INMEMORY PRIORITY none MEMCOMPRESS for query high;
ALTER DATABASE DATAFILE '/u02/app/oracle/oradata/ORCL/pdb1/tbsinmem01.dbf' AUTOEXTEND ON;
exit
