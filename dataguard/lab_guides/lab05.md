# Oracle Data Guard 19c Lab Guide: Managing Physical Standby Files After Structural Changes on the Primary Database

## Lesson 4: Practices Overview

In these practices, you will test the primary database changes that do not require manual intervention at the standby database with the new features.

### Refreshing the Password File

**Objective:** Test the automatic password change propagation feature. As of Oracle Database 19c Release 2 (19.3.0.1), password file changes done on the primary database are automatically propagated to standby databases.

#### Tasks:

1. **Connect to the Primary Database**:
    - Open a terminal window and connect to `localhost` as the `oracle` OS user.
    - Use the `oraenv` utility to set the environment variables for the `orcldg` instance.
    ```bash
    . oraenv
    ```
    Provide the instance name as `orcldg` when prompted.
    - Invoke SQL*Plus and connect as `SYSDBA` to your primary database:
    ```bash
    sqlplus / as sysdba
    ```

2. **List Users in the Password File**:
    - In SQL*Plus, run the following:
    ```sql
    SELECT USERNAME, SYSDBA, SYSDG FROM V$PWFILE_USERS;
    ```

    Expected output:
    ```
    USERNAME       SYSDBA     SYSDG
    SYS           TRUE       FALSE
    ```

3. **Connect to the Standby Database**:
    - Open a new terminal window.
    - Connect to `stndby` as the `oracle` OS user:
    ```bash
    su - oracle
    ```
    - Use the `oraenv` utility to set the environment variables for the `orcldg` instance.
    - Invoke SQL*Plus and connect as `SYSDBA` to your standby database.

4. **Check Standby's Password File**:
    - In SQL*Plus, run:
    ```sql
    SELECT USERNAME, SYSDBA, SYSDG FROM V$PWFILE_USERS;
    ```

    Expected output:
    ```
    USERNAME       SYSDBA     SYSDG
    SYS           TRUE       FALSE
    ```

5. **Stop Media Recovery Process (mrp0) on Standby**:
    ```sql
    ALTER DATABASE RECOVER MANAGED STANDBY DATABASE CANCEL;
    ```

6. **Create a New User on the Primary Database**:
    - Return to the terminal connected to the primary database (`orclcdb`).
    - Create a user named `c##dba` with a password of `dba`:
    ```sql
    CREATE USER c##dba IDENTIFIED BY dba;
    ```
    - Grant `SYSDBA` and `CREATE SESSION` privileges to `c##dba`:
    ```sql
    GRANT SYSDBA, CREATE SESSION TO c##dba container=all;
    ```
    - Review the output of `V$PWFILE_USERS` to confirm the new user:
    ```sql
    SELECT USERNAME, SYSDBA, SYSDG FROM V$PWFILE_USERS;
    ```

7. **Check Standby's Password File**:
    - Switch to the terminal session connected to `stndby`.
    - Review the output of `V$PWFILE_USERS`. The new user may not appear immediately due to the Media Recovery process being stopped.

8. **Restart Media Recovery Process on Standby**:
    ```sql
    ALTER DATABASE RECOVER MANAGED STANDBY DATABASE DISCONNECT FROM SESSION;
    ```

9. **Change Password and Test Connection**:
    - Return to the terminal session connected to the primary (`orcldg`).
    - Change the password for the `c##dba` user:
    ```sql
    ALTER USER c##dba IDENTIFIED BY newpassword;
    ```
    - Test the connection to the standby database (`stndby`) with the new password.

10. **Cleanup**:
    - Drop the `c##dba` user from the primary:
    ```sql
    DROP USER c##dba CASCADE;
    ```
    - Exit SQL*Plus on both the primary (`orcldg`) and standby (`stndby`), but keep the terminal windows open for subsequent labs.

### Conclusion:
You've successfully tested the automatic propagation of password file changes from the primary to the standby database in Oracle 19c. This feature simplifies the management of Data Guard configurations and ensures security synchronization between the primary and standby databases.
