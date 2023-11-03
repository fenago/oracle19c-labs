Lab: Enable Change Tracking on the Physical Standby Database
----------------------------------------------------------------------

### Overview

> In this practice, you will enable the change tracking feature on
> orcldg for the physical standby database and verify its usage.

### Tasks

1.  Use a terminal window logged in as oracle to orcldg with the
    environment variables set for orcldg appropriately. Using operating
    system authentication, SQL\*Plus connects, by default, to the root
    container in the lab environment. Enable change tracking by using
    the file /u01/app/oracle/oradata/orcldg/rman\_change\_track.file.

    ```
    [oracle@orcldg ~]$ . oraenv
    ORACLE_SID = [oracle] ? orcldg
    The Oracle base has been set to /u01/app/oracle 
    
    [oracle@orcldg ~]$ sqlplus / as sysdba


    SQL> alter database enable block change tracking using file '/u01/app/oracle/oradata/orcldg/rman_change_track.file';
    ```


2.  Verify that block change tracking is enabled, displaying the file
    name used and file size of the block change tracking file.

    ```
    SQL> select filename, status, bytes from v$block_change_tracking;
    ```


3.  Exit SQL\*Plus on orcldg of the physical standby database. It is
    recommended to keep the terminal session open with the environment
    variables set appropriately.

