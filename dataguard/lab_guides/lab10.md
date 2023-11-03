# Oracle Data Guard 19c Lab Guide: Configuring Automatic Redirection of DML Operations

## Overview

In this practice, you will set up the automatic redirection of DML operations for standby sessions in an Active Data Guard environment. This configuration facilitates read-mostly applications that occasionally execute DMLs on the standby database.

---

## Tasks:

1. **Login to Primary Database**:
    - Open a terminal window and log in as the `oracle` user to `localhost`.
    - Ensure the environment variables are set correctly for `orclcdb`.
    - Log in as the `SYS` user.

2. **Enable DML Redirection on Primary**:
    - Configure the primary database to automatically redirect DML operations.

3. **Login to Standby Database**:
    - In a new terminal, log in as the `oracle` user to `orcldg`.
    - Ensure the environment variables are set for `orcldg`.
    - Log in as the `SYS` user.

4. **Enable DML Redirection on Standby**:
    - Configure the standby database to automatically redirect DML operations.

5. **Test on Primary's PDB**:
    - Switch back to the terminal connected to `localhost`.
    - Connect to the `ORCLPDB1` PDB for testing.

6. **Create a Test Table**:
    - Create a table named `TEST01` and insert a sample row.

7. **Connect to Standby's PDB**:
    - Go to the terminal session for `orcldg` and connect to the `ORCLPDB1` PDB.

8. **Display Test Table Data**:
    - Query and display data from the `TEST01` table.

9. **Test DML Redirection on Standby**:
    - Test the automatic redirection of DML in the current session. It's essential to log in to the `ORCLPDB1` PDB using a username/password combination rather than using the `ALTER SESSION SET CONTAINER` command.

10. **Re-login and Test DML Redirection**:
    - Exit SQL*Plus, log back into the `ORCLPDB1` PDB, and test automatic redirection of DML again.

11. **Verify DML Redirection on Primary**:
    - Return to the terminal session connected to `localhost`.
    - Validate the effects of the automatic redirection of DML operations in the `orclcdb` primary database. The `DELETE` statement issued from the standby should be redirected and executed on the primary database.

12. **Cleanup**:
    - Exit SQL*Plus on both `localhost` and `orcldg`. Keep the terminal windows open for subsequent labs.

---

## Conclusion:

You've successfully set up and tested the automatic redirection of DML operations in an Active Data Guard environment. This feature ensures that even read-mostly applications, which occasionally need to perform DML operations, can seamlessly function with a standby database.
