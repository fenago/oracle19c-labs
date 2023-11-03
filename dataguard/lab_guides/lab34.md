
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

2.  Disable the redo transport service in preparation of the practice.

3.  Use the terminal window on stndby as the oracle user. Make sure that
    you set up your environment variables correctly. Launch SQL\*Plus to
    stop the stndby standby database.

4.  Open a new terminal window on localhost. Then make a note of the
    current log sequence number. Record the sequence number of the
    online redo log file in thread 1. In your case, the sequence\#
    is 82)

5.  In the DEV1 PDB, create a simple table named hr.test17 and insert a
    few rows.

6.  Switch the current log file to advance the online redo log sequence
    number.

7.  Identify the most current archived log files by using the number
    identified in step 6.

> **Note:** If there are more than one entries, choose the latest
> archived log file. Exit SQL\*Plus.

8.  Now, simulate a loss of the archived log file before transferring to
    the standby database. Remove the archived log file identified in the
    previous step.

9.  Return to the DGMGRL session on localhost. Start the redo transport
    service to the physical standby database.

10. Return to the SQL\*Plus session on stndby and start the physical
    standby database.

11. In the DEV1 PDB, verify that the physical standby is synchronized
    with the primary database. Exit SQL\*Plus.

> **Note:** The changes made to the primary database have not been
> applied due to the missing archived log files in the primary database.
> Remember that you have removed the most current archived log files to
> simulate the unrecoverable archived log file gap issue.

12. Return to the DGMGRL session on localhost, stop the Managed Recovery
    Process to prepare for the standby database recovery.

13. Return to the terminal session on stndby. Let's see how we can
    refresh the standby database with one command in case of the
    unresolvable scenario. Launch the RMAN utility to recover the
    standby database with one command. Exit the RMAN utility.

> \[oracle\@stndby \~\]\$ **rman target /**
>
> Recovery Manager: Release 19.0.0.0.0 - Production on Sun Jun 7
> 11:28:41 2020
>
> Version 19.3.0.0.0
>
> \(c\) 1982, 2019, Oracle and/or its affiliates. All rights reserved.
>
> connected to target database: ORCLCDB (DBID=2732274290, not open)
> RMAN\> **RECOVER STANDBY DATABASE FROM SERVICE=orclcdb;**
>
> Starting recover at 07-JUN-20
>
> using target database control file instead of recovery catalog
> Executing: alter database flashback off
>
> Executing: alter database disable block change tracking Oracle
> instance started
>
> Total System Global Area 629145352 bytes
>
> Fixed Size 9137928 bytes Variable Size 373293056 bytes
>
> Database Buffers 239075328 bytes Redo Buffers 7639040 bytes
>
> contents of Memory Script:
>
> {
>
> restore standby controlfile from service \'orclcdb\'; alter database
> mount standby database;
>
> }
>
> executing Memory Script
>
> Starting restore at 07-JUN-20 allocated channel: ORA\_DISK\_1
>
> channel ORA\_DISK\_1: SID=20 device type=DISK
>
> channel ORA\_DISK\_1: starting datafile backup set restore channel
> ORA\_DISK\_1: using network backup set from service orclcdb channel
> ORA\_DISK\_1: restoring control file
>
> channel ORA\_DISK\_1: restore complete, elapsed time: 00:00:02 output
> file name=/u01/app/oracle/oradata/STNDBY/control01.ctl output file
> name=/u01/app/oracle/fast\_recovery\_area/STNDBY/control02.ctl
> Finished restore at 07-JUN-20
>
> released channel: ORA\_DISK\_1 Statement processed
>
> Executing: alter system set standby\_file\_management=manual
>
> contents of Memory Script:
>
> {
>
> recover database from service \'orclcdb\';
>
> }
>
> executing Memory Script
>
> Starting recover at 07-JUN-20
>
> Starting implicit crosscheck backup at 07-JUN-20 allocated channel:
> ORA\_DISK\_1
>
> channel ORA\_DISK\_1: SID=24 device type=DISK Crosschecked 14 objects
>
> Finished implicit crosscheck backup at 07-JUN-20
>
> Starting implicit crosscheck copy at 07-JUN-20 using channel
> ORA\_DISK\_1
>
> Crosschecked 2 objects
>
> Finished implicit crosscheck copy at 07-JUN-20
>
> searching for all files in the recovery area cataloging files\...
>
> cataloging done
>
> List of Cataloged Files
>
> =======================
>
> File Name:
>
> /u01/app/oracle/fast\_recovery\_area/STNDBY/archivelog/2020\_06\_07/o1
>
> \_mf\_1\_60\_hfry8lng\_.arc
>
> \...
>
> File Name:
>
> /u01/app/oracle/fast\_recovery\_area/STNDBY/autobackup/2020\_06\_06/o1
>
> \_mf\_s\_1042403484\_hfrfpq8w\_.bkp
>
> using channel ORA\_DISK\_1
>
> skipping datafile 5; already restored to SCN 1944601 skipping datafile
> 6; already restored to SCN 1944601 skipping datafile 8; already
> restored to SCN 1944601 channel ORA\_DISK\_1: starting incremental
> datafile backup set restore
>
> channel ORA\_DISK\_1: using network backup set from service orclcdb
> destination for restore of datafile 00001:
>
> /u01/app/oracle/oradata/STNDBY/system01.dbf
>
> channel ORA\_DISK\_1: restore complete, elapsed time: 00:00:35 channel
> ORA\_DISK\_1: starting incremental datafile backup set restore
>
> channel ORA\_DISK\_1: using network backup set from service orclcdb
> destination for restore of datafile 00003:
>
> /u01/app/oracle/oradata/STNDBY/sysaux01.dbf
>
> channel ORA\_DISK\_1: restore complete, elapsed time: 00:00:35 channel
> ORA\_DISK\_1: starting incremental datafile backup set
>
> \...
>
> starting media recovery
>
> archived log for thread 1 with sequence xx is already on disk as file
>
> /u01/app/oracle/fast\_recovery\_area/STNDBY/archivelog/2020\_06\_23/o1
>
> \_mf\_1\_37\_hh53htbg\_.arc archived log file
>
> name=/u01/app/oracle/fast\_recovery\_area/STNDBY/archivelog/2020\_06\_
> 23/o1\_mf\_1\_37\_hh53htbg\_.arc thread=1 sequence=37
>
> media recovery complete, elapsed time: 00:00:01 Finished recover at
> 23-JUN-20
>
> Reenabling controlfile options for auxiliary database
>
> Executing: alter database enable block change tracking using file
> \'/u01/app/oracle/oradata/STNDBY/rman\_change\_track.file\' Executing:
> alter system set standby\_file\_management=auto
>
> Finished recover at 23-JUN-20 RMAN\> **exit**
>
> Recovery Manager complete. \[oracle\@stndby \~\]\$

14. Using SQL\*Plus, connect to the stndby database. Start the database
    and its PDB.

15. Return to the DGMGRL session on localhost. Start the redo apply
    service.

16. Return to the SQL\*Plus session on stndby connected to the stndby
    database. In the DEV1 PDB, verify that the physical standby applies
    the change made to the primary database. Exit SQL\*Plus.

17. Return to the DGMGRL session on localhost. Display the status of the
    data guard broker configuration.

> **Note:** In this practice, we tested how to recover the physical
> standby database with a single command in case of the unrecoverable
> redo gap scenario. The ORA-\* warning message in the stndby2 standby
> database was caused by the missing redo from the primary database.

18. Disable the stndby2 logical standby database.

> **Note:** We can safely disable the stndby2 database because it will
> not be used in later practices.

19. Exit DGMGRL and SQL\*Plus leaving the terminal window open for
    future practices.
