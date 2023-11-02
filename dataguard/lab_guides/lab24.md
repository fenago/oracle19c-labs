
Practice 12-2: Examining the Maximum Protection Mode
----------------------------------------------------

### Overview

> In this practice, you will use DGMGRL to modify the current protection
> mode to maximum protection. You will simulate a problem on the standby
> database and observe the impact to the primary database.

### Tasks

1.  Modify the RedoRoutes property for the orclcdb primary database and
    set it to the SYNC redo transport mode. Enable the maximum
    protection mode for the Data Guard configuration.

> **Note:** The maximum protection mode is not supported by far sync.

2.  devshow

3.  Enable the maximum protection mode for the Data Guard configuration
    and display the resulting configuration. Exit DGMGRL.

4.  In the same terminal window on localhost, connect to the primary
    database using SQL\*Plus and switch the session to the DEV1
    pluggable database. Leave this window

5.  Use a terminal window on stndby connected as oracle with the
    environment variables set to stndby. Connect to the physical standby
    database using SQL\*Plus and perform a shutdown abort.

6.  Return to the SQL\*Plus session on localhost with orcl2. Display the
    current data for the HR.REGIONS table and then insert a new row into
    the table. Exit the terminated session.

> **Note:** The primary database has been brought down due to the
> maximum protection mode and not having the standby database available
> to accept redo. Depending on timings and blocks cached in memory, the
> insert may be successful, but the commit will always fail. You may
> have to wait for the timeout period to elapse before seeing the error
> message.

7.  In the same terminal window on localhost, connect to the primary
    database using SQL\*Plus and attempt to restart the instance. Exit
    the terminated session.

> \[oracle\@localhost \~\]\$ **sqlplus / as sysdba**
>
> SQL\*Plus: Release 19.0.0.0.0 - Production on Fri Jun 5 11:30:15 2020
>
> Version 19.3.0.0.0
>
> \(c\) 1982, 2019, Oracle. All rights reserved.
>
> Connected to an idle instance.
>
> SQL\> **startup**
>
> ORACLE instance started.
>
> Total System Global Area 629145352 bytes

+---------------------+-----------+---------+
| > Fixed Size        | 9137928   | > bytes |
+=====================+===========+=========+
| > Variable Size     | 373293056 | > bytes |
+---------------------+-----------+---------+
| > Database Buffers  | 239075328 | > bytes |
+---------------------+-----------+---------+
| > Redo Buffers      | 7639040   | > bytes |
+---------------------+-----------+---------+
| > Database mounted. |           |         |
+---------------------+-----------+---------+

> ORA-03113: end-of-file on communication channel Process ID: 11692
>
> Session ID: 19 Serial number: 51864
>
> SQL\> **exit**
>
> Disconnected from Oracle Database 19c Enterprise Edition Release
>
> 19.0.0.0.0 - Production Version 19.3.0.0.0 \[oracle\@localhost \~\]\$
>
> **Note:** The primary cannot be started with the physical standby down
> with the maximum protection mode and no other standby databases
> available that support this mode.

8.  Return to the SQL\*Plus session on stndby to start up and mount the
    physical standby database. Verify that the DEV1 pluggable database
    is mounted. Exit SQL\*Plus.

+---------------------+-----------+-------------+---+------------+
| Fixed Size          | 9137928   | > bytes     |   |            |
+=====================+===========+=============+===+============+
| Variable Size       | 369098752 | > bytes     |   |            |
+---------------------+-----------+-------------+---+------------+
| Database Buffers    | 243269632 | > bytes     |   |            |
+---------------------+-----------+-------------+---+------------+
| Redo Buffers        | 7639040   | > bytes     |   |            |
+---------------------+-----------+-------------+---+------------+
| Database mounted.   |           |             |   |            |
|                     |           |             |   |            |
| SQL\> **show pdbs** |           |             |   |            |
+---------------------+-----------+-------------+---+------------+
| CON\_ID CON\_NAME   |           | > OPEN MODE |   | RESTRICTED |
+---------------------+-----------+-------------+---+------------+
| 2 PDB\$SEED         |           | > MOUNTED   |   |            |
+---------------------+-----------+-------------+---+------------+
| > 3 DEV1            |           | > MOUNTED   |   |            |
+---------------------+-----------+-------------+---+------------+

9.  Return to the terminal window on localhost connected as oracle with
    the environment variables set to orclc2. Use SQL\*Plus to open the
    primary database. Verify that the database is open. If not, then
    open it. Exit SQL\*Plus.

+-------------------------------------------------+-----------+---------+---+---+---+
| Fixed Size                                      | 9137928   | > bytes |   |   |   |
+=================================================+===========+=========+===+===+===+
| Variable Size                                   | 373293056 | > bytes |   |   |   |
+-------------------------------------------------+-----------+---------+---+---+---+
| Database Buffers                                | 239075328 | > bytes |   |   |   |
+-------------------------------------------------+-----------+---------+---+---+---+
| Redo Buffers Database mounted. Database opened. | 7639040   | > bytes |   |   |   |
+-------------------------------------------------+-----------+---------+---+---+---+
|                                                 |           |         |   |   |   |
+-------------------------------------------------+-----------+---------+---+---+---+
|                                                 |           |         |   |   |   |
+-------------------------------------------------+-----------+---------+---+---+---+
|                                                 |           |         |   |   |   |
+-------------------------------------------------+-----------+---------+---+---+---+
|                                                 |           |         |   |   |   |
+-------------------------------------------------+-----------+---------+---+---+---+

10. In the same terminal window on localhost, launch the DGMGRL utility
    and connect as the SYSDG user. Display the Data Guard configuration.
    Wait until the ORA-\* warning messages are cleared.

11. Change the Data Guard protection mode to maximum performance.

12. Restart Redo Apply on the physical standby database and perform a
    log switch on the primary database.

13. Display the resulting configuration.

> **Note:** It may take some time for Data Guard broker to resynchronize
> all the changes in this lab environment considering the hardware
> constraints. The following steps can be performed if needed:

**OPTIONAL LAB -- do if we are waiting on other students to complete
lab**

14. Before proceeding with additional lab steps, give the transport lag
    and apply lag an opportunity to catch up. Use the \'show
    configuration\' and \'show database verbose stndby\' commands until
    the lag clears. Repeat these commands as needed.

15. Exit DGMGRL and SQL\*Plus leaving the terminal windows open for
    future practices.