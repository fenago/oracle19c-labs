# Oracle Data Guard 19c Lab Guide: Convert Physical Standby to a Snapshot Standby

## Overview

In this practice, you will learn how to convert the `orcldg` physical standby database into a snapshot standby database.


## Tasks:

1. **Login and Initial Check**:
    - Open a terminal and log in as `oracle` to `orcldg`.
    - Ensure the environment variables are set correctly for `orcldg`.
    - Launch SQL*Plus and verify the current role of the database.

    ```
    [oracle@orcldg ~]$ . oraenv
    ORACLE_SID = [oracle] ? orcldg

    [oracle@orcldg ~]$ sqlplus / as sysdba


    SQL> select database_role from v$database;
    ```

2. **Verify Flashback Database Status**:
    - Ensure that the flashback database is turned off and note the default value for the flashback retention target.

    ```sql
    SQL> select flashback_on from v$database;
    
    SQL> show parameter DB_FLASHBACK_RETENTION_TARGET
    ```

3. **Inspect Recovery Parameters**:
    - Display values for the initialization parameters that define the Fast Recovery Area.

    ```sql
    show parameter DB_RECOVERY_FILE_DEST
    ```

4. **Fast Recovery Area Usage**:
    - Check the types of files, their counts, and space utilization in the Fast Recovery Area.
    
    ```sql
    SELECT file_type, number_of_files, percent_space_used FROM V$recovery_area_usage;
    ```

5. **Attempt Standby Conversion**:
    - Try converting the physical standby database into a snapshot standby database.

    ```
    SQL> alter database convert to snapshot standby;


    alter database convert to snapshot standby
    *
    ERROR at line 1:
    ORA-38784: Cannot create restore point 'SNAPSHOT_STANDBY_REQUIRED_06/03/2020
    20:50:13'.
    ORA-01153: an incompatible media recovery is active
    ```

6. **Redo Apply Cancellation and Conversion**:
    - Cancel the redo apply on the physical standby database.
    - Convert the physical standby database into a snapshot standby.
    - Open the converted database.

    ```
    SQL> alter database recover managed standby database cancel;

    Database altered.

    SQL> alter database convert to snapshot standby;

    Database altered.
    ```

7. **Database Role Verification**:
    - Check the current role of the database.

    ```sql
    SELECT name, open_mode, database_role FROM v$database;
    ```

8. **Flashback Database Status**:
    - Confirm that the flashback database was automatically enabled during the conversion.

    ```
    SQL> select flashback_on from v$database;
    ```

9. **Restore Point Details**:
    - Display the name and storage size of the guaranteed restore point created during conversion.

    ```
    SQL> select name, storage_size from v$restore_point;
    ```

10. **Open Mode Verification**:
    - Display the current open mode for the snapshot standby.

    ```
    SQL> select open_mode from v$database;
    ```

11. **Flashback Log Inspection**:
    - Verify that a flashback log was automatically created in the Recovery Area.
    ```sql
    SELECT file_type, number_of_files, percent_space_used FROM V$recovery_area_usage;
    ```

12. **Reconversion Attempt**:
    - Try converting the snapshot standby back to a physical standby.

    ```
    SQL> alter database convert to physical standby;

    alter database convert to physical standby
    *
    ERROR at line 1:
    ORA-16433: The database or pluggable database must be opened in read/write
    mode.
    ```

    Note: Even though the command in step 6 succeeded in converting the physical standby into a snapshot standby, it must be opened into read-write mode at least one time before you can reverse the operation back to a physical standby. The purpose of this example is to show what happens if you changed your mind and wanted to convert back to a physical standby without proceeding.

13. **Opening Snapshot in Read-Write Mode**:
    - Open the snapshot database and ensure it's in read-write mode.


    ```
    SQL> alter database open;

    SQL> select open_mode from v$database;
    ```

14. **Container Switch and Testing**:
    - Switch to the `orclpdb1` PDB.
    - Open the PDB, create a test table, insert data, and commit.
    - Return to the root container.

    ```
    alter session set container = ORCLPDB1;

    alter database open;

    create table misc1 (x varchar2(50));

    insert into misc1 values ('Test Row');

    commit;

    alter session set container = CDB$ROOT;
    ```

15. **Log Switch on Primary**:

    In step 6, managed recovery was stopped for the snapshot database. Use a terminal window logged in as oracle to localhost to with the environment variables set for orclcdb appropriately. Determine the last archived redo log for the primary database and perform a log switch. Exit SQL*Plus when done.

    - On a terminal connected to `localhost`, find the last archived redo log for the primary database.
    - Perform a log switch.

    ```
    [oracle@localhost ~]$ sqlplus / as sysdba

    SQL> SELECT MAX(SEQUENCE#), THREAD# FROM V$ARCHIVED_LOG GROUP BY THREAD#;

    SQL> alter system switch logfile;

    SQL> exit;
    ```

16. **Redo Verification on Standby**:

    Return to the SQL*Plus session on `orcldg` and verify that the snapshot standby is still receiving redo from the primary database, forwarded to the Far Sync, and then to the snapshot standby.

    - In the `orcldg` SQL*Plus session, confirm that the snapshot standby is still receiving redo data from the primary.

    ```
    SQL> SELECT MAX(SEQUENCE#), THREAD# FROM V$ARCHIVED_LOG GROUP BY THREAD#;
    ```

## Conclusion:

You've successfully converted a physical standby database into a snapshot standby, tested its functionalities, and familiarized yourself with the associated parameters and configurations in an Oracle Data Guard environment.
