# Oracle Data Guard 19c Lab Guide: Performing DDL/DML on Global Temporary Table

## Overview

In this practice, you will issue DML and DDL operations on a global temporary table in the `orcldg` standby database and verify its operations.

This feature offers multiple advantages for Oracle Data Guard:
- Read-mostly reporting applications that utilize global temporary tables to store temporary data can now be offloaded to an Oracle Active Data Guard instance.
- With temporary undo enabled on the primary database, undo changes for a global temporary table aren't logged in the redo. This means the primary database generates less redo. Therefore, the amount of redo that Oracle Data Guard needs to ship to the standby is reduced, leading to decreased network bandwidth and storage consumption.

---

## Tasks:

1. **Check Real-Time Query on Standby**:
    - Open a terminal window and log in as `oracle` user to `orcldg`.
    - Ensure the environment variables are set correctly for `orcldg`.
    - Verify if the real-time query is enabled in the `orcldg` database as the `system` user.

    ```
    oracle@orcldg ~]$ . oraenv
    ORACLE_SID = [oracle] ? orcldg


    [oracle@orcldg ~]$ sqlplus system/<password>

    SQL> select OPEN_MODE, DATABASE_ROLE, DATAGUARD_BROKER from v$database;
    ```

2. **Create Global Temporary Table**:
    - On the primary database, attempt to create a Global Temporary Table (GTT). This change will be reflected in the `orcldg` database due to the DDL redirection feature in 19c.

    ```
    SQL> CREATE GLOBAL TEMPORARY TABLE gtt01 (c1 number, c2 varchar2(10)) ON COMMIT PRESERVE ROWS;
    ```

3. **Check GTT on Primary Database**:
    - Switch to a terminal window on `localhost`, logged in as `oracle`.
    - Set the environment variables for `orclcdb` and log in as the `system` user.

    ```sql
    [oracle@localhost ~]$ . oraenv
    ORACLE_SID = [oracle] ? orclcdb

    [oracle@localhost ~]$ sqlplus system/fenago
    ```

    - Confirm if the global temporary table named `GTT01` was created in the primary database.

    ```sql
    DESC gtt01
    ```

    **Note:** The DDL operation on the global temporary table is redirected to the primary database. DDL change is visible on the standby database when it catches up with the primary database.

4. **Check TEMP_UNDO_ENABLED Parameter on Standby**:
    - Return to the `orcldg` terminal session.
    - Check the `TEMP_UNDO_ENABLED` parameter.

    ```sql
    SHOW PARAMETER TEMP_UNDO_ENABLED
    ```

5. **Insert Row in GTT on Standby Database**:
    - Try to insert a row into the global temporary table on the standby database. Note that this is possible even if `TEMP_UNDO_ENABLED` is set to `FALSE` on the primary, as it's enabled by default on standby.

    ```
    SQL> INSERT INTO gtt01 VALUES(10,'ABC');

    SQL> COMMIT;
    ```

6. **Cleanup**:
    - Exit SQL*Plus on both `localhost` and `orcldg`, but keep the terminal windows open for subsequent labs.


## Conclusion:

You've successfully performed DDL and DML operations on a global temporary table in a Data Guard setup. This practice demonstrated how operations on temporary tables in a read-only standby database are seamlessly handled, emphasizing the flexibility and efficiency of Oracle Active Data Guard in Oracle 19c.
