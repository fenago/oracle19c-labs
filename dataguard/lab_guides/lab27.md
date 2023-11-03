Practice 14-1: Performing Switchover
------------------------------------

### Overview

> In this practice, you will use DGMGRL view the configuration status,
> validate that the databases are ready for a role reversal, and then
> perform a switchover. During the switchover, you will observe how the
> session connected to the physical standby database is managed by
> default.

### Tasks

1.  Use a terminal window on localhost connected as oracle with the
    environment variables set to orclcdb. Launch the DGMGRL utility and
    connect as the SYSDG user.

    ```
    [oracle@localhost ~]$ . oraenv
    ORACLE_SID = [oracle] ? orclcdb
    The Oracle base has been set to /u01/app/oracle [oracle@localhost ~]$ dgmgrl
    DGMGRL for Linux: Release 19.0.0.0.0 - Production on Sat Jun 6 07:29:43 2020
    Version 19.3.0.0.0

    (c) 1982, 2019, Oracle and/or its affiliates. All rights reserved.

    Welcome to DGMGRL, type "help" for information. DGMGRL> connect sysdg/<password>@orclcdb Connected to "orclcdb"
    Connected as SYSDG.
    DGMGRL>
    ```

2.  Use the SHOW CONFIGURATION command to display the configuration
    status for the Data Guard configuration.

3.  Validate that the primary database is ready for role reversal using
    > the VERBOSE option. The

> VERBOSE option will show all checks being performed during validation.

4.  Validate that the physical standby database is ready for role
    > reversal using the VERBOSE option.

    ```
    DGMGRL> validate database verbose stndby
    ```

5.  Use the terminal connected to stndby as oracle with the environment
    > variables set to

> stndby. Launch SQL\*Plus and connect as the SYSDG user.

6.  Check the value of the STANDBY\_DB\_PRESERVE\_STATES parameter.

+----------------------------------------+---+----------+---+---------+
| > SQL\> **show parameter               |   |          |   |         |
| > STANDBY\_DB\_PRESERVE\_STATES**      |   |          |   |         |
+========================================+===+==========+===+=========+
| > NAME                                 |   | > TYPE   |   | > VALUE |
+----------------------------------------+---+----------+---+---------+
| > standby\_db\_preserve\_states SQL\>  |   | > string |   | > NONE  |
+----------------------------------------+---+----------+---+---------+

> **Note:** When a physical standby database is converted to a primary,
> you have the option of keeping any sessions connected to the physical
> standby connected, without disruption,
>
> during the switchover or failover. NONE means no sessions on the
> standby are retained during a switchover or failover. This is the
> default value.

7.  Make sure that the real-time query is enabled in the physical
    > standby database.

8.  Return to the DGMGRL session on localhost. Switch over to the stndby
    physical standby database.

9.  Display the new configuration.

> **Note:** It takes a few minutes to clear up the ORA-\* error
> messages.
>
> **Note:** Remember that the indentation used in the output of the SHOW
> CONFIGURATION
>
> command indicates the hierarchy of how redo is being forwarded.

10. Return to the terminal session connected to stndby. Check the
    current status of the session that was connected to the original
    physical standby database. Exit SQL\*Plus.

> **Note:** The physical standby session was lost during role
> transition. This is the default behavior.

11. In the same terminal window on stndby, launch the DGMGRL utility and
    > connect as the

> SYSDG user.

12. Perform a log switch on the new primary database stndby from within
    > DGMGRL.

13. Verify that the new standby database orclcdb has zero transport lag
    and zero apply lag. You may need to wait a minute for this to clear.

14. Exit DGMGRL leaving the terminal windows open.
