
Practice 17-6: Rolling Forward a Standby Database with One Command
------------------------------------------------------------------

### Overview

    > In this practice, you will resolve problems such as missing or
    > corrupted archive log file, an unrecoverable archive gap, or the need
    > to roll standby forward in time without applying a large number of
    > archivelog files.

### Tasks

1.  Use the terminal window on localhost as the oracle user. Make sure
    that you set up your environment variables correctly.

    ```
    [oracle@localhost ~]$ . oraenv
    ORACLE_SID = [orclcdb] ? orclcdb
    The Oracle base remains unchanged with value /u01/app/oracle [oracle@localhost ~]$
    ```

2.  Disable the redo transport service in preparation of the practice.

    ```
    [oracle@localhost ~]$ dgmgrl
    DGMGRL for Linux: Release 19.0.0.0.0 - Production on Sun Jun 7 10:35:59 2020
    Version 19.3.0.0.0

    (c) 1982, 2019, Oracle and/or its affiliates. All rights reserved.

    Welcome to DGMGRL, type "help" for information. DGMGRL> connect sysdg/<password>@orclcdb Connected to "orclcdb"
    Connected as SYSDG.
    DGMGRL> edit database orclcdb set state='TRANSPORT-OFF';
    Succeeded.
    DGMGRL>
    ```

3.  Use the terminal window on stndby as the oracle user. Make sure that
    you set up your environment variables correctly. Launch SQL\*Plus to
    stop the stndby standby database.

    ```
    [oracle@stndby ~]$ . oraenv
    ORACLE_SID = [oracle] ? stndby
    The Oracle base has been set to /u01/app/oracle [oracle@stndby ~]$ sqlplus / as sysdba

    SQL*Plus: Release 19.0.0.0.0 - Production on Sun Jun 7 10:39:29 2020
    Version 19.3.0.0.0

    (c) 1982, 2019, Oracle. All rights reserved.

    Connected to:
    Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.3.0.0.0

    SQL> shutdown immediate
    Database closed. Database dismounted.
    ORACLE instance shut down. SQL>
    ```

4.  Open a new terminal window on localhost. Then make a note of the
    current log sequence number. Record the sequence number of the
    online redo log file in thread 1. In your case, the sequence\#
    is 82)

    ```
    [oracle@localhost ~]$ . oraenv
    ORACLE_SID = [oracle] ? orclcdb
    The Oracle base has been set to /u01/app/oracle [oracle@localhost ~]$ sqlplus / as sysdba
    ```

5.  In the DEV1 PDB, create a simple table named hr.test17 and insert a
    few rows.

    ```
    SQL> alter session set container=DEV1;

    Session altered.

    SQL> @/home/oracle/setup/setup_17-6.sql
    ```

6.  Switch the current log file to advance the online redo log sequence
    number.

    ```
    SQL> connect / as sysdba
    Connected.
    SQL> alter system switch logfile;

    System altered.

    SQL> SELECT THREAD#, MAX(SEQUENCE#) FROM V$ARCHIVED_LOG WHERE RESETLOGS_CHANGE# = (SELECT MAX(RESETLOGS_CHANGE#) FROM V$ARCHIVED_LOG) GROUP BY THREAD#;
    ```


7.  Identify the most current archived log files by using the number
    identified in step 6.

> **Note:** If there are more than one entries, choose the latest
> archived log file. Exit SQL\*Plus.

    ```
    SQL> col name format a65
    SQL> select thread#, name from v$archived_log where thread#=1 and sequence#=82;
    ```

8.  Now, simulate a loss of the archived log file before transferring to
    the standby database. Remove the archived log file identified in the
    previous step.

    ```
    [oracle@localhost ~]$ rm
    /u01/app/oracle/fast_recovery_area/ORCLCDB/archivelog/2020_06_07/o1
    _mf_1_82_hft449l6_.arc
    [oracle@localhost ~]$
    ```


9.  Return to the DGMGRL session on localhost. Start the redo transport
    service to the physical standby database.

    ```
    DGMGRL> edit database orclcdb set state='TRANSPORT-ON';
    Succeeded.
    DGMGRL>
    ```

10. Return to the SQL\*Plus session on stndby and start the physical
    standby database.

    ```
    SQL> startup
    ```

11. In the DEV1 PDB, verify that the physical standby is synchronized
    with the primary database. Exit SQL\*Plus.

    ```
    SQL> alter session set container=DEV1;

    Session altered.

    SQL> select * from hr.test17;
    select * from hr.test17
    *
    ERROR at line 1:
    ORA-00942: table or view does not exist

    SQL> exit
    Disconnected from Oracle Database 19c Enterprise Edition Release
    19.0.0.0.0 - Production Version 19.3.0.0.0 [oracle@stndby ~]$
    ```


    > **Note:** The changes made to the primary database have not been
    > applied due to the missing archived log files in the primary database.
    > Remember that you have removed the most current archived log files to
    > simulate the unrecoverable archived log file gap issue.

12. Return to the DGMGRL session on localhost, stop the Managed Recovery
    Process to prepare for the standby database recovery.

    ```
    DGMGRL> edit database stndby set state='APPLY-OFF';
    Succeeded.
    DGMGRL>
    ```

13. Return to the terminal session on stndby. Let's see how we can
    refresh the standby database with one command in case of the
    unresolvable scenario. Launch the RMAN utility to recover the
    standby database with one command. Exit the RMAN utility.

    ```
    [oracle@stndby ~]$ rman target /
    ```

14. Using SQL\*Plus, connect to the stndby database. Start the database
    and its PDB.

    ```
    [oracle@stndby ~]$ sqlplus / as sysdba
    ```

15. Return to the DGMGRL session on localhost. Start the redo apply
    service.

    ```
    DGMGRL> edit database stndby set state='APPLY-ON';
    Succeeded.
    DGMGRL>
    ```

16. Return to the SQL\*Plus session on stndby connected to the stndby
    database. In the DEV1 PDB, verify that the physical standby applies
    the change made to the primary database. Exit SQL\*Plus.

    ```
    SQL> alter session set container=DEV1;
    ```

17. Return to the DGMGRL session on localhost. Display the status of the
    data guard broker configuration.

    ```
    DGMGRL> show configuration
    ```

> **Note:** In this practice, we tested how to recover the physical
> standby database with a single command in case of the unrecoverable
> redo gap scenario. The ORA-\* warning message in the stndby2 standby
> database was caused by the missing redo from the primary database.

18. Disable the stndby2 logical standby database.

> **Note:** We can safely disable the stndby2 database because it will
> not be used in later practices.

    ```
    DGMGRL> disable database stndby2;
    Disabled.
    DGMGRL> show configuration

    Configuration - DRSolution

    Protection Mode: MaxPerformance Members:
    orclcdb	- Primary database orclcdbFS - Far sync instance
    stndby	- Physical standby database
    stndby2 - Logical standby database (disabled) ORA-16749: The member was disabled manually.

    stndbyFS - Far sync instance
    Fast-Start Failover: Disabled Configuration Status:
    SUCCESS	(status updated 48 seconds ago)

    DGMGRL>
    ```


19. Exit DGMGRL and SQL\*Plus leaving the terminal window open for
    future practices.
