


Practice 17-4: Configuring RMAN Parameters
------------------------------------------

### Overview

> In this practice, you will configure RMAN for use in a Data Guard
> environment.

### Tasks

1.  In your RMAN session (connected to your primary database), configure
    the backup retention policy to allow for recovery for seven days.

2.  Specify that archived redo log files can be deleted after they are
    applied to the standby database.

3.  Configure the connect identifier for your primary database.

4.  Configure the connect identifier for your physical standby database.

5.  Your physical standby database is registered with the recovery
    catalog. Use the LIST DB\_UNIQUE\_NAME command to see the
    registration information about your primary and standby databases.

6.  Use the REPORT SCHEMA command to view additional information about
    your physical standby database. Exit RMAN when done.

  File       Size(MB)      Tablespace              RB segs      Datafile Name
  ------- -- ---------- -- -------------------- -- --------- -- ---------------
  \-\--                                                         
  1          960           SYSTEM                  YES          
  3          940           SYSAUX                  NO           
  4          280           UNDOTBS1                YES          
  5          270           PDB\$SEED:SYSTEM        NO           
  6          330           PDB\$SEED:SYSAUX        NO           
  7          5             USERS                   NO           
  8          100           PDB\$SEED:UNDOTBS1      NO           
  9          510           DEV1:SYSTEM             YES          
  10         370           DEV1:SYSAUX             NO           
  11         100           DEV1:UNDOTBS1           YES          
  12         5             DEV1:USERS              NO           
