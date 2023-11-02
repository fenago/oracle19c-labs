Practice 12-1: Examining the Maximum Availability Protection Mode
-----------------------------------------------------------------

### Overview

> In this practice, you will use DGMGRL to view the current protection
> mode and modify it to maximum availability. You will simulate a
> problem on the standby database and observe the impact if any to the
> primary database.

### Tasks

1.  Use a terminal window on localhost connected as oracle with the
    environment variables set to orclcdb. Launch the DGMGRL utility and
    connect as the sysdg user with operating system authentication.

2.  Use the SHOW CONFIGURATION command to display the current protection
    mode for the Data Guard configuration.

3.  Using DGMGRL, determine the current LogXptMode for the far sync
    instance and the physical standby database. EXAMPLE for FAR SYNC
    applications. DO NOT EXECUTE

4.  ***Optional: DO NOT EXECUTE this example:***

5.  Connect to the primary database using SQL\*Plus and determine the
    current value for the

> LOG\_ARCHIVE\_DEST\_2 parameter. What is the current LogXptMode? Exit
> SQL\*Plus.

6.  Launch the DGMGRL utility and connect as the SYSDG user.

7.  Display the value for the RedoRoutes property of the primary
    database.

> **Note:** When the property \'RedoRoutes\' has been defined, it takes
> precedence over the value of the property \'LogXptMode\'. The property
> \'LogXptMode\' will continue to report \'ASYNC\' even though the
> actual transport mode is currently \'SYNC\'.

8.  Modify the \'RedoRoutes\' property for the orclcdb primary database
    and set it to the \'ASYNC\' redo transport mode.

9.  Attempt to change the configuration mode to maximum availability and
    notice the results.

10. Modify the RedoRoutes property for the orclcdb primary database and
    set it to the \'FASTSYNC\' redo transport mode.

11. Change the configuration mode to maximum availability and verify the
    results.

12. Use a terminal window on stndby connected as oracle with the
    environment variables set to stndby. Connect to the physical standby
    database using SQL\*Plus and perform a shutdown abort.

13. Return to the DGMGRL session running on localhost and display the
    configuration.

14. Return to the SQL\*Plus session on stndby connected as oracle with
    the environment variables set to stndby. Use SQL\*Plus to restart
    and mount the physical standby database..

+-----------------------+---+-------------+---+-------------+---+--------------+
| > Database mounted.   |   |             |   |             |   |              |
| >                     |   |             |   |             |   |              |
| > SQL\> **show pdbs** |   |             |   |             |   |              |
+=======================+===+=============+===+=============+===+==============+
| CON\_ID               |   | > CON\_NAME |   | > OPEN MODE |   | > RESTRICTED |
+-----------------------+---+-------------+---+-------------+---+--------------+
| 2                     |   | > PDB\$SEED |   | > MOUNTED   |   |              |
+-----------------------+---+-------------+---+-------------+---+--------------+
| 3                     |   | > DEV1      |   | > MOUNTED   |   |              |
+-----------------------+---+-------------+---+-------------+---+--------------+

15. Return to the DGMGRL session running on localhost and display the
    configuration.

> **Note:** The broker may have restarted redo apply before you are able
> to see the above error. In addition, you may also receive a series of
> warnings ORA-16778 and ORA-16809 standby disconnected from redo source
> for longer than specified threshold. This is acceptable.

16. Restart redo apply for the physical standby database. Perform a log
    switch on the primary database and verify the configuration.

17. Before proceeding with additional lab steps, give the transport lag
    and apply lag an opportunity to catch up. Use the show configuration
    and show database stndby commands until the lag clears. Repeat these
    commands as needed.
