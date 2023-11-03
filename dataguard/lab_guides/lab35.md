
Practice 18-1: Creating and Testing Primary Database Services
-------------------------------------------------------------

### Overview

> In this practice, you will create and test a service for the DEV1
> pluggable database on the primary database, and follow that service as
> it migrates from localhost to stndby during switchover exercises.

### Tasks

1.  Use a terminal window logged in as oracle to localhost with the
    environment variables set for orclcdb appropriately. Launch
    SQL\*Plus and set the session container to the DEV1 pluggable
    database.

    ```
    [oracle@localhost ~]$ . oraenv
    ORACLE_SID = [oracle] ? orclcdb
    The Oracle base has been set to /u01/app/oracle [oracle@localhost ~]$ sqlplus / as sysdba
    SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jun 7 14:44:47 2020
    Version 19.3.0.0.0

    (c) 1982, 2019, Oracle. All rights reserved.


    Connected to:
    Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.3.0.0.0

    SQL> alter session set container=dev1;

    Session altered.
    ```


2.  Create and start a service with the name PRMY

    ```
    SQL> exec DBMS_SERVICE.CREATE_SERVICE('PRMY','PRMY')

    PL/SQL procedure successfully completed.

    SQL> exec DBMS_SERVICE.START_SERVICE('PRMY')

    PL/SQL procedure successfully completed.
    ```


3.  From within SQL\*Plus, display the status of the Oracle listener
    running on localhost and verify that the service was started
    successfully. Do not exit SQL\*Plus.

    ```
    SQL> !lsnrctl status
    ```

4.  Use another terminal window logged in as oracle to host02 with the
    environment variables set for orclcdbFS appropriately. Launch
    SQL\*Plus and connect to the PRMY.EXAMPLE.COM service.

    ```
    [oracle@host02 ~]$ . oranev
    ORACLE_SID = [oracle] ? orclcdbFS
    The Oracle base has been set to /u01/app/oracle

    [oracle@host02 ~]$ sqlplus system/<password>@prmy
    SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jun 7 14:47:38 2020
    Version 19.3.0.0.0

    (c) 1982, 2019, Oracle. All rights reserved.
    Last Successful login time: Sun Jun 07 2020 09:26:10 -04:00 Connected to:
    Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.3.0.0.0

    SQL>
    ```

> **Note:** The tnsnames.ora network configuration file was already
> created, with an entry PRMY that attempts to connect to both
> localhost.example.com and stndby.example.com, and access a service
> name of PRMY.EXAMPLE.COM.

5.  Verify that you are indeed connected to the orclcdb instance (the
    primary database).

    ```
    SQL> select instance_name from v$instance;
    ```

6.  Verify that your connection has been established with the DEV1
    pluggable database and not the root container.

    ```
    SQL> select sys_context ('USERENV', 'CON_NAME') as container FROM dual;
    ```

7.  Return to the SQL\*Plus session running on localhost for the primary
    database. Create an on database startup trigger in the DEV1 PDB that
    will open the DEV1 pluggable database if it is not already open. The
    trigger should then start the PRMY.EXAMPLE.COM service after it
    switches the container to the DEV1 container. The logic should only
    execute if the database is in the primary role. Exit SQL\*Plus on
    localhost.

    ```
    SQL> show con_name
    ```

8.  Launch DGMGRL and connect to the SYSDG account. Show the
    configuration.

    ```
    [oracle@localhost ~]$ dgmgrl sysdg/<password>@orclcdb
    ```

9.  Validate that the primary and physical standby databases are ready
    for switchover.

    ```
    DGMGRL> validate database 
    ```

10. Perform a switch over to the stndby physical standby database. Do
    not exit DGMGRL.

    ```
    DGMGRL> switchover to stndby
    ```

11. Return to the SQL\*Plus session on localhost Attempt to verify that
    your session is now on the stndby database.
> **Note:** During switchover, you lost the exiting session.

    ```
    SQL> select instance_name from v$instance;
    select instance_name from v$instance
    *
    ERROR at line 1:
    ORA-03113: end-of-file on communication channel Process ID: 24566
    Session ID: 297 Serial number: 59237
    ```

12. Establish a new session using the PRMY.EXAMPLE.COM service.

    ```
    SQL> connect system/<password>@prmy
    Connected.
    SQL>
    ```

13. Verify that you are now connected to the stndby instance (the
    primary database).

    ```
    SQL> select instance_name from v$instance;
    ```

14. Verify that your connection has been established with the DEV1
    pluggable database and not the root container. Exit SQL\*Plus.

    ```
    SQL> select sys_context ('USERENV', 'CON_NAME') as container FROM dual;
    ```

15. Return to the DGMGRL session running on localhost in Step 10.
    Validate both databases are ready for switchover, and then perform a
    switchover to return the configuration to the way it was at the
    start of this practice.

    ```
    DGMGRL> validate database stndby 
    ```

16. Display the status of the data guard configuration. Wait until all
    warning messages are cleared for practice 18-2.

    ```
    DGMGRL> show configuration
    ```

17. Keep the DGMGRL session on localhost for practice 18-2.
