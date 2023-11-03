
Practice 18-2: Modifying the Primary Database Service for Application Continuity
--------------------------------------------------------------------------------

### Overview

> In this practice, you will modify the service PRMY created in the DEV1
> pluggable database on the primary database to support Application
> Continuity.

### Tasks

1.  Open a terminal window logged in as oracle to localhost with the
    environment variables set for orclcdb appropriately. Run the
    setup18.sh script to prepare for a simple testing.

    ```
    [oracle@localhost]$ . oraenv
    ORACLE_SID = [oracle] ? orclcdb
    The Oracle base has been set to /u01/app/oracle 
    
    [oracle@localhost ~]$ /home/oracle/setup/lab_18-2/setup18.sh

    drop table emp
    * ERROR at line 1:
    ORA-00942: table or view does not exist

    Table created. 
    ```

2.  Launch SQL\*Plus and set the session container to the DEV1 pluggable
    database.

    ```
    [oracle@localhost ~]$ sqlplus / as sysdba

    SQL> alter session set container=dev1;
    ```

3.  Modify the service PRMY.EXAMPLE.COM to support Application
    Continuity. Exit SQL\*Plus.

    ```
    SQL> @/home/oracle/setup/modify_svc.sql

    SQL> exit
    ```

4.  Examine the script that you will soon use to execute the practice
    application. The script executes the application code called
    actest.jar.

    ```
    [oracle@localhost ~]$ cat /home/oracle/setup/lab_18-2/runreplay
    ```

5.  Examine the properties file.

    -   Use the Replay Data source:
        oracle.jdbc.replay.OracleDataSourceImpl

    -   Use the Application Continuity enabled service: prmy

    -   Use the Application Continuity supported connection pool: UCP

    ```
    [oracle@localhost ~]$ cat /home/oracle/setup/lab_18-2/actest_replay.properties
    ```

6.  Use the terminal window connected to host02. Execute the practice
    application. While the application runs, a periodic status message
    is displayed.

    ```
    [oracle@host02 ~]$ cd /home/oracle/setup/lab_18-2/ 
    [oracle@host02 lab_18-2]$ ./runreplay 
    ...

7.  While the application continues to execute, return to the DGMGRL
    session on localhost. Check the status of the data guard
    configuration and wait until all warning messages are cleared.

    ```
    DGMGRL> show configuration
    ```

8.  Verify that both databases are ready for switchover, and then
    perform a switchover.

    ```
    DGMGRL> validate database orclcdb

    DGMGRL> validate database stndby

    DGMGRL> switchover to stndby
    ```

9.  Return to the terminal session on host02. Press Ctrl+C to abort the
    application.


> **Note:** Your application is still connected without having any
> connection issues. There was only a small delay during the switchover
> operation.

10. (**Optional**) Return to the DGMGRL session on localhost.
    Optionally, switch back to the original state.

    ```
    DGMGRL> switchover to orclcdb
    ```

11. Exit DGMGRL on localhost.
