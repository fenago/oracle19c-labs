Practice 17-1: Enable Change Tracking on the Physical Standby Database
----------------------------------------------------------------------

### Overview

> In this practice, you will enable the change tracking feature on
> stndby for the physical standby database and verify its usage.

### Tasks

1.  Use a terminal window logged in as oracle to stndby with the
    environment variables set for stndby appropriately. Using operating
    system authentication, SQL\*Plus connects, by default, to the root
    container in the lab environment. Enable change tracking by using
    the file /u01/app/oracle/oradata/stndby/rman\_change\_track.file.

    ```
    [oracle@stndby ~]$ . oraenv
    ORACLE_SID = [oracle] ? stndby
    The Oracle base has been set to /u01/app/oracle [oracle@stndby ~]$ sqlplus / as sysdba

    SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jun 7 08:48:36 2020
    Version 19.3.0.0.0

    (c) 1982, 2019, Oracle. All rights reserved.


    Connected to:
    Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.3.0.0.0

    SQL> alter database enable block change tracking using file '/u01/app/oracle/oradata/STNDBY/rman_change_track.file';
    Database altered. SQL>
    ```


2.  Verify that block change tracking is enabled, displaying the file
    name used and file size of the block change tracking file.

    ```
    SQL> select filename, status, bytes from v$block_change_tracking;

    FILENAME

    STATUS               BYTES
    /u01/app/oracle/oradata/stndby/rman_change_track.file
    ENABLED	           11599872
    ```


3.  Exit SQL\*Plus on stndby of the physical standby database. It is
    recommended to keep the terminal session open with the environment
    variables set appropriately.

