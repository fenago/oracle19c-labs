# Oracle Data Guard 19c Lab Guide: Using Oracle Active Data Guard

## Lesson 7: Supported Workloads in Read-Only Standby

### Practices Overview

In these practices, you will configure the Active Data Guard standby databases to support various offloadable workloads such as real-time query, DML/DDL on Global Temporary Tables, and read-mostly applications.

---

### Enable Active Data Guard Real-Time Query

**Objective:** Enable the Active Data Guard with the real-time query feature and verify its operation.

#### Tasks:

1. **Set Active Data Guard Parameters**:
    ```sql
    ALTER SYSTEM SET temp_undo_enable=true;
    ALTER SYSTEM SET adg_redirect_dml=true SCOPE=BOTH;
    SHOW PARAMETER adg_redirect_dml;
    ```

2. **Prepare the Standby Database**:
    - Use a terminal window logged in as `oracle` to `cdbstby`.
    - Ensure the environment variables are set for `cdbstby`.
    - Confirm that the physical standby database and its `orclpdb1` PDB are in `READ ONLY` mode.

3. **Open the Standby Database**:
    - If the physical standby database is in the `MOUNT` state, stop the redo apply service and open the `cdbstby` database in `READ ONLY` mode.

4. **Enable Real-Time Query**:
    - Restart the Redo Apply process on the physical standby database running in the `READ ONLY` mode. This will enable the real-time query feature.

5. **Check Connection to CDB**:
    - Confirm that the SQL*Plus session is currently connected to the `CDB$ROOT`.
    - Ensure that sample schemas, such as `HR.REGIONS`, do not exist in the root container.

6. **Switch to the orclpdb1 PDB**:
    - In the SQL*Plus session, switch to the `orclpdb1` pluggable database (PDB).
    - Query the `HR.REGIONS` table again to confirm its presence.

7. **Insert a Row in Primary Database**:
    - Open a new terminal window, logged in as `oracle` to `localhost`.
    - Set environment variables for `orclcdb`.
    - Launch SQL*Plus, switch to the `orclpdb1` PDB of the primary database, and query the `HR.REGIONS` table.
    - Insert a new row into the `HR.REGIONS` table and commit the transaction.

8. **Verify Real-Time Query on Standby**:
    - Switch back to the SQL*Plus session connected to the `orclpdb1` PDB on the `stndby` standby database.
    - Query the `HR.REGIONS` table. The new row should be immediately available on the physical standby database, showcasing the real-time query capability of Active Data Guard.

9. **Cleanup**:
    - Exit SQL*Plus on the `stndby` standby database. Keep the terminal session open with the appropriate environment variables set.
    - Exit SQL*Plus on `localhost`, but keep the window open for subsequent labs.

### Conclusion:

You've successfully enabled and tested the real-time query feature of Active Data Guard. This powerful feature ensures that data on the standby database is immediately available for read operations as soon as it's committed on the primary database.
