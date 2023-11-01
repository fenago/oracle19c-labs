# Oracle Data Guard 19c Lab Guide: Convert Snapshot Standby Back to Physical Standby

## Overview

In this lab, you will learn the steps to convert a snapshot standby database back into a physical standby database.


## Tasks:

1. **Attempt Initial Conversion**:
    - Using the terminal session connected to `orcldg`, try to convert the snapshot standby back to a physical standby database.

    ```
    SQL> alter database convert to physical standby;


    alter database convert to physical standby
    *
    ERROR at line 1:
    ORA-01126: database must be mounted in this instance and not open in any Instance
    ```

2. **Shutdown and Mount**:
    - Shut down the snapshot standby.
    - Start it again in `MOUNT` mode.

    ```
    SQL> shutdown immediate

    Database closed. Database dismounted.
    ORACLE instance shut down.

    SQL> startup mount

    ORACLE instance started.
    Total System Global Area 517763072 bytes Fixed Size		2290216 bytes Variable Size	440405464 bytes
    Database Buffers	71303168 bytes
    Redo Buffers	3764224 bytes
    Database mounted.
    ```

3. **Reconvert to Physical Standby**:
    - Try converting the snapshot standby back to a physical standby again.

    ```
    SQL> alter database convert to physical standby;

    Database altered.
    ```

4. **Verify Flashback Status**:
    - Confirm that the flashback feature is turned off.
    - Check that the flashback log has been deleted, freeing up space in the flash recovery area.
    ```sql
    SQL> select flashback_on from v$database;

    SELECT file_type, number_of_files, percent_space_used FROM V$recovery_area_usage;
    ```

5. **Enable Active Data Guard**:
    - Open the container database to activate Active Data Guard.
    - Switch the session to the `orclpdb1` pluggable database and open it.

    ```
    SQL> alter database open;

    SQL> alter session set container = ORCLPDB1;

    SQL> alter database open;
    ```

6. **Test for MISC1 Table**:
    - Try querying the `MISC1` table that was created during the snapshot standby phase.
    - Verify that the table no longer exists after converting the snapshot standby back to a physical standby.

    ```
    SQL> select * from misc1;

    select * from misc1
    * ERROR at line 1:
    ORA-00942: table or view does not exist

    SQL> select table_name from dba_tables where table_name like 'MISC%';

    no rows selected
    ```

7. **Shutdown and Redo Apply**:
    - Return to the root container session.
    - Shut down the physical standby to disable Active Data Guard.
    - Restart the database in `MOUNT` state and initiate Redo Apply.

    ```
    SQL> alter session set container = CDB$ROOT;

    SQL> shutdown immediate

    SQL> startup mount

    SQL> alter database recover managed standby database disconnect;
    ```

8. **Cleanup**:
    - Exit SQL*Plus on all host machines, but keep the terminal sessions open for future labs.

    ```
    SQL> exit;
    ```

## Conclusion:

You've successfully reverted a snapshot standby database back to its original physical standby configuration. This lab demonstrates the flexibility and adaptability of Oracle Data Guard configurations.
