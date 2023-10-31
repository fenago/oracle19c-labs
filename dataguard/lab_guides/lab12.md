# Oracle Data Guard 19c Lab Guide: Convert Snapshot Standby Back to Physical Standby

## Overview

In this lab, you will learn the steps to convert a snapshot standby database back into a physical standby database.

---

## Tasks:

1. **Attempt Initial Conversion**:
    - Using the terminal session connected to `stndby` (or `cdbstby` if using containers), try to convert the snapshot standby back to a physical standby database.

2. **Shutdown and Mount**:
    - Shut down the snapshot standby.
    - Start it again in `MOUNT` mode.

3. **Reconvert to Physical Standby**:
    - Try converting the snapshot standby back to a physical standby again.

4. **Verify Flashback Status**:
    - Confirm that the flashback feature is turned off.
    - Check that the flashback log has been deleted, freeing up space in the flash recovery area.
    ```sql
    SELECT file_type, number_of_files, percent_space_used FROM V$recovery_area_usage;
    ```

5. **Enable Active Data Guard**:
    - Open the container database to activate Active Data Guard.
    - Switch the session to the `orclpdb1` pluggable database and open it.

6. **Test for MISC1 Table**:
    - Try querying the `MISC1` table that was created during the snapshot standby phase.
    - Verify that the table no longer exists after converting the snapshot standby back to a physical standby.

7. **Shutdown and Redo Apply**:
    - Return to the root container session.
    - Shut down the physical standby to disable Active Data Guard.
    - Restart the database in `MOUNT` state and initiate Redo Apply.

8. **Cleanup**:
    - Exit SQL*Plus on all host machines, but keep the terminal sessions open for future labs.

---

## Conclusion:

You've successfully reverted a snapshot standby database back to its original physical standby configuration. This lab demonstrates the flexibility and adaptability of Oracle Data Guard configurations.
