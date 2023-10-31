# Oracle Data Guard 19c Lab Guide: Convert Physical Standby to a Snapshot Standby

## Overview

In this practice, you will learn how to convert the `stndby` physical standby database into a snapshot standby database.

---

## Tasks:

1. **Login and Initial Check**:
    - Open a terminal and log in as `oracle` to `stndby`.
    - Ensure the environment variables are set correctly for `stndby`.
    - Launch SQL*Plus and verify the current role of the database.

2. **Verify Flashback Database Status**:
    - Ensure that the flashback database is turned off and note the default value for the flashback retention target.
    ```sql
    SHOW PARAMETER db_flashback
    ```

3. **Inspect Recovery Parameters**:
    - Display values for the initialization parameters that define the Fast Recovery Area.
    ```sql
    SHOW PARAMETER recovery
    ```

4. **Fast Recovery Area Usage**:
    - Check the types of files, their counts, and space utilization in the Fast Recovery Area.
    ```sql
    SELECT file_type, number_of_files, percent_space_used FROM V$recovery_area_usage;
    ```

5. **Attempt Standby Conversion**:
    - Try converting the physical standby database into a snapshot standby database.

6. **Redo Apply Cancellation and Conversion**:
    - Cancel the redo apply on the physical standby database.
    - Convert the physical standby database into a snapshot standby.
    - Open the converted database.

7. **Database Role Verification**:
    - Check the current role of the database.
    ```sql
    SELECT name, open_mode, database_role FROM v$database;
    ```

8. **Flashback Database Status**:
    - Confirm that the flashback database was automatically enabled during the conversion.

9. **Restore Point Details**:
    - Display the name and storage size of the guaranteed restore point created during conversion.

10. **Open Mode Verification**:
    - Display the current open mode for the snapshot standby.

11. **Flashback Log Inspection**:
    - Verify that a flashback log was automatically created in the Recovery Area.
    ```sql
    SELECT file_type, number_of_files, percent_space_used FROM V$recovery_area_usage;
    ```

12. **Reconversion Attempt**:
    - Try converting the snapshot standby back to a physical standby.

13. **Opening Snapshot in Read-Write Mode**:
    - Open the snapshot database and ensure it's in read-write mode.

14. **Container Switch and Testing**:
    - Switch to the `orclpdb1` PDB.
    - Open the PDB, create a test table, insert data, and commit.
    - Return to the root container.

15. **Log Switch on Primary**:
    - On a terminal connected to `localhost`, find the last archived redo log for the primary database.
    - Perform a log switch.

16. **Redo Verification on Standby**:
    - In the `stndby` SQL*Plus session, confirm that the snapshot standby is still receiving redo data from the primary.

---

## Conclusion:

You've successfully converted a physical standby database into a snapshot standby, tested its functionalities, and familiarized yourself with the associated parameters and configurations in an Oracle Data Guard environment.
