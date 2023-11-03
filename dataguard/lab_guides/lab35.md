
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

2.  Create and start a service with the name PRMY

3.  From within SQL\*Plus, display the status of the Oracle listener
    running on localhost and verify that the service was started
    successfully. Do not exit SQL\*Plus.

> SQL\> **!lsnrctl status**
>
> LSNRCTL for Linux: Version 12.1.0.1.0 - Production on 20-DEC-2013
> 16:06:01
>
> \(c\) 1991, 2013, Oracle. All rights reserved.
>
> Connecting to
> (DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost.example.com)(PORT=
> 1521)(SEND\_SDU=10485760)(RECV\_SDU=10485760)))
>
> STATUS of the LISTENER
>
> Alias LISTENER
>
> Version TNSLSNR for Linux: Version 12.1.0.1.0 - Production
>
> Start Date 18-DEC-2013 10:25:42
>
> Uptime 2 days 5 hr. 40 min. 21 sec
>
> Trace Level off
>
> Security ON: Local OS Authentication
>
> SNMP OFF
>
> Listener Parameter File
>
> /u01/app/oracle/product/12.1.0/dbhome\_1/network/admin/listener.ora
>
> Listener Log File
>
> /u01/app/oracle/diag/tnslsnr/localhost/listener/alert/log.xml
> Listening Endpoints Summary\...
>
> (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=localhost.example.com)(PORT=
> 1521)))
>
> (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC1521)))
>
> (DESCRIPTION=(ADDRESS=(PROTOCOL=tcps)(HOST=localhost.example.com)(PORT
>
> =5500))(Security=(my\_wallet\_directory=/u01/app/oracle/admin/orclcdb/
> xdb\_wallet))(Presentation=HTTP)(Session=RAW))
>
> (DESCRIPTION=(ADDRESS=(PROTOCOL=tcps)(HOST=localhost.example.com)(PORT
>
> =5501))(Security=(my\_wallet\_directory=/u01/app/oracle/admin/orclcdb/
> xdb\_wallet))(Presentation=HTTP)(Session=RAW))
>
> Services Summary\...
>
> ***Service \"PRMY\" has 1 instance(s).***
>
> ***Instance \"orclcdb\", status READY, has 1 handler(s) for this
> service\...***
>
> Service \"orclcdb.example.com\" has 2 instance(s).

4.  Use another terminal window logged in as oracle to host02 with the
    environment variables set for orclcdbFS appropriately. Launch
    SQL\*Plus and connect to the PRMY.EXAMPLE.COM service.

> **Note:** The tnsnames.ora network configuration file was already
> created, with an entry PRMY that attempts to connect to both
> localhost.example.com and stndby.example.com, and access a service
> name of PRMY.EXAMPLE.COM.

5.  Verify that you are indeed connected to the orclcdb instance (the
    primary database).

6.  Verify that your connection has been established with the DEV1
    pluggable database and not the root container.

7.  Return to the SQL\*Plus session running on localhost for the primary
    database. Create an on database startup trigger in the DEV1 PDB that
    will open the DEV1 pluggable database if it is not already open. The
    trigger should then start the PRMY.EXAMPLE.COM service after it
    switches the container to the DEV1 container. The logic should only
    execute if the database is in the primary role. Exit SQL\*Plus on
    localhost.

+---------+------------------------------------------+---------------+
| > SQL\> | > create or replace trigger              |               |
|         | > primary\_services                      |               |
+=========+==========================================+===============+
| > 2     | > after startup on database              |               |
+---------+------------------------------------------+---------------+
| > 3     | > declare                                |               |
+---------+------------------------------------------+---------------+
| > 4     | > role varchar2(30);                     |               |
+---------+------------------------------------------+---------------+
| > 5     | > omode varchar2(30);                    |               |
+---------+------------------------------------------+---------------+
| > 6     | > begin                                  |               |
+---------+------------------------------------------+---------------+
| > 7     | > select database\_role into role from   |               |
|         | > v\$database;                           |               |
+---------+------------------------------------------+---------------+
| > 8     | > select open\_mode into omode from      | > = \'DEV1\'; |
|         | > v\$pdbs where name                     |               |
+---------+------------------------------------------+---------------+
| > 9     | > if role = \'PRIMARY\' then             |               |
+---------+------------------------------------------+---------------+
| > 10    | > if omode != \'READ WRITE\' then        |               |
+---------+------------------------------------------+---------------+

8.  Launch DGMGRL and connect to the SYSDG account. Show the
    configuration.

9.  Validate that the primary and physical standby databases are ready
    for switchover.

10. Perform a switch over to the stndby physical standby database. Do
    not exit DGMGRL.

11. Return to the SQL\*Plus session on localhost Attempt to verify that
    your session is now on the stndby database.

> **Note:** During switchover, you lost the exiting session.

12. Establish a new session using the PRMY.EXAMPLE.COM service.

13. Verify that you are now connected to the stndby instance (the
    primary database).

14. Verify that your connection has been established with the DEV1
    pluggable database and not the root container. Exit SQL\*Plus.

15. Return to the DGMGRL session running on localhost in Step 10.
    Validate both databases are ready for switchover, and then perform a
    switchover to return the configuration to the way it was at the
    start of this practice.

> DGMGRL\> **validate database stndby** Database Role: Primary database
> Ready for Switchover: ***Yes***
>
> DGMGRL\> **validate database orclcdb**
>
> Database Role: Physical standby database Primary Database: stndby
>
> Ready for Switchover: ***Yes***
>
> Ready for Failover: Yes (Primary Running) Current Log File Groups
> Configuration:
>
> Thread \# Online Redo Log Groups Standby Redo Log Groups (stndby)
>
> 1 3 2
>
> Future Log File Groups Configuration:

+-------------+---------------+-------+----------+---------------------------+
| > Thread \# | > Online Redo | > Log | > Groups | > Standby Redo Log Groups |
|             |               |       |          | >                         |
|             |               |       |          | > (stndby)                |
+=============+===============+=======+==========+===========================+
| > 1         | > 3           |       |          | > 2                       |
+-------------+---------------+-------+----------+---------------------------+

> DGMGRL\> **switchover to orclcdb**
>
> Performing switchover NOW, please wait\...
>
> Operation requires a connection to database \"orclcdb\" Connecting
> \...
>
> Connected to \"orclcdb\" Connected as SYSDG.
>
> New primary database \"orclcdb\" is opening\...
>
> Operation requires start up of instance \"stndby\" on database
> \"stndby\"
>
> Starting instance \"stndby\"\... Connected to an idle instance. ORACLE
> instance started.
>
> Connected to \"stndby\" Database mounted.
>
> Database opened. Connected to \"stndby\" Connected to \"orclcdb\"
>
> Switchover succeeded, new primary is \"orclcdb\" DGMGRL\>

16. Display the status of the data guard configuration. Wait until all
    warning messages are cleared for practice 18-2.

17. Keep the DGMGRL session on localhost for practice 18-2.
