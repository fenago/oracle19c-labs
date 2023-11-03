Oracle Net Services in a Data Guard Environment
===============================================

Overview
--------

### Overview

> In these practices, you will use graphical utilities to create and
> modify the Oracle network configuration files, and then propagate the
> resulting files to each server in the Data Guard environment.

Practice 2-1: Configuring the tnsnames.ora File
-----------------------------------------------

### Overview

### Tasks

Practices for Lesson 3: Creating a Physical Standby Database by Using SQL and RMAN Commands
===========================================================================================

Practices for Lesson 3: Overview
--------------------------------

### Practices Overview

Practice 3-1: Prepare the Primary Database to Support Data Guard
----------------------------------------------------------------

### Overview

> In this practice, you verify that the primary database is configured
> correctly to support a physical standby database. This should be done
> in the orclcdb env.
>
> \$ . oraenv
>
> orclcdb

### Tasks

### 

1.  On localhost, invoke SQL\*Plus and connect as SYSDBA to your primary
    database . Determine if FORCE LOGGING is enabled. If it is not
    enabled, enable FORCE LOGGING mode.

2.  Make sure the primary is in archivelog mode

    -   Select log\_mode from v\$database;

    -   If the result is noarchivelog

    -   Shutdown immediate;

    -   Startup mount

    -   Alter database archivelog;

    -   Alter database open;

3.  Do a rman backuip

For the Primary database orcl2 (or if doing container orclcdb) do the
following:

4.  Determine the number of online redo log groups and their current
    size. Create standby redo log groups with one member for each group
    using the same size as the existing online redo logs. You should
    create one more additional group than the number you have for online
    redo log groups. Verify creation of the standby redo logs.

SQL\> select group\#, bytes from v\$log;

![](media/image1.png){width="4.635416666666667in"
height="1.8541666666666667in"}

SQL\> alter database add standby logfile
\'/u01/app/oracle/oradata/ORCL2/

SQL\> alter database add standby logfile
(\'/u01/app/oracle/oradata/ORCL2/stdbyredo01.log\') size 200M;

database altered.

> SQL\> alter database add standby logfile
> (\'/u01/app/oracle/oradata/ORCL2/stdbyredo02.log\') size 200M;
>
> database altered.
>
> SQL\> alter database add standby logfile
> (\'/u01/app/oracle/oradata/ORCL2/stdbyredo03.log\') size 200M;
>
> database altered.
>
> SQL\> alter database add standby logfile
> (\'/u01/app/oracle/oradata/ORCL2/stdbyredo04.log\') size 200M;
>
> database altered.

SQL\> select group\#,bytes from V\$standby\_log;

GROUP\# BYTES

5.  Define the first log archive destination to use the fast recovery
    area and enable it by using the set\_LAD\_1.sql script. Ensure that
    the changes are done both in memory and also stored the server
    parameter file. This location should be valid for any role and also
    valid for

6.  Increase the maximum number of archive processes to 4.

> **Note:** The documentation suggests this parameter be set to a value
> of 10. We are using a reduced number in this lab environment to reduce
> overhead.

7.  Define the log\_archive\_config parameter to include entries for:
    orcl2, stndby. Only stndby is needed at this moment, but the others
    can be added now in preparation for upcoming practices.

SQL\> alter system set
log\_archive\_config=\'dg\_config=(orcl2,stndby)\'

Enable automatic standby file management so that operating system file
additions and deletions on the primary database are replicated to the
standby database. This is normally set on the standby database. For the
primary database, this is set for role reversals

8.  In orcl2 set log\_archive\_dest\_1 to archive logs to the
    fast\_recovery\_area.

SQL\> alter system set
log\_archive\_dest\_1=\'Location=USE\_DB\_RECOVERY\_FILE\_DEST
VALID\_FOR=(ALL\_LOGFILES, ALL\_ROLES) DB\_UNIQUE\_NAME=ORCL2

9.  To send logs to the standby database stndby use the followingfor
    log\_archive\_dest\_2

Alter system set log\_archive\_dest\_2=

\'Service=stndby ASYNC NOAFFIRM valid\_for=(online\_logfile,all\_roles)

db\_unique\_name=stndby\'

.

Practice 3-2: Prepare Host and Create Physical Standby Database
---------------------------------------------------------------

### Overview

> In this practice, you will prepare stndby to receive the physical
> standby database and create the physical standby database using RMAN.

### Tasks

1.  Use a terminal window logged in as oracle to stndby to create the
    initial directories needed for a physical standby database.

Copy the orcl2 pfile as initstandby.ora file to the ORACLE\_HOME/dbs
directory as well as The orclcdb pfile as initcdbstby.ora to the
ORACLE\_HOME/dbs directory

2.  Verify the contents of the initstndby.ora file

3.  Copy the password file from the primary host to the physical standby
    host.

4.  Place stndby in the oratab file in /etc.

![](media/image2.png){width="5.479166666666667in"
height="1.0729166666666667in"}

5.  Set the environment to stndby. May need to put stndby in the oratab
    file.

6.  Create all directories for the stndby standby database.

    -   . oraenv

        -   stndby

7.  Start up nomount the stndby standby instance on stndby. This assumes
    that the terminal window you are using has previously set the
    environment variables to stndby. Exit SQL\*Plus when done.

**Do not do below 7a and 7b unless standby database stndby is already
created.**

7a. If your database is already created and was shutdown accidentally or
on purpose, then bring the database back up in NOMount mode SQL\>
startup nomount pfile=\$ORACLE\_HOME/dbs/initstndby.ora

If you are just creating the standby database DON\"T do this.

7b. Then execute the command to mount a standby database:

SQL\> alter database mount standby database;

8.  Create a physical standby on stndby by using the RMAN utility.

9.  Connect using rman

    -   **rman target sys/fenago\@orcl2 auxiliary sys/fenago\@stndby**

![](media/image3.png){width="7.361111111111111in"
height="2.107638888888889in"}

**Rman\> duplicate target database for standby from active database**

![](media/image4.png){width="7.361111111111111in" height="4.00625in"}

Practice 3-3: Start Redo Transport and Verify Operation
-------------------------------------------------------

### Overview

> .

### Tasks

1.  Use a terminal window for localhost logged in as oracle with the
    environment variables set to orcl2 (or orclcdb) and start redo
    transport by defining log\_archive\_dest\_2 pointing to the physical
    standby database.

Alter system set log\_archive\_dest\_2=

\'Service=stndby ASYNC NOAFFIRM valid\_for=(online\_logfile,all\_roles)

db\_unique\_name=stndby\' \--(do this for container cdbstby)

2.  On the orcl2 or orclcdb database verify log shipping is enabled

    -   sqlplus / as sysdba

    -   @/home/oracle/setup/log\_ship

    -   @/home/oracle/setup/gap\_status

        -   This should say no gap. This is validating logs are being
            shipped and applied

3.  On the stndby system, it may be best to open 2 terminal windows, one
    with the env or orcl2 and the other of stndby

    -   . oraenv

        -   Stndby

    -   sqlplus / as sysdba

    -   ![](media/image5.png){width="7.361111111111111in"
        > height="0.8854166666666666in"}

        -   This turns on managed recovery on the standby

    -   sql\>@/home/oracle/check\_logs.sql

        -   This validates managed is running

4.  On the primary,orcl2 or orclcdb in rman issue

    -   Alter system switch logfile;

    -   Do this 3 times

    -   Within sql then run @/home/oracle/gap\_status

![](media/image6.png){width="7.361111111111111in" height="2.49375in"}

5.  The Seq\# may vary but no gap should be displayed

LAB 2

1.  Create a standby database called cdbstby from the orclcdb container
    database using the above Lab instructions which created the stndby
    database for orcl2. Use the initcdbstby.ora pfile in the
    \$ORACLE\_HOME/dbs directory

2.  Once cdbstby is created. Create an spfile

> SQL\> create spfile from pfile=\'initcdbstby.ora\'

3.  Next Shutdown the database and bring it up in nomount mode

> SQL\> shutdown immediate
>
> SQL\> startup nomount

4.  Then execute the command to mount a standby database:

> SQL\> alter database mount standby database

5.  Execute the following command to start the recovery process with
    orcl2 or orclcdb.

6.  Alter database recover managed standby database disconnect from
    session.

> ![](media/image5.png){width="7.361111111111111in"
> height="0.8854166666666666in"}

Practices for Lesson 4: Managing Physical Standby Files After Structural Changes on the Primary Database
========================================================================================================

Practices for Lesson 4: Overview
--------------------------------

### Practices Overview

> In these practices, you will test the primary database changes that do
> not require manual intervention at the standby database with the new
> features.

Practice 4-1: Refreshing the Password File
------------------------------------------

### Overview

> In this practice, you will test the automatic password change
> propagation feature. As of Oracle Database 19c Release 2 (19.3.0.1),
> password file changes done on the primary database are automatically
> propagated to standby databases.

### Tasks

1.  Open a terminal window and connect to localhost as the oracle OS
    user.

2.  Use the oraenv utility to set the environment variables for the
    orclcdb instance. Cdbstby

3.  Invoke SQL\*Plus and connect as SYSDBA to your primary database.

4.  List all users in the password file by using V\$PWFILE\_USERS.

;

+----------+---+--------+---+---------+
| USERNAME |   | SYSDBA |   | SYSDG   |
+==========+===+========+===+=========+
| SYS      |   | > TRUE |   | > FALSE |
+----------+---+--------+---+---------+

5.  Open a new terminal window and connect to stndby as the oracle

> OS user. Right click on desktop and select open terminal. Then su -
> oracle

6.  Use the oraenv utility to set the environment variables for the
    orcl2 (orclcdb) instance.

7.  Invoke SQL\*Plus and connect as SYSDBA to your primary database and
    create a tablespace

8.  List all users in the password file by using V\$PWFILE\_USERS.

+----------+---+--------+---+---------+
| USERNAME |   | SYSDB  |   | SYSDG   |
+==========+===+========+===+=========+
| SYS      |   | > TRUE |   | > FALSE |
+----------+---+--------+---+---------+

9.  Stop Media Recovery Process (mrp0) on purpose. Do this in stndby

SQL\> alter database recover managed standby database cancel

10. Return to the terminal connected to primary database orcl2.

Create a user called CDBA with a password of dba

11. 

Grant SYSDBA and CREATE SESSION privileges to dba.

12. Review the output of V\$PWFILE\_USERS. The output shows that the
    newly created user was added to the password file.

13. Return to the terminal session connected to stndby to review the
    output of V\$PWFILE\_USERS. The new entry doesn't appear in the
    output because the Media Recovery process was stopped.

14. Start the Media Recovery Process (mrp0). In stndby

SQL\> alter database recover managed standby database disconnect from
session;

15. Verify V\$PWFILE\_USERS for the granted role.

> **Note:** At times, the new entry doesn't appear in the list
> immediately. In this case, run the
>
> GRANT command (step 11) again at localhost to see if the new entry can
> be added.

16. Return to the terminal session connected to primary and change the
    password for CDBA

> user.

17. Test the connection to the standby database (stndby) with the new
    password.

18. Drop the cdba user (primary).

19. Exit SQL\*Plus on localhost and stndby leaving the terminal windows
    open.

Practice 4-2: Controlling PDB Replication
-----------------------------------------

### Overview

> In this practice, you will create two new PDBs (DEV2 and DEV3) in the
> primary database to demonstrate the control of the PDB replication to
> the standby database. First check to see if you have a dev1 pdb. If
> not use dbca to create dev1.

### Tasks

1.  Use the terminal session on localhost. Create a directory for the
    new data files of DEV2.

2.  Invoke SQL\*Plus and connect to the CDB root as a user (SYS user in
    > this practice) granted with CREATE PLUGGABLE DATABASE privilege to
    > clone DEV2 from DEV1.

3.  Check the open mode of DEV2.

4.  Open DEV2 in READ WRITE mode.

5.  Use the terminal session connected to stndby. Connect as SYS to the
    > stndby standby database.

6.  List the value of the ENABLED\_PDBS\_ON\_STANDBY parameter.

> **Note:** The asterisk (\*) indicates all PDBs are created and
> protected in the standby database.

+----------------------------------+---+--------+---+-------+
| NAME                             |   | > TYPE |   | VALUE |
+==================================+===+========+===+=======+
| enabled\_PDBs\_on\_standby SQL\> |   | string |   | \*    |
+----------------------------------+---+--------+---+-------+

7.  Verify the PDBs in the stndby standby database.

> **Note:** The DEV2 PDB was successfully replicated to the standby
> database.

+-----------+---+-------------+---+-------------+---+--------------+
| > CON\_ID |   | CON\_NAME   |   | > OPEN MODE |   | > RESTRICTED |
+===========+===+=============+===+=============+===+==============+
| > 2       |   | > PDB\$SEED |   | > MOUNTED   |   |              |
+-----------+---+-------------+---+-------------+---+--------------+
| > 3       |   | > DEV1      |   | > MOUNTED   |   |              |
+-----------+---+-------------+---+-------------+---+--------------+
| > 4       |   | > DEV2      |   | > MOUNTED   |   |              |
+-----------+---+-------------+---+-------------+---+--------------+

8.  Now, let's modify the ENABLED\_PDBS\_ON\_STANDBY parameter to
    > include only DEV1 and

> DEV2 PDBs in the standby database.

9.  Return to the terminal session on localhost connected to the
    > **orclcdb** database. Create a directory for DEV3. Use SQL
    > Developer. Ask Instructor if you don\'t know how.

10. Create DEV3 from DEV1.in the orclcdb primary database. (already done
    > with SQL Developer)

11. Check the open mode of DEV3.

12. Open DEV3 in READ WRITE mode.

13. Return to the terminal session on stndby connected to the stndby
    > database. Verify the PDBs in the standby database.

14. The DEV3 PDB is listed in the output of the previous step, but it
    > doesn't mean that it is protected. Run the following query to
    > check the recovery\_status column. This column shows whether
    > recovery is enabled or disabled for the PDB.

+-------------------+---+-------------------+---+-------------------+
| > SQL\> **col     |   |                   |   |                   |
| > name format     |   |                   |   |                   |
| > a10**           |   |                   |   |                   |
| >                 |   |                   |   |                   |
| > SQL\> **SELECT  |   |                   |   |                   |
| > name,           |   |                   |   |                   |
| > open\_mode,     |   |                   |   |                   |
| >                 |   |                   |   |                   |
|  recovery\_status |   |                   |   |                   |
| > FROM v\$pdbs;** |   |                   |   |                   |
+===================+===+===================+===+===================+
| > NAME            |   | > OPEN\_MODE      |   | > RECOVERY        |
+-------------------+---+-------------------+---+-------------------+
| > PDB\$SEED DEV1  |   | > MOUNTED MOUNTED |   | > ENABLED ENABLED |
| > DEV2 DEV3       |   | > MOUNTED MOUNTED |   | > ENABLED         |
|                   |   |                   |   | > DISABLED        |
+-------------------+---+-------------------+---+-------------------+
| > SQL\>           |   |                   |   |                   |
+-------------------+---+-------------------+---+-------------------+

15. To clean up the environment, reset the ENABLED\_PDBS\_ON\_STANDBY
    > parameter in orclcdb

16. Exit SQL\*Plus on localhost and stndby leaving the terminal windows
    > open for future practice.

Practice 4-3: Automating Instantiation of a PDB
-----------------------------------------------

### Overview DO NOT DO. We do not have another container database or host to use.

> In this practice, you will test the usage of
> STANDBY\_PDB\_SOURCE\_FILE\_DBLINK to automate instantiation of a PDB
> in the cdbstby standby database when performing the remote PDB clone
> in the orclcdb primary database. In Oracle Database 19c, creating a
> PDB as a clone in the primary database requires copy of the data files
> belonging to the source PDB to the standby database manually.
>
> CANNOT DO because we have another host computer. However, we can
> convert a non-cdb
>
> To a pluggable in the orclcdb database. (Optional lab)

### Assumptions

-   orclcdb: Primary database with a single PDB called DEV1

-   cdbstby: Standby database protecting the PDB called DEV1

-   ![](media/image7.jpeg){width="5.820138888888889in"
    height="3.196527777777778in"}ORCL2: Stand-alone database

### Prerequisites

-   The value of the STANDBY\_PDB\_SOURCE\_FILE\_DBLINK is only checked
    and used when a remote clone operation (create pluggable
    database....from pdb\@dblink) is executed on the primary database
    and the redo is applied at the standby database.

-   The standby database must be in Active Data Guard (ADG) mode. We
    require access to the dictionary for the database link and the
    dictionary is only available if the standby is in Active Data Guard
    mode.

-   The source PDB must be in Read Only mode and remain for the duration
    of the copies to the primary and all standby databases in the
    configuration. relocate features.

### Tasks DO NOT DO. No alternate host pc.

1.  Open a terminal window and use the SSH client to connect to em13c as
    the oracle OS user. Check the status of the precreated ORCL database
    and its PDB1 PDB. If it's not running, start up the database.

2.  Create the database link user in the ORCL database.

3.  Use the terminal window connected to localhost and create a database
    link in the orclcdb

> primary database to the ORCL source database using the database link.

4.  Test the database link from the orclcdb primary database to the ORCL
    source database.

5.  Use the terminal window connected to stndby and configure the stndby
    database in Active Data Guard with the real-time query mode by
    executing the configure\_adg.sql script.

> **Note:** The real-time query feature is covered in the next lesson.

sql

6.  Test the database link from the stndby standby database to the ORCL
    source database and set the STANDBY\_PDB\_SOURCE\_FILE\_DBLINK
    parameter.

7.  Return to the ORCL terminal session on localhostalt and open PDB1 in
    read-only mode.

8.  Return to the orclcdb terminal session on localhost and create a new
    pluggable database called NEW\_PDB1 as a clone of the remote
    pluggable database PDB1.

9.  Open a new terminal window connected to stndby and review the alert
    log file.

10. Return to the ORCL terminal session on 8c793fb03eed. You can now
    safely open PDB1 in read write mode.

11. Return to the orclcdb terminal session on localhost and open the
    NEW\_PDB1 PDB. **Note:** You may observe a warning message. It's
    probably because of the mismatched settings in the source CDB (ORCL)
    and primary database . You can safely ignore it.

12. Return to terminal session connected to the stndby database on
    stndby and reset the parameter and check the status of NEW\_PDB1
    PDB.

+-------------+------------+-----------+
| > NAME      | OPEN\_MODE | RECOVERY  |
+=============+============+===========+
| > PDB\$SEED | READ ONLY  | > ENABLED |
+-------------+------------+-----------+
| > DEV1      | > MOUNTED  | ENABLED   |
+-------------+------------+-----------+
| > NEW\_PDB1 | > MOUNTED  | ENABLED   |
+-------------+------------+-----------+
| > SQL\>     |            |           |
+-------------+------------+-----------+

13. Return to the orclcdb terminal session on localhost to clean up the
    environment.

14. Exit SQL\*Plus on localhost, and stndby leaving the terminal windows
    open for future practices.

> Congratulations! In this practice, you tested how to automate the
> instantiation of a PDB in the standby database using the
> STANDBY\_PDB\_SOURCE\_FILE\_DBLINK parameter when performing a remote
> clone in the primary database.

Practices for Lesson 5: Using Oracle Active Data Guard: Supported Workloads in Read-Only Standby
================================================================================================

Practices for Lesson 5: Overview
--------------------------------

### Practices Overview

> In these practices, you will configure the Active Data Guard standby
> databases to support the various offloadable workloads such as
> real-time query, DML/DDL on Global Temporary Tables, and read-mostly
> applications.

1.  Set parameter temp\_undo\_enable=true;

**alter system set adg\_redirect\_dml=true scope=both;**

System altered.

SQL\> **show parameter adg\_redirect\_dml**

2.  

Practice 5-1: Enable Active Data Guard Real-Time Query
------------------------------------------------------

### Overview

> In this practice, you enable the Active Data Guard with the real-time
> query feature and verify its operation.

### Tasks

1.  Use a terminal window logged in as oracle to cdbstby with the
    environment variables set for cdbstby appropriately. Make sure that
    the physical standby database and its DEV1 PDB are in READ ONLY
    mode.

2.  (**Optional**) If the physical standby database is in the MOUNT
    state, stop the redo apply service and open the cdbstby database in
    READ ONLY mode.

3.  Restart the Redo Apply process on the physical standby database
    running in the READ ONLY mode to enable the real-time query feature.

> **Note:** Depending on the Redo Apply process status, you will see one
> of two results.

4.  This database is using the Oracle Multitenant option. The default
    operating system authentication method for the multitenant container
    database (CDB) is to the container root (CDB\$ROOT). Data Guard
    environment operations are performed at the CDB level. Schema
    objects like the sample schemas exist in customer created pluggable
    databases (PDBs). Verify that the SQL\*Plus session is currently
    connected to the CDB\$ROOT and that sample schemas do not exist in
    the root container. Two ways are illustrated to determine the
    current container name. The first technique uses the SQL\*Plus show
    commands. The second technique uses all SQL syntax. The HR.REGIONS
    table is part of the sample schemas, but should not exist in the
    root container.

5.  Switch the SQL\*Plus session to the DEV1 pluggable database (PDB)
    and query the

> HR.REGIONS table again.

6.  Leave the above window open. Open a terminal window (if not already
    open) logged in as oracle to localhost with the environment
    variables set for orclcdb appropriately. Launch SQL\*Plus and switch
    session to the DEV1 PDB of the primary database. Query the
    HR.REGIONS table.

7.  Insert a new row into the HR.REGIONS table and commit the SQL
    statement.

8.  Return to the SQL\*Plus session to the DEV1 PDB that is still open
    for the physical standby database on stndby and query the HR.REGIONS
    value. The new row is immediately available on the physical standby
    database for reporting applications after it was inserted on the
    primary database. This illustrates the real-time query capability of
    Active Data Guard.

9.  Exit SQL\*Plus on stndby of the physical standby database. It is
    recommended to keep the terminal session open with the environment
    variables set appropriately.

10. Exit SQL\*Plus on localhost, leaving the window open for future
    practices.

Practice 5-2: Performing DDL/DML on Global Temporary Table
----------------------------------------------------------

### Overview

> In this practice, you will issue DML and DDL operations on a global
> temporary table in the
>
> stndby standby database and verify its operations.
>
> This feature benefits Oracle Data Guard in the following ways:

-   Read-mostly reporting applications that use global temporary tables
    for storing temporary data can be offloaded to an Oracle Active Data
    Guard instance.

-   When temporary undo is enabled on the primary database, undo for
    changes to a global temporary table are not logged in the redo and
    thus, the primary database generates less redo. Therefore, the
    amount of redo that Oracle Data Guard must ship to the standby is
    also reduced, thereby reducing network bandwidth consumption and
    storage consumption.

### Tasks

1.  ![](media/image8.png){width="5.995138888888889in"
    height="4.739583333333333in"}Use a terminal window logged in as
    oracle to stndby with the environment variables set for stndby
    appropriately. Check if the real time query is enabled in the stndby
    database as the system user.

2.  Attempt to create a Global Temporary Table (GTT) on Active Data
    Guard (read-only) instance. NOTE: In 19c this is done on the primary
    database and it moves it to the stndby. So create global table on
    primary and you will see it on stndby.

> **Note:** The DDL operation on the global temporary table is
> redirected to the primary database. DDL change is visible on the
> standby database when it catches up with the primary database.

3.  Use a terminal window logged in as oracle to localhost with the
    environment variables set for orclcdb appropriately. Log in as
    system to the orclcdb database.

4.  Check if the global temporary table called GTT01 was created in the
    primary database.

+----------------+-------------+---+---------+---+-----------------------+
| SQL\> **DESC** | > **gtt01** |   |         |   |                       |
+================+=============+===+=========+===+=======================+
| Name           |             |   | > Null? |   | > Type                |
+----------------+-------------+---+---------+---+-----------------------+
| > C1 C2        |             |   |         |   | > NUMBER VARCHAR2(10) |
+----------------+-------------+---+---------+---+-----------------------+

> **Note:** As you can see, the DDL operation was redirected and issued
> in the primary database.

5.  Return to the stndby terminal session on stndby and check the
    TEMP\_UNDO\_ENABLED

> parameter.

+------------------------------------------------+-----------+---+---------+
| > SQL\> **show parameter TEMP\_UNDO\_ENABLED** |           |   |         |
+================================================+===========+===+=========+
| > NAME                                         | > TYPE    |   | > VALUE |
+------------------------------------------------+-----------+---+---------+
| > temp\_undo\_enabled SQL\>                    | > boolean |   | > FALSE |
+------------------------------------------------+-----------+---+---------+

6.  Now, attempt to insert a row in the global temporary table on the
    standby database.

> **Note:** Even if the TEMP\_UNDO\_ENABLED was set to FALSE, the INSERT
> statement in the physical standby database was allowed. The
> TEMP\_UNDO\_ENABLED parameter is only applicable for the primary
> database. For a standby database, this parameter is ignored because
> temporary undo is enabled by default on the standby database.

7.  Exit SQL\*Plus on localhost and stndby, leaving the window open for
    future practices.

Practice 5-3: Managing Private Temporary Table for DDL/DML
----------------------------------------------------------

### Overview

> In this practice, you will create the private temporary tables in the
> stndby physical standby database and test the DML/DDL operations in
> the private temporary tables.
>
> Private temporary tables are useful in the following situations:

-   When an application stores temporary data in transient tables that
    are populated once, read few times, and then dropped at the end of a
    transaction or session

-   When a session is maintained indefinitely and must create different
    temporary tables for different transactions

-   When the creation of a temporary table must not start a new
    transaction or commit an existing transaction

-   When different sessions of the same user must use the same name for
    a temporary table

-   When a temporary table is required for a read-only database

### Tasks

1.  Use a terminal window logged in as oracle to stndby with the
    environment variables set for stndby appropriately. Log in as the
    SYSTEM user.

2.  Attempt to create a private temporary table (PTT).

3.  Check the value of the PRIVATE\_TEMP\_TABLE\_PREFIX parameter.

4.  Create a PTT with the appropriate prefix.

> **Note:** Because the definition of a private temporary table is
> stored in memory, you can
>
> create it in the read only standby database. But the table name must
> include the appropriate prefix.

5.  Insert rows in the PTT.

6.  Display data from the PTT.

7.  Find all information related to the PTT using the show\_ptt.sql
    script.

8.  Open another terminal window logged in as oracle to stndby with the
    environment variables set for stndby appropriately. Log in as the
    SYSTEM user.

9.  Verify that the PTT created by the first SYSTEM session is not
    visible to the second system

> session.

10. Return to the first SYSTEM window session on stndby and issue the
    ROLLBACK statement.

> **Note:** The duration of the ORA\$PTT\_MINE table was TRANSACTION.
> This is the default duration type. This means that the PTT is
> automatically dropped at the end of the transaction in which the PTT
> has been created.

11. In the same terminal window, create a new PTT of SESSION duration
    type that will last until your session ends.

12. Find all information related to the PTT.

13. Insert rows in the PTT.

14. Display data from the PTT.alaltersalte

15. Now, issue the COMMIT statement and display the information about
    PTT.

> **Note:** The PTT still exists. It will be dropped at the end of the
> session.

16. Exit SQL\*Plus on localhost and stndby, leaving the window open for
    future practices.

Practice 5-4: Configuring Automatic Redirection of DML operations
-----------------------------------------------------------------

### Overview

> In this practice, you will enable automatic redirection of DML
> operations for standby sessions in an Active Data Guard environment to
> support read-mostly applications, which occasionally execute DMLs, on
> the standby database.

### Tasks

1.  Use a terminal window logged in as oracle to localhost with the
    environment variables set for orclcdb appropriately. Log in as the
    SYS user.

2.  Configure automatic redirection of DML operations in the primary
    database.

3.  Use a terminal window logged in as oracle to stndby with the
    environment variables set for stndby appropriately. Log in as the
    SYS user.

4.  Configure automatic redirection of DML operations in the standby
    database.

5.  Return to the terminal session connected to localhost. Connect to
    the DEV1 PDB for testing.

6.  Create a table called TEST01 and insert a row.

7.  Return to the terminal session connected to stndby. Connect to the
    DEV1 PDB.

8.  Display the data in the TEST01 table.

9.  Test automatic redirection of DML in the current session.

> **Note:** You need to log in to the DEV1 PDB using username/password
> instead of the ALTER
>
> SESSION SET CONTAINER command.

10. Exit SQL\*Plus and log in to the DEV1 PDB again and test automatic
    redirection of DML.

11. Return to the terminal session connected to localhost. Verify the
    result of the automatic redirection of DML feature in the orclcdb
    primary database.

> **Note:** The DELETE statement issued from the standby database was
> redirected to the
>
> primary database.

12. Exit SQL\*Plus on localhost and stndby leaving the terminal windows
    open for future practices.

Practices for Lesson 6: Using Oracle Active Data Guard: Far Sync and Real-Time Cascading
========================================================================================

Practices for Lesson 6: Overview
--------------------------------

### Practices Overview

> In these practices, you will implement two Far Sync instances into the
> current Data Guard environment.

Practice 6-1: Add Far Sync to the Data Guard Environment
--------------------------------------------------------

### Overview

> In this practice, you will create a Far Sync instance (orclcdbFS) on
> host02 that is in close proximity to the primary database. THIS CLASS
> doesn\'t have another network to connect too so this information is
> for those who have the multiple networks to utilize

### Tasks -- This is a read only chapter as we do not have another host.

1.  Use a terminal window for localhost logged in as oracle with the
    environment variables set to orclcdb. Use SQL\*Plus to create a
    text-based initialization parameter file named
    /tmp/initorclcdbFS.ora that contains a copy of all the current
    parameters for primary primary

2.  Create a Far Sync control file named /tmp/orclcdbFS.ctl on the
    primary database and exit SQL\*Plus when done.

3.  Copy the primary password file to the /tmp directory.

4.  Transfer the three files staged in the /tmp directory from localhost
    to host02 and place them into the /tmp directory on host02.

+-------------------+------------------+--------+----------+---------+
| > \[              |                  |        |          |         |
| oracle\@localhost |                  |        |          |         |
| > \~\]\$ **cat    |                  |        |          |         |
| > /home           |                  |        |          |         |
| /oracle/setup/cop |                  |        |          |         |
| y\_orclcdbFS.sh** |                  |        |          |         |
| >                 |                  |        |          |         |
| > \...            |                  |        |          |         |
| >                 |                  |        |          |         |
| > scp             |                  |        |          |         |
| > /tmp/           |                  |        |          |         |
| initorclcdbFS.ora |                  |        |          |         |
| > or              |                  |        |          |         |
| acle\@host02:/tmp |                  |        |          |         |
| > scp             |                  |        |          |         |
| > /               |                  |        |          |         |
| tmp/orclcdbFS.ctl |                  |        |          |         |
| > or              |                  |        |          |         |
| acle\@host02:/tmp |                  |        |          |         |
| >                 |                  |        |          |         |
| > scp             |                  |        |          |         |
| >                 |                  |        |          |         |
| /tmp/orapworclcdb |                  |        |          |         |
| > or              |                  |        |          |         |
| acle\@host02:/tmp |                  |        |          |         |
| >                 |                  |        |          |         |
| > \[              |                  |        |          |         |
| oracle\@localhost |                  |        |          |         |
| > \~\]\$          |                  |        |          |         |
| > **/home         |                  |        |          |         |
| /oracle/setup/cop |                  |        |          |         |
| y\_orclcdbFS.sh** |                  |        |          |         |
+===================+==================+========+==========+=========+
| >                 | > *\<password\>* |        |          |         |
| oracle\@host02\'s |                  |        |          |         |
| > password:       |                  |        |          |         |
+-------------------+------------------+--------+----------+---------+
| >                 | 100%             | > 1718 | 1.6MB/s  | > 00:00 |
| initorclcdbFS.ora |                  |        |          |         |
+-------------------+------------------+--------+----------+---------+
| >                 | > *\<password\>* |        |          |         |
| oracle\@host02\'s |                  |        |          |         |
| > password:       |                  |        |          |         |
+-------------------+------------------+--------+----------+---------+
| > orclcdbFS.ctl   | 100%             | > 18MB | 33.5MB/s | > 00:00 |
+-------------------+------------------+--------+----------+---------+
| >                 | > *\<password\>* |        |          |         |
| oracle\@host02\'s |                  |        |          |         |
| > password:       |                  |        |          |         |
+-------------------+------------------+--------+----------+---------+
| > orapworclcdb    | 100%             | > 2560 | 2.6MB/s  | > 00:00 |
+-------------------+------------------+--------+----------+---------+
| > \[              |                  |        |          |         |
| oracle\@localhost |                  |        |          |         |
| > \~\]\$          |                  |        |          |         |
+-------------------+------------------+--------+----------+---------+

5.  Open a terminal window for host02 logged in as oracle with the
    environment variables set to orclcdbFS. Create the initial
    directories needed on the Far Sync server. These are the same
    directories that were created on the physical standby server stndby
    in practice 3-2.

> **Note:** Linux directory and file names are case sensitive.
> Throughout these labs, the names for Far Sync use the format orclcdbFS
> and stndbyFS for readability. The last 2 letters are in upper-case.

a.  The entry for log\_archive\_dest\_2 uses the valid\_for option
    assuming it has the role of primary database. On the Far Sync, this
    needs to use the role of a standby database. Also the Far Sync
    should use ASYNC communication to the physical standby environment.
    Correct the log\_archive\_dest\_2 parameter to the following value
    (Changes to make in bold):

b.  The original control files are named control01.ctl and
    control02.ctl. We will rename these orclcdbFS01.ctl and
    orclcdbFS02.ctl, respectively. This is for preference only since
    these files are not normal control files. Both changes can be made
    with the following global search and replace:

c.  Add the following new entries to the bottom of the file.

d.  Remove or comment out the LOCAL\_LISTENER entry if it exists with
    the value.

e.  Recheck all modifications and case-sensitivity issues. If accurate,
    then save the changes made to the file.

f.  The complete edited file is listed below for reference. Bold entries
    indicate changes that were made.

> \[oracle\@host02 \~\]\$ **cat /tmp/initorclcdbFS.ora** orclcdbFS. [
> ]{.underline} data\_transfer\_cache\_size=0 orclcdbFS. [ ]{.underline}
> db\_cache\_size=46137344
>
> orclcdbFS. [ ]{.underline} java\_pool\_size=12582912 orclcdbFS. [
> ]{.underline} large\_pool\_size=12582912
>
> orclcdbFS. [ ]{.underline}
> oracle\_base=\'/u01/app/oracle\'\#ORACLE\_BASE set from environment
>
> orclcdbFS. [ ]{.underline} pga\_aggregate\_target=209715200 orclcdbFS.
> [ ]{.underline} sga\_target=310378496
>
> orclcdbFS. [ ]{.underline} shared\_io\_pool\_size=4194304 orclcdbFS. [
> ]{.underline} shared\_pool\_size=226492416 orclcdbFS. [ ]{.underline}
> streams\_pool\_size=0
>
> \*.audit\_file\_dest=\'/u01/app/oracle/admin/**orclcdbFS**/adump\'
>
> \*.audit\_trail=\'db\'
>
> \*.compatible=\'12.1.0.0.0\'
>
> \*.control\_files=\'/u01/app/oracle/oradata/**orclcdbFS**/**orclcdbFS01**.ctl
> \',\'/u01/app/oracle/fast\_recovery\_area/**orclcdbFS**/**orclcdbFS02**.ctl\'
>
> \*.db\_block\_size=8192
>
> \*.db\_domain=\'example.com\'
>
> \*.db\_name=\'**orclcdb**\'
>
> \*.db\_recovery\_file\_dest=\'/u01/app/oracle/fast\_recovery\_area\'
>
> \*.db\_recovery\_file\_dest\_size=10g
>
> \*.diagnostic\_dest=\'/u01/app/oracle\'
>
> \*.log\_archive\_config=\'dg\_config=(**orclcdb**,**orclcdbFS**,stndby,stndbyFS
>
> ,stndby2)\'
>
> \*.log\_archive\_dest\_1=\'location=USE\_DB\_RECOVERY\_FILE\_DEST
> valid\_for=(ALL\_LOGFILES,ALL\_ROLES) db\_unique\_name=**orclcdbFS**\'
>
> \*.log\_archive\_dest\_2=\'SERVICE=stndby **ASYNC** REOPEN=15
> valid\_for=(**STANDBY\_LOGFILES,STANDBY\_ROLE**)
> db\_unique\_name=stndby\'
>
> \*.log\_archive\_dest\_state\_1=\'enable\'
>
> \*.log\_archive\_format=\'arch\_%t\_%s\_%r.log\'
>
> \*.log\_archive\_max\_processes=4
>
> \*.memory\_target=496m
>
> \*.open\_cursors=300
>
> \*.processes=300
>
> \*.remote\_login\_passwordfile=\'EXCLUSIVE\'
>
> \*.standby\_file\_management=\'auto\'
>
> \*.undo\_tablespace=\'UNDOTBS1\'

#### \*.db\_unique\_name=orclcdb

6.  Copy the /tmp/orclcdbFS.ctl Far Sync control file to the two
    destination directories used in the initialization parameter file.
    Rename the files to the correct name while copying them.

7.  Copy the password file staged into the /tmp directory to the default
    location of Far Sync instance. Rename the file appropriately while
    copying it.

8.  Verify that the environment variables are defined for orclcdbFS. If
    they are not, then use the oraenv utility to set them if needed.

9.  Use SQL\*Plus to create a binary server parameter file from the text
    parameter file. Create the server parameter file into the default
    directory.

10. Start up the Far Sync instance in MOUNT mode.

11. Use a terminal window on localhost logged in as oracle with the
    environment variables set to orclcdb, the primary database. Launch
    SQL\*plus and examine the current value of log\_archive\_dest\_2.

12. The primary is currently forwarding redo to the physical standby
    database. Alter the primary database to now forward redo to the Far
    Sync instance instead of the physical standby database. Be sure to
    make the corrections both in memory and written to the server
    parameter file.

13. Determine the most recently archived redo log on the primary
    database. Perform a log switch, and verify the next sequence number
    used.

14. Use the previous SQL\*Plus session for host02 logged in as oracle
    with the environment variables set to orclcdbFS, the Far Sync.
    Verify that the last sequence number of the primary was received on
    the Far Sync.

15. Open a terminal window on stndby logged in as oracle with the
    environment variables set to stndby. Launch SQL\*Plus and verify
    that the physical standby on stndby is receiving redo from the Far
    Sync on host02.

16. Exit all SQL\*Plus sessions from localhost, host02, and stndby.
    Leave the terminal sessions open with the environment variables set
    for each system.

17. Verify on the Far Sync server, host02, that the standby redo logs
    were automatically created.

Practice 6-2: Add 2nd Far Sync to the Data Guard Environment
------------------------------------------------------------

### Overview -- DO NOT PERFORM as we do not have another host. For Read Only

> In this practice, you will create an additional Far Sync instance
> (stndbyFS) on host04 that is in close proximity to the physical
> standby database. This will be used in future practices that perform
> role reversal. With a role reversal, the stndby instance on stndby
> will become the primary database. It will need to forward redo to
> stndbyFS Far Sync on host04.
>
> In the practice, we copied a Far Sync control file, initialization
> parameter file, and password file to the /tmp directory on host02. We
> will start with these files and copy them to host04 since they were
> already edited for a Far Sync environment.

### Tasks

1.  Use a terminal window for host02 logged in as oracle with the
    environment variables set to orclcdbFS. Copy the three files staged
    in /tmp to host04.

> \[oracle\@host02 \~\]\$ **. oraenv**
>
> ORACLE\_SID = \[oracle\] ? **orclcdbFS**
>
> The Oracle base has been set to /u01/app/oracle \[oracle\@host02
> \~\]\$
>
> \[oracle\@host02 \~\]\$ **cat /home/oracle/setup/copy\_stndbyFS.sh**
>
> \...
>
> scp /tmp/orclcdbFS.ctl oracle\@host04:/tmp
>
> scp /tmp/initorclcdbFS.ora oracle\@host04:/tmp scp /tmp/orapworclcdb
> oracle\@host04:/tmp
>
> \[oracle\@host02 \~\]\$ **/home/oracle/setup/copy\_stndbyFS.sh**
>
> /home/oracle/setup/copy\_stndbyFS.sh
>
> The authenticity of host \'host04 (192.0.2.14)\' can\'t be
> established.
>
> ECDSA key fingerprint is
> SHA256:JKkb1E9vmYSa8YTFMVqZGa/vXENSXcCJJehEX+UdHfA.
>
> ECDSA key fingerprint is
> MD5:74:b9:98:32:37:24:52:3d:f7:a8:12:ac:38:c3:c8:94.
>
> Are you sure you want to continue connecting (yes/no)? **yes**
>
> Warning: Permanently added \'host04,192.0.2.14\' (ECDSA) to the list
> of known hosts.\"
>
> oracle\@host04\'s password: *\<password\>*
>
> orclcdbFS.ctl 100% 18MB 52.9MB/s 00:00 oracle\@host04\'s password:
> *\<password\>*
>
> initorclcdbFS.ora 100% 1851 19.0KB/s 00:00 oracle\@host04\'s password:
> *\<password\>*
>
> orapworclcdb 100% 2560 239.8KB/s 00:00 \[oracle\@host02 \~\]\$

2.  Open a new terminal window for host04 logged in as oracle with the
    environment variables set to stndbyFS. Create the initial
    directories needed on the Far Sync server. These are the same
    directories that were created on the physical standby server stndby
    in practice 3-2.

> **Note:** Linux directory and file names are case-sensitive.
> Throughout these labs, the names for Far Sync use the format orclcdbFS
> and stndbyFS for readability. The last two letters are in uppercase.

3.  Rename the /tmp/initorclcdbFS.ora file /tmp/initstndbyFS.ora. You
    will need to make changes to the initialization parameters to
    reflect the name change from orclcdb to stndby. You will also need
    to make adjustments for control file name changes and directory name
    changes.

    a.  Globally, search and replace all occurrences of orclcdb with
        stndby

    b.  Three of the substitutions from the global search and replace
        are incorrect and need to be reverted to their original value.
        Continue editing the file to locate and correct db\_name,
        log\_archive\_config, and log\_file\_name\_convert entries. Ask
        your instructor for assistance if you need help with VI syntax.
        Remember to always use the \<ESC\> key before starting a new VI
        command option.

    c.  The entry for log\_archive\_dest\_2 is defined for a standby
        database role to ship redo to the stndby service. If stndby
        becomes the primary database, then the stndbyFS Far Sync should
        ship redo to orclcdb, which will become the standby database
        after role reversal. Correct the values for this parameter.
        (Changes are shown in bold.)

    d.  Recheck all modifications and case-sensitivity issues. If
        accurate, then save the changes made to the file. Less changes
        were needed since we started with a modified file.

    e.  The complete edited file is listed below for reference. Bold
        entries indicate changes that were made.

> \[oracle\@host04 \~\]\$ **cat /tmp/initstndbyFS.ora stndbyFS**. [
> ]{.underline} data\_transfer\_cache\_size=0 **stndbyFS**. [
> ]{.underline} db\_cache\_size=46137344
>
> **stndbyFS**. [ ]{.underline} java\_pool\_size=12582912 **stndbyFS**.
> [ ]{.underline} large\_pool\_size=12582912
>
> **stndbyFS**. [ ]{.underline}
> oracle\_base=\'/u01/app/oracle\'\#ORACLE\_BASE set from environment
>
> **stndbyFS**. [ ]{.underline} pga\_aggregate\_target=209715200
> **stndbyFS**. [ ]{.underline} sga\_target=310378496
>
> **stndbyFS**. [ ]{.underline} shared\_io\_pool\_size=4194304
>
> **stndbyFS**. [ ]{.underline} shared\_pool\_size=226492416
> **stndbyFS**. [ ]{.underline} streams\_pool\_size=0
>
> \*.audit\_file\_dest=\'/u01/app/oracle/admin/**stndbyFS**/adump\'
>
> \*.audit\_trail=\'db\'
>
> \*.compatible=\'12.1.0.0.0\'
>
> \*.control\_files=\'/u01/app/oracle/oradata/**stndbyFS**/**stndbyFS01**.ctl
> \',\'/u01/app/oracle/fast\_recovery\_area/**stndbyFS**/**stndbyFS02**.ctl\'
>
> \*.db\_block\_size=8192
>
> \*.db\_domain=\'example.com\'
>
> \*.db\_name=\'**orclcdb**\'
>
> \*.db\_recovery\_file\_dest=\'/u01/app/oracle/fast\_recovery\_area\'
>
> \*.db\_recovery\_file\_dest\_size=10g
>
> \*.diagnostic\_dest=\'/u01/app/oracle\'
>
> \*.dispatchers=\'(PROTOCOL=TCP) (SERVICE=**stndbyFS**XDB)\'
>
> \*.enable\_pluggable\_database=true
>
> **\#**\*.local\_listener=\'LISTENER\_stndbyFS\'
>
> \*.log\_archive\_config=\'dg\_config=(**orclcdb,orclcdbFS,stndby,stndbyFS**

#### ,stndby2)\'

> \*.log\_archive\_dest\_1=\'location=USE\_DB\_RECOVERY\_FILE\_DEST
> valid\_for=(ALL\_LOGFILES,ALL\_ROLES) db\_unique\_name=**stndbyFS**\'

4.  Copy the /tmp/orclcdbFS.ctl Far Sync control file to the two
    destination directories used in the initialization parameter file.
    Rename the files to the correct name while copying them.

5.  Copy the password file staged into the /tmp directory to the default
    location of Far Sync instance. Rename the file appropriately while
    copying it.

6.  Verify that the environment variables are defined for stndbyFS. If
    they are not, then use the oraenv utility to set them if needed.

7.  Use SQL\*Plus to create a binary server parameter file from the text
    parameter file. Create the server parameter file into the default
    directory.

8.  Start up the Far Sync instance in MOUNT mode. Leave SQL\*Plus
    session open when done.

9.  Use a terminal window on stndby logged in as oracle with the
    environment variables set to stndby, the physical standby database.
    Launch SQL\*plus and examine the current value of
    log\_archive\_dest\_2.

10. The log\_archive\_dest\_2 parameter of the stndby physical standby
    instance is not currently defined because it is a terminal
    destination. After role reversals, it would become the primary
    database. At that time, it should forward redo to the stndbyFS Far
    Sync. Modify the log\_archive\_dest\_2 parameter so that it forwards
    redo accordingly.

> **Note:** At this point in the labs, the stndbyFS Far Sync has been
> started, but it is not currently used. It will be tested after
> switchover exercises are performed in future labs.

11. Exit all SQL\*Plus sessions from localhost, host02, stndby, and
    host04 if they are still open. Leave the terminal sessions open with
    the environment variables set for each system.

Practices for Lesson 7: Creating and Managing a Snapshot Standby Database
=========================================================================

Practices for Lesson 7: Overview
--------------------------------

### Practices Overview

> In these practices, you will convert the physical standby database to
> a snapshot database and open it for read-write operations. You will
> create new schema objects in the database to verify the success of
> creating the snapshot. Finally, you will convert it back into a
> physical standby database, discarding the schema objects that were
> created.

Practice 7-1: Convert Physical Standby to a Snapshot Standby
------------------------------------------------------------

### Overview

> In this practice, you will convert the stndby physical standby
> database to a snapshot standby database.

### Tasks

1.  Use a terminal window logged in as oracle to stndby with the
    environment variables set for stndby appropriately. Launch SQL\*Plus
    and verify that the current database role is physical stand.

2.  Verify that flashback database is turned off, and show the default
    value for the flashback retention target. SQL\> show parameter
    db\_flashback

+------------------------------------+---+-----------+---+---------+
| > NAME                             |   | > TYPE    |   | > VALUE |
+====================================+===+===========+===+=========+
| > db\_flashback\_retention\_target |   | > integer |   | > 1440  |
+------------------------------------+---+-----------+---+---------+

3.  Display the values for the two initialization parameters that define
    the Fast Recovery Area.

Sql\> show parameter recovery

4.  Display the current file types, number of files for each type, and
    percentage of space utilization per file type for the Fast Recovery
    Area.

> **Note:** Your output varies.

SQL\> select file\_type, number\_of\_files, percent\_space\_used from

V\$recovery\_area\_usage;

+------------------+-------+---+-------------------+---+----------------------+
| FILE\_TYPE       |       |   | NUMBER\_OF\_FILES |   | PERCENT\_SPACE\_USED |
+==================+=======+===+===================+===+======================+
| CONTROL FILE     |       |   | 0                 |   | 0                    |
+------------------+-------+---+-------------------+---+----------------------+
| REDO LOG         |       |   | 0                 |   | 0                    |
+------------------+-------+---+-------------------+---+----------------------+
| ARCHIVED LOG     |       |   | 4                 |   | .15                  |
+------------------+-------+---+-------------------+---+----------------------+
| BACKUP PIECE     |       |   | 0                 |   | 0                    |
+------------------+-------+---+-------------------+---+----------------------+
| IMAGE COPY       |       |   | 0                 |   | 0                    |
+------------------+-------+---+-------------------+---+----------------------+
| FLASHBACK LOG    |       |   | 0                 |   | 0                    |
+------------------+-------+---+-------------------+---+----------------------+
| FOREIGN ARCHIVED | > LOG |   | 0                 |   | 0                    |
+------------------+-------+---+-------------------+---+----------------------+

SQL\> select name, open\_mode, database\_role from v\$database

5.  Attempt to convert the physical standby database to a snapshot
    standby database.

6.  Cancel redo apply on the physical standby database and reattempt to
    convert the physical standby database to a snapshot standby
    database.

```{=html}
<!-- -->
```
a.  Shutdown immediate stndby

b.  Startup mount

c.  **alter database convert to snapshot standby**;

d.  alter database open

```{=html}
<!-- -->
```
7.  Display the current database role.

SQ\> select name, open\_mode, database\_role from v\$database

8.  Verify that flashback database was automatically enabled when the
    physical standby was converted to a snapshot standby.

9.  Display the name of the guaranteed restore point that was created
    and its current storage size.

10. Display the current open mode for the snapshot standby.

11. Verify that a flashback log was automatically created in the
    Recovery Area.

> **Note:** Your output varies, but you should see one or more flashback
> logs.

+----------------+----------------+---+----------------+------------+
| > SQL\>        | **number       |   | **percent\     | > **from** |
| > **select     | \_of\_files,** |   | _space\_used** |            |
| > file\_type,  |                |   |                |            |
| >              |                |   |                |            |
|  v\$recovery\_ |                |   |                |            |
| area\_usage;** |                |   |                |            |
+================+================+===+================+============+
| > FILE\_TYPE   | NUM            |   | PERCEN         |            |
|                | BER\_OF\_FILES |   | T\_SPACE\_USED |            |
+----------------+----------------+---+----------------+------------+
| > CONTROL FILE | 0              |   | 0              |            |
+----------------+----------------+---+----------------+------------+
| > REDO LOG     | 0              |   | 0              |            |
+----------------+----------------+---+----------------+------------+
| > ARCHIVED LOG | 4              |   | .15            |            |
+----------------+----------------+---+----------------+------------+
| > BACKUP PIECE | 0              |   | 0              |            |
+----------------+----------------+---+----------------+------------+
| > IMAGE COPY   | 0              |   | 0              |            |
+----------------+----------------+---+----------------+------------+
| > FLASHBACK    | 2              |   | .98            |            |
| > LOG          |                |   |                |            |
+----------------+----------------+---+----------------+------------+
| > FOREIGN      | 0              |   | 0              |            |
| > ARCHIVED LOG |                |   |                |            |
+----------------+----------------+---+----------------+------------+
| > AUXILIARY    | 0              |   | 0              |            |
| > DATAFILE     |                |   |                |            |
| > COPY         |                |   |                |            |
+----------------+----------------+---+----------------+------------+
| > 8 rows       |                |   |                |            |
| > selected.    |                |   |                |            |
+----------------+----------------+---+----------------+------------+

12. Attempt to convert the snapshot standby back to a physical standby.

> **Note:** Even though the command in step 6 succeeded in converting
> the physical standby into a snapshot standby, it must be opened into
> read-write mode at least one time before you can reverse the operation
> back to a physical standby. The purpose of this example is to show
> what happens if you changed your mind and wanted to convert back to a
> physical standby without proceeding.

13. Open the snapshot database and verify that it has been opened in
    read-write mode.

14. Switch the container to the DEV1 PDB for the session. Even though
    the container is open, the DEV1 PDB is mounted. Open the DEV1 PDB,
    and create a miscellaneous table. Insert 1 row into the table and
    commit the result. Return to the root container when done.

15. In step 6, managed recovery was stopped for the snapshot database.
    Use a terminal window logged in as oracle to localhost to with the
    environment variables set for orclcdb appropriately. Determine the
    last archived redo log for the primary database and perform a log
    switch. Exit SQL\*Plus when done.datadat

16. Return to the SQL\*Plus session on stndby and verify that the
    snapshot standby is still receiving redo from the primary database,
    forwarded to the Far Sync, and then to the snapshot standby. The
    sequence number should be the next one after the number displayed on
    the primary database in the previous step.

Practice 7-2: Convert Snapshot Standby Back to Physical Standby
---------------------------------------------------------------

### Overview

> In this practice, you convert the snapshot standby back into a
> physical standby database.

### Tasks

1.  Use the terminal session connected to stndby or if using container
    cdbstby. Attempt to convert the snapshot standby back into a
    physical standby.

2.  Shut down the snapshot standby and start it back up in MOUNT mode.

3.  Reattempt to convert the snapshot standby back into a physical
    standby.

4.  Verify that flashback has been turned off, and the flashback log was
    deleted freeing up space in the flash recovery area.

+------------------+-------+---+-------------------+---+----------------------+
| FILE\_TYPE       |       |   | NUMBER\_OF\_FILES |   | PERCENT\_SPACE\_USED |
+==================+=======+===+===================+===+======================+
| CONTROL FILE     |       |   | 0                 |   | 0                    |
+------------------+-------+---+-------------------+---+----------------------+
| REDO LOG         |       |   | 0                 |   | 0                    |
+------------------+-------+---+-------------------+---+----------------------+
| ARCHIVED LOG     |       |   | 5                 |   | .19                  |
+------------------+-------+---+-------------------+---+----------------------+
| BACKUP PIECE     |       |   | 1                 |   | .17                  |
+------------------+-------+---+-------------------+---+----------------------+
| IMAGE COPY       |       |   | 0                 |   | 0                    |
+------------------+-------+---+-------------------+---+----------------------+
| FLASHBACK LOG    |       |   | 0                 |   | 0                    |
+------------------+-------+---+-------------------+---+----------------------+
| FOREIGN ARCHIVED | > LOG |   | 0                 |   | 0                    |
+------------------+-------+---+-------------------+---+----------------------+

5.  Open the container database to enable Active Data Guard, and then
    switch the session to the DEV1 pluggable database. Open the DEV1
    PDB.

6.  Attempt to query the MISC1 table that was created, and verify that
    the table no longer exists after converting the snapshot standby
    back into a physical standby database.

7.  Return the session back to the container root. Shut down the
    physical standby to disable Active Data Guard. Start in back up in
    the MOUNT state and restart Redo Apply.

8.  Exit SQL\*Plus on any host machine in which it is open. Do not close
    the terminal sessions.

Practices for Lesson 8: Creating a Logical Standby Database
===========================================================

Practices for Lesson 8: Overview
--------------------------------

### Practices Overview

> In these practices, you will prepare stndby to create a logical
> standby database. You will use the RMAN utility to create the physical
> standby database and then verify its operation.

Practice 8-1: Identify Unsupported Objects for Logical Standbys
---------------------------------------------------------------

### Overview

> In this practice, you will examine the primary database to determine
> which objects will not be supported in a logical standby.

### Tasks

1.  Use a terminal window on localhost connected as oracle with the
    environment variables set to orcl2. Start SQL\*Plus and verify that
    all pluggable databases are open for queries. If any pluggable
    database is mounted or shut down, the queries that follow this step
    will not return complete results.

2.  Find all tables across all PDBs without unique logical identifiers
    in the primary database. This query will take a few minutes to run.

> **Note:** This query differs from the one listed in the product
> documentation. It has been modified to examine schema objects across
> all PDBs.

3.  Identify the internal schemas that ship with the Oracle Database.
    Any user-defined table created into these schemas will not be
    replicated on the logical standby database. Also, those user-defined
    tables will not show up in the DBA\_LOGSTDBY\_UNSUPPORTED or
    CDB\_LOGSTDBY\_UNSUPPORTED views of step 4, even though they are
    unsupported.

> **Note:** This query differs from the one listed in the product
> documentation. It has been modified to examine schema objects across
> all PDBs.

4.  Identify tables that do not belong to internal schemas and that will
    not be maintained by SQL Apply because of unsupported data types.

5.  View the column names and data types that conflict with SQL Apply.
    Exit SQL\*Plus when done.

Practice 8-2: Create a Logical Standby (Temporarily a Physical)
---------------------------------------------------------------

### Overview

> In this practice, you will prepare stndby2 to receive the logical
> standby database and create the logical standby database using RMAN
> and SQL.

### Tasks

> 1\. Use a terminal logged in as oracle to orcl2. Edit the script
> crdir\_stndby.sh scripts so that it references stndby2 then Run the
> crdir\_stndby.sh script or manually create the dierctories required.
> The script will complete all preparation steps and next we will create
> the stndby2 standby database.
>
> ![](media/image9.png){width="5.998611111111111in"
> height="6.547916666666667in"}**Note:** We already performed similar
> tasks in practice 3-2. So, we leverage the script to
>
> SQL\*Plus: Release 19.0.0.0.0 - Production on Thu Jun 4 12:50:16 2020
>
> Version 19.3.0.0.0
>
> \(c\) 1982, 2019, Oracle. All rights reserved. Connected to an idle
> instance.
>
> SQL\> ORACLE instance started.show
>
> exi
>
> Total System Global Area 268434280 bytes Fixed Size 8895336 bytes
> Variable Size 201326592 bytes Database Buffers 50331648 bytes
>
> Redo Buffers 7880704 bytes
>
> SQL\> Disconnected from Oracle Database 19c Enterprise Edition Release
> 19.0.0.0.0 - Production
>
> Version 19.3.0.0.0 \#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#
>
> Task 5: Create stndby2 STANDBY DB
> \#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#

1.  Edit initstndby2.ora file and change all occurrences

> Of stndby to stndby2.
>
> Recovery Manager: Release 19.0.0.0.0 - Production on Thu Jun 4
> 12:50:24 2020
>
> Version 19.3.0.0.0

2.  connected to target database via RMAN as shown below:

> RMAN target sys/fenago\@orcl2 auxiliary sys/fenago\@stndby2
>
> RMAN\> (DBID=2732274290) connected to auxiliary database: STNDBY2 (not
> mounted)

3.  Execute the following command to create stndby2/

> RMAN\> duplicate target database for standby from active database ;
>
> }
>
> using target database control file instead of recovery catalog
> allocated channel: prmy1
>
> channel prmy1: SID=42 device type=DISK
>
> allocated channel: stndby2
>
> channel stndby2: SID=20 device type=DISK Starting Duplicate Db at
> 04-JUN-20
>
> contents of Memory Script:
>
> {
>
> backup as copy reuse passwordfile auxiliary format
>
> \'/u01/app/oracle/product/19.3.0/dbhome\_1/dbs/orapwstndby2\' ;
> restore clone from service \'orclcdb\' spfile to
>
> \'/u01/app/oracle/product/19.3.0/dbhome\_1/dbs/spfilestndby2.ora\'
>
> ;
>
> sql clone \"alter system set spfile=
> \'\'/u01/app/oracle/product/19.3.0/dbhome\_1/dbs/spfilestndby2.ora
> \'\'\";
>
> }
>
> executing Memory Script
>
> Starting backup at 04-JUN-20 Finished backup at 04-JUN-20
>
> Starting restore at 04-JUN-20
>
> channel stndby2: starting datafile backup set restore
>
> channel stndby2: using network backup set from service orclcdb channel
> stndby2: restoring SPFILE
>
> output file
> name=/u01/app/oracle/product/19.3.0/dbhome\_1/dbs/spfilestndby2. ora
>
> channel stndby2: restore complete, elapsed time: 00:00:01 Finished
> restore at 04-JUN-20
>
> sql statement: alter system set spfile=
> \'\'/u01/app/oracle/product/19.3.0/dbhome\_1/dbs/spfilestndby2.ora
> \'\'
>
> contents of Memory Script:
>
> {
>
> sql clone \"alter system set audit\_file\_dest =
> \'\'/u01/app/oracle/admin/stndby2/adump\'\' comment= \'\'\'\'
> scope=spfile\";
>
> sql clone \"alter system set control\_files =
>
> \'\'/u01/app/oracle/oradata/stndby2/control01.ctl\'\',
> \'\'/u01/app/oracle/fast\_recovery\_area/stndby2/control02.ctl\'\'
> comment=
>
> \'\'\'\' scope=spfile\";
>
> sql clone \"alter system set dispatchers = \'\'(PROTOCOL=TCP)
> (SERVICE=stndby2XDB)\'\' comment=
>
> \'\'\'\' scope=spfile\";
>
> sql clone \"alter system set local\_listener =
> \'\'LISTENER\_stndby2\'\' comment=
>
> \'\'\'\' scope=spfile\";
>
> sql clone \"alter system set db\_name = \'\'orclcdb\'\' comment=
>
> \'\'\'\' scope=spfile\";
>
> sql clone \"alter system set db\_unique\_name = \'\'stndby2\'\'
> comment=
>
> \'\'\'\' scope=spfile\";
>
> sql clone \"alter system set db\_file\_name\_convert =
> \'\'ORCLCDB\'\', \'\'stndby2\'\' comment=
>
> \'\'\'\' scope=spfile\";
>
> sql clone \"alter system set log\_file\_name\_convert =
> \'\'ORCLCDB\'\', \'\'stndby2\'\' comment=
>
> \'\'\'\' scope=spfile\";
>
> sql clone \"alter system set fal\_server = \'\'orclcdb\'\' comment=
>
> \'\'\'\' scope=spfile\";
>
> sql clone \"alter system set log\_archive\_dest\_1 =
> \'\'location=USE\_DB\_RECOVERY\_FILE\_DEST
>
> valid\_for=(ALL\_LOGFILES,ALL\_ROLES) db\_unique\_name=stndby2\'\'
> comment=
>
> \'\'\'\' scope=spfile\"; shutdown clone immediate; startup clone
> nomount;
>
> }
>
> executing Memory Script
>
> sql statement: alter system set audit\_file\_dest =
> \'\'/u01/app/oracle/admin/stndby2/adump\'\' comment= \'\'\'\'
> scope=spfile
>
> sql statement: alter system set control\_files =
> \'\'/u01/app/oracle/oradata/stndby2/control01.ctl\'\',
> \'\'/u01/app/oracle/fast\_recovery\_area/stndby2/control02.ctl\'\'
> comment= \'\'\'\' scope=spfile
>
> sql statement: alter system set dispatchers = \'\'(PROTOCOL=TCP)
> (SERVICE=stndby2XDB)\'\' comment= \'\'\'\'
>
> scope=spfile
>
> sql statement: alter system set local\_listener =
> \'\'LISTENER\_stndby2\'\' comment= \'\'\'\' scope=spfile
>
> sql statement: alter system set db\_name = \'\'orclcdb\'\' comment=
> \'\'\'\' scope=spfile
>
> sql statement: alter system set db\_unique\_name = \'\'stndby2\'\'
> comment= \'\'\'\' scope=spfile
>
> sql statement: alter system set db\_file\_name\_convert =
> \'\'ORCLCDB\'\', \'\'stndby2\'\' comment= \'\'\'\' scope=spfile
>
> sql statement: alter system set log\_file\_name\_convert =
> \'\'ORCLCDB\'\', \'\'stndby2\'\' comment= \'\'\'\' scope=spfile
>
> sql statement: alter system set fal\_server = \'\'orclcdb\'\' comment=
> \'\'\'\' scope=spfile
>
> sql statement: alter system set log\_archive\_dest\_1 =
> \'\'location=USE\_DB\_RECOVERY\_FILE\_DEST
> valid\_for=(ALL\_LOGFILES,ALL\_ROLES) db\_unique\_name=stndby2\'\'
> comment= \'\'\'\' scope=spfile
>
> Oracle instance shut down
>
> connected to auxiliary database (not started) Oracle instance started
>
> Total System Global Area 629145352 bytes
>
> Fixed Size 9137928 bytes Variable Size 188743680 bytes
>
> Database Buffers 423624704 bytes Redo Buffers 7639040 bytes allocated
> channel: stndby2
>
> channel stndby2: SID=255 device type=DISK
>
> contents of Memory Script:
>
> {
>
> restore clone from service \'orclcdb\' standby controlfile;
>
> }
>
> executing Memory Script Starting restore at 04-JUN-20
>
> channel stndby2: starting datafile backup set restore
>
> channel stndby2: using network backup set from service orclcdb channel
> stndby2: restoring control file
>
> channel stndby2: restore complete, elapsed time: 00:00:02
>
> output file name=/u01/app/oracle/oradata/stndby2/control01.ctl
>
> output file
> name=/u01/app/oracle/fast\_recovery\_area/stndby2/control02.ctl
>
> Finished restore at 04-JUN-20
>
> contents of Memory Script:
>
> {
>
> sql clone \'alter database mount standby database\';
>
> }
>
> executing Memory Script
>
> sql statement: alter database mount standby database contents of
> Memory Script:
>
> {
>
> set newname for tempfile 1 to
> \"/u01/app/oracle/oradata/stndby2/temp01.dbf\";
>
> set newname for tempfile 2 to
>
> \"/u01/app/oracle/oradata/stndby2/pdbseed/temp012020-06-02\_14-
> 25-16-052-PM.dbf\";
>
> set newname for tempfile 3 to
> \"/u01/app/oracle/oradata/stndby2/dev1/temp01.dbf\";
>
> switch clone tempfile all; set newname for datafile 1 to
>
> \"/u01/app/oracle/oradata/stndby2/system01.dbf\"; set newname for
> datafile 3 to
>
> \"/u01/app/oracle/oradata/stndby2/sysaux01.dbf\"; set newname for
> datafile 4 to
>
> \"/u01/app/oracle/oradata/stndby2/undotbs01.dbf\"; set newname for
> datafile 5 to
>
> \"/u01/app/oracle/oradata/stndby2/pdbseed/system01.dbf\"; set newname
> for datafile 6 to
>
> \"/u01/app/oracle/oradata/stndby2/pdbseed/sysaux01.dbf\"; set newname
> for datafile 7 to
>
> \"/u01/app/oracle/oradata/stndby2/users01.dbf\"; set newname for
> datafile 8 to
>
> \"/u01/app/oracle/oradata/stndby2/pdbseed/undotbs01.dbf\"; set newname
> for datafile 9 to
>
> \"/u01/app/oracle/oradata/stndby2/dev1/system01.dbf\"; set newname for
> datafile 10 to
>
> \"/u01/app/oracle/oradata/stndby2/dev1/sysaux01.dbf\"; set newname for
> datafile 11 to
>
> \"/u01/app/oracle/oradata/stndby2/dev1/undotbs01.dbf\"; set newname
> for datafile 12 to
>
> \"/u01/app/oracle/oradata/stndby2/dev1/users01.dbf\"; restore
>
> from nonsparse from service \'orclcdb\' clone database
>
> ;
>
> sql \'alter system archive log current\';
>
> }
>
> executing Memory Script executing command: SET NEWNAME executing
> command: SET NEWNAME executing command: SET NEWNAME
>
> renamed tempfile 1 to
>
> /u01/app/oracle/oradata/stndby2/temp01.dbf in control file
>
> renamed tempfile 2 to
>
> /u01/app/oracle/oradata/stndby2/pdbseed/temp012020-06-02\_14-25-
> 16-052-PM.dbf in control file
>
> renamed tempfile 3 to
>
> /u01/app/oracle/oradata/stndby2/dev1/temp01.dbf in control file
>
> executing command: SET NEWNAME executing command: SET NEWNAME
> executing command: SET NEWNAME executing command: SET NEWNAME
> executing command: SET NEWNAME executing command: SET NEWNAME
> executing command: SET NEWNAME executing command: SET NEWNAME
> executing command: SET NEWNAME executing command: SET NEWNAME
> executing command: SET NEWNAME Starting restore at 04-JUN-20
>
> channel stndby2: starting datafile backup set restore channel stndby2:
> using network backup set from service orclcdb
>
> channel stndby2: specifying datafile(s) to restore from backup set
>
> channel stndby2: restoring datafile 00001 to
>
> /u01/app/oracle/oradata/stndby2/system01.dbf
>
> channel stndby2: restore complete, elapsed time: 00:00:38 channel
> stndby2: starting datafile backup set restore
>
> channel stndby2: using network backup set from service orclcdb
>
> channel stndby2: specifying datafile(s) to restore from backup set
>
> channel stndby2: restoring datafile 00003 to
>
> /u01/app/oracle/oradata/stndby2/sysaux01.dbf
>
> channel stndby2: restore complete, elapsed time: 00:00:25 channel
> stndby2: starting datafile backup set restore
>
> channel stndby2: using network backup set from service orclcdb
>
> channel stndby2: specifying datafile(s) to restore from backup set
>
> channel stndby2: restoring datafile 00004 to
>
> /u01/app/oracle/oradata/stndby2/undotbs01.dbf
>
> channel stndby2: restore complete, elapsed time: 00:00:07 channel
> stndby2: starting datafile backup set restore
>
> channel stndby2: using network backup set from service orclcdb
>
> channel stndby2: specifying datafile(s) to restore from backup set
>
> channel stndby2: restoring datafile 00005 to
>
> /u01/app/oracle/oradata/stndby2/pdbseed/system01.dbf channel stndby2:
> restore complete, elapsed time: 00:00:15 channel stndby2: starting
> datafile backup set restore channel stndby2: using network backup set
> from service orclcdb
>
> channel stndby2: specifying datafile(s) to restore from backup set
>
> channel stndby2: restoring datafile 00006 to
>
> /u01/app/oracle/oradata/stndby2/pdbseed/sysaux01.dbf channel stndby2:
> restore complete, elapsed time: 00:00:07 channel stndby2: starting
> datafile backup set restore
>
> channel stndby2: using network backup set from service orclcdb
>
> channel stndby2: specifying datafile(s) to restore from backup set
>
> channel stndby2: restoring datafile 00007 to
>
> /u01/app/oracle/oradata/stndby2/users01.dbf
>
> channel stndby2: restore complete, elapsed time: 00:00:02 channel
> stndby2: starting datafile backup set restore
>
> channel stndby2: using network backup set from service orclcdb
>
> channel stndby2: specifying datafile(s) to restore from backup set
>
> channel stndby2: restoring datafile 00008 to
>
> /u01/app/oracle/oradata/stndby2/pdbseed/undotbs01.dbf channel stndby2:
> restore complete, elapsed time: 00:00:03 channel stndby2: starting
> datafile backup set restore
>
> channel stndby2: using network backup set from service orclcdb
>
> channel stndby2: specifying datafile(s) to restore from backup set
>
> channel stndby2: restoring datafile 00009 to
>
> /u01/app/oracle/oradata/stndby2/dev1/system01.dbf channel stndby2:
> restore complete, elapsed time: 00:00:15 channel stndby2: starting
> datafile backup set restore
>
> channel stndby2: using network backup set from service orclcdb
>
> channel stndby2: specifying datafile(s) to restore from backup set
>
> channel stndby2: restoring datafile 00010 to
>
> /u01/app/oracle/oradata/stndby2/dev1/sysaux01.dbf channel stndby2:
> restore complete, elapsed time: 00:00:15 channel stndby2: starting
> datafile backup set restore
>
> channel stndby2: using network backup set from service orclcdb
>
> channel stndby2: specifying datafile(s) to restore from backup set
>
> channel stndby2: restoring datafile 00011 to
>
> /u01/app/oracle/oradata/stndby2/dev1/undotbs01.dbf channel stndby2:
> restore complete, elapsed time: 00:00:04 channel stndby2: starting
> datafile backup set restore
>
> channel stndby2: using network backup set from service orclcdb
>
> channel stndby2: specifying datafile(s) to restore from backup set
>
> channel stndby2: restoring datafile 00012 to
>
> /u01/app/oracle/oradata/stndby2/dev1/users01.dbf channel stndby2:
> restore complete, elapsed time: 00:00:01 Finished restore at 04-JUN-20
>
> sql statement: alter system archive log current
>
> contents of Memory Script:
>
> {
>
> switch clone datafile all;
>
> }
>
> executing Memory Script
>
> datafile 1 switched to datafile copy
>
> input datafile copy RECID=5 STAMP=1042203295 file
> name=/u01/app/oracle/oradata/stndby2/system01.dbf
>
> datafile 3 switched to datafile copy
>
> input datafile copy RECID=6 STAMP=1042203295 file
> name=/u01/app/oracle/oradata/stndby2/sysaux01.dbf
>
> datafile 4 switched to datafile copy
>
> input datafile copy RECID=7 STAMP=1042203295 file
> name=/u01/app/oracle/oradata/stndby2/undotbs01.dbf
>
> datafile 5 switched to datafile copy
>
> input datafile copy RECID=8 STAMP=1042203295 file
> name=/u01/app/oracle/oradata/stndby2/pdbseed/system01.dbf
>
> datafile 6 switched to datafile copy
>
> input datafile copy RECID=9 STAMP=1042203295 file
> name=/u01/app/oracle/oradata/stndby2/pdbseed/sysaux01.dbf
>
> datafile 7 switched to datafile copy
>
> input datafile copy RECID=10 STAMP=1042203295 file
> name=/u01/app/oracle/oradata/stndby2/users01.dbf
>
> datafile 8 switched to datafile copy
>
> input datafile copy RECID=11 STAMP=1042203295 file
> name=/u01/app/oracle/oradata/stndby2/pdbseed/undotbs01.dbf
>
> datafile 9 switched to datafile copy
>
> input datafile copy RECID=12 STAMP=1042203295 file
> name=/u01/app/oracle/oradata/stndby2/dev1/system01.dbf
>
> datafile 10 switched to datafile copy
>
> input datafile copy RECID=13 STAMP=1042203295 file
> name=/u01/app/oracle/oradata/stndby2/dev1/sysaux01.dbf
>
> datafile 11 switched to datafile copy
>
> input datafile copy RECID=14 STAMP=1042203295 file
> name=/u01/app/oracle/oradata/stndby2/dev1/undotbs01.dbf
>
> datafile 12 switched to datafile copy
>
> input datafile copy RECID=15 STAMP=1042203295 file
> name=/u01/app/oracle/oradata/stndby2/dev1/users01.dbf
>
> Finished Duplicate Db at 04-JUN-20
>
> allocated channel: stby
>
> channel stby: SID=27 device type=DISK
>
> sql statement: alter database recover managed standby database
> disconnect
>
> released channel: orcl2 released ..: stndby2 released ..: stndby2

Practice 8-3: Start Redo Transport and Verify Operation
-------------------------------------------------------

### Overview

> In this practice, you will start the redo transport from localhost to
> stndby for the new physical standby and verify operation.

### Tasks

1.  Use a terminal window for localhost logged in as oracle with the
    environment variables set to orclcdb and start redo transport by
    defining log\_archive\_dest\_3 pointing to the logical standby
    database.

> **Note:** For this step, we are configuring redo transportation from
> the primary database to the logical standby database This is designed
> to illustrate a typical configuration where the primary database
> transports redo directly to the standby site, and provide a little
> variation in the architecture. Again, this is for illustration only.
> At a later time, we will change this to use the far sync instance.

2.  Determine the last sequence number archived on the primary database.

3.  Use a terminal window on stndby2

4.  connected as oracle with the environment variables set to stndby2.
    Start SQL\*Plus and determine the last sequence number of the
    physical standby instance.

5.  Return to the terminal window of localhost, and force a log switch
    to advance the online redo log sequence number. Verify that the
    sequence number has increased.

6.  Return to the terminal window of stndby, and verify that the stndby
    physical standby instance is receiving redo from the primary
    database instance.

Practice 8-4: Convert Physical Standby to Logical Standby
---------------------------------------------------------

### Overview

> In this practice, you will convert the newly created physical standby
> \'stndby2\' to a logical standby database.

### Tasks

1.  Use a terminal window on localhost connected as oracle with the
    environment variables set to stndby2. Stop redo apply on the stndby2
    physical standby.

2.  Use a terminal window on localhost connected as oracle with the
    environment variables set to orcl2. Build the LogMiner dictionary
    into the redo. Wait for this procedure to finish before continuing
    with labs.

3.  Use a terminal window on stndby2

4.  connected as oracle with the environment variables set to stndby2.
    Continue applying redo data to the physical standby until it is
    ready to convert to a logical standby database.

5.  Increase the SGA size allocated to the logical standidby database.
    **[DON\"T DO THIS.]{.underline}**

6.  Shut down the logical standby database on stndby2, and restart it in
    MOUNT mode.

+------------------------------------------------------+-----------+---------+
| > SQL\> **shutdown**                                 |           |         |
| >                                                    |           |         |
| > ORA-01507: database not mounted                    |           |         |
| >                                                    |           |         |
| > ORACLE instance shut down. SQL\> **startup mount** |           |         |
| >                                                    |           |         |
| > ORACLE instance started.                           |           |         |
| >                                                    |           |         |
| > Total System Global Area 880802384 bytes           |           |         |
+======================================================+===========+=========+
| > Fixed Size                                         | 9140816   | > bytes |
+------------------------------------------------------+-----------+---------+
| > Variable Size                                      | 440401920 | > bytes |
+------------------------------------------------------+-----------+---------+
| > Database Buffers                                   | 423624704 | > bytes |
+------------------------------------------------------+-----------+---------+
| > Redo Buffers                                       | 7634944   | > bytes |
+------------------------------------------------------+-----------+---------+
| > Database mounted.                                  |           |         |
+------------------------------------------------------+-----------+---------+
| > SQL\>                                              |           |         |
+------------------------------------------------------+-----------+---------+

7.  Display the LOG\_ARCHIVE\_DEST parameters on stndby2 that were
    copied from the alter sprimary database. Only entries that have
    values are displayed below.

8.  Remove the LOG\_ARCHIVE\_DEST\_2 entry on stndby because this
    logical database will not be a target for role reversal in this
    course.

9.  Open the logical standby database. Stndby2

10. Start SQL Apply to begin applying redo data that is received from
    the primary database.

11. Open the DEV1 PDB and verify the mode that it was opened with.

12. Exit SQL\*Plus sessions on all host machines. Leave the terminal
    session windows open with the environment variables set.

Practices for Lesson 9: Oracle Data Guard Broker: Overview
==========================================================

Practices for Lesson 9
----------------------

> There are no practices for this lesson.

Practices for Lesson 10: Creating a Data Guard Broker Configuration
===================================================================

Practices for Lesson 10: Overview
---------------------------------

### Practices Overview

> In these practices, you will examine the differences between local and
> remote connections to the Oracle Database instance by using the DGMGRL
> utility. You will also create and enable a Data Guard broker
> configuration.

Practice 10-1: Establishing Local and Remote Connections with DGMGRL
--------------------------------------------------------------------

### Overview

> In this practice, you will use DGMGRL and connect with both local and
> remote connections. The password file will be updated on the primary
> database and copied to every other destination in the Data Guard
> configuration.
>
> **Note:** The oracle user is a member of the dgdba group. As part of
> the class setup, this group was associated with the SYSDG privilege
> for Data Guard.
>
> **The sysdg grant looks like this. ex**
>
> SQL\> grant sysdg to system

as host Launch the DGMGRL utility and verify that you are able to
connect as the SYSDG user with operating system authentication. (The
oracle OS exuser is in the dgdba group.)

> **Note:** With Operating System authentication, any password will work
> for local connections. However, during switchover and failover
> operation to the remote site, you must use the correct password.

1.  Attempt to make a remote connection to the physical standby database
    stndby as the

> SYSDG user. You must use the password that is in the password file.
> Exit DGMGRL.
>
> **Note:** During the creation of the database, the option to use the
> same password for all coadministrative accounts was chosen. However,
> this applied only to the SYS and SYSTEM database accounts.

2.  Use SQL\*Plus on localhost connected as SYSDBA to reset the SYSDG
    password and unlock the account. Exit SQL\*Plus.

hostconn

3.  In the current terminal window on localhost, copy the modified
    password file to all other machines overwriting the password files
    that are already there. On stndby, a password file is needed for
    both the physical standby database and the logical standby database.
    The password files should be renamed during the copy to the
    appropriate names for each destination.

![](media/image10.png){width="5.697916666666667in" height="1.03125in"}

  -- -- -- -- -- --
                 
                 
                 
                 
                 
                 
                 
  -- -- -- -- -- --

> **Note:** As of Oracle Database 19c Release 2 (19.3.0.1), password
> file changes done on the primary database are automatically propagated
> to standby databases. The only exception to this is far sync
> instances. The updated password files must still be manually copied to
> far sync instances because far sync instances receive redo, but do not
> apply it.

id

4.  Launch the DGMGRL utility on localhost and verify that you are now
    able to establish a remote connection as sysdg to the physical
    standby database. Exit DGMGRL when

Practice 10-2: Create and Enable a Data Guard Broker Configuration
------------------------------------------------------------------

### Overview\-\-\-- We cannot do this. No host2.

> In this practice, you will create and name the Data Guard
> configuration. The physical standby database, far sync instances, and
> logical standby database will be added to the configuration. You will
> enable the configuration and define redo routing rules.

### Tasks

1.  Use a terminal window on localhost(primary) connected as oracle with
    the environment variables set to orcl2. Connect to the primary
    database using SQL\*Plus and reset the LOG\_ARCHIVE\_DEST\_2 and
    LOG\_ARCHIVE\_DEST\_3 parameters since they are defined as network
    locations. Start the Data Guard Broker process. Make sure the
    changes are persistent. Exit SQL\*Plus.

CAN\"t do step 2 - No host02

2.  Use a terminal window on host02 connected as oracle with the
    environment variables set to orclcdbFS. Connect to Far Sync using
    SQL\*Plus and reset the LOG\_ARCHIVE\_DEST\_2 parameter since it is
    defined as network location. Start the Data Guard broker process for
    Far Sync. Exit SQL\*Plusa

3.  Use a terminal window on stndby connected as oracle with the
    environment variables set to stndby. Connect to the physical standby
    using SQL\*Plus and stop managed recovery. Reset the
    LOG\_ARCHIVE\_DEST\_2 parameter because it is defined as network
    location. Start the Data Guard broker process for the physical
    standby database.

4.  If you are using a separate window for the stndby/stndby2
    combination, then you can skip the part about resetting the
    environment variables. Otherwise, while still using the terminal
    window for stndby, exit SQL\*Plus. Change the environment variables
    to the stndby2 logical standby database. The logical standby does
    not have any network locations defined for redo transportation.
    Start the Data Guard broker process. Exit SQL\*Plus.

5.  Use a terminal window on localhost connected as oracle with the
    > environment variables set to orcl2. Launch DGMGRL and attempt to
    > show the configuration.

6.  Create the Data Guard broker configuration and then show the
    configuration.

> **Note:** Because the Data Guard broker is a distributed framework,
> the DGMGRL utility can be launched from any host machine that
> participates in the Data Guard configuration. The labs will continue
> to display the machine name (localhost), and therefore, the terminal
> session window being used, for which the DGMGRL utility was launched.
> It would be acceptable though to launch it from another terminal
> session connected to another virtual host machine.

7.  Add the physical standby database stndby to the configuration and
    show the results.

8.  Add the logical standby database stndby2 to the configuration and
    show the results.

9.  Enable the Data Guard broker configuration and show the results.

10. 

DO NOT PERFORM ANY STEPS WHICH USE FAR SYNC

11. Define redo routing rules for the configuration and show the
    results. The current primary database orclcdb should forward redo to
    the Far Sync orclcdbFS synchronously. Additional redo routing rules
    should be created for role reversal. After role reversal, the
    primary database will be stndby and should forward redo to the Far
    Sync stndbyFS synchronously. The Far Sync stndbyFS should then
    forward redo to the physical standby orclcdb and the logical
    standby. DO NOT PERFORM. These are examples only.

.

> **Note:** If your output does not match the above, do not proceed with
> labs until all issues have been resolved. You may need to reissue the
> SHOW CONFIGURATION command several times to give the Virtual Machines
> time to catch up with all the background operations that need to be
> performed. For example, in one test case, it was noted that the
> stndby2 logical standby database was receiving \"ORA-16810: multiple
> errors or warnings detected for this database.\" To further diagnose
> the problem, issue the command \"show database stndby2\". SQL Apply
> had stopped with an \"ORA-16768: SQL Apply is stopped\" message,
> followed by \"ORA-01304: subordinate process error. Check alert and
> trace logs.\" An examination of the alert log indicated that SQL Apply
> had stopped due to an \"ORA-4031: unable to allocate XXX bytes of
> shared memory.\" SQL Apply was restarted with the command \"edit
> database stndby set state=\'APPLY-ON\'\", at which time the
> configuration reported everything acceptable. Please consult with your
> instructor if you need to troubleshoot any issues.

Practice 10-3: Verify and Examine the Data Guard Environment
------------------------------------------------------------

### Overview

> In this practice, you will discover the members of the Data Guard
> broker configuration, and examine and verify the Data Guard broker
> configuration through Enterprise Manager Cloud Control 13c.

### Tasks

1.  ![](media/image11.jpeg){width="5.802777777777778in"
    height="2.517361111111111in"}Using the Firefox Web Browser icon,
    start Firefox to access to Enterprise Manager 13c.

2.  Enter the URL for Cloud Control. In the current setup, use

3.  ![](media/image12.png){width="2.4375in" height="0.28125in"}

4.  ![](media/image13.png){width="5.88125in" height="3.14375in"}Log in
    to Enterprise Manager Cloud Control 13*c*. Log in to the application
    with **sysman** as the username and *\<password\>* as the password.
    The password is case-sensitive.

5.  If you are not on the Databases page, navigate to the Databases page
    by selecting

> ![](media/image14.jpeg){width="6.2027777777777775in"
> height="2.8826388888888888in"}**Targets**, and then **Databases** from
> the drop-down menu that appears.

6.  ![](media/image15.jpeg){width="6.163888888888889in"
    height="2.470138888888889in"}On the Databases page, click the link
    for the orclcdb target.

7.  On the orclcdb database home page, select **Data Guard
    Administration**

> ![](media/image16.jpeg){width="6.164583333333334in"
> height="1.8395833333333333in"}from the Availability menu.
>
> ![](media/image18.jpeg){width="6.15in"
> height="2.727777777777778in"}**(Optional)** If only the Add Standby
> Database link is visible, then select it. It will not launch the Add
> Standby Database Wizard, but instead will navigate to the Data Guard
> home page.
>
> **(Optional)** If the Add Standby Database link shows the Add Standby
> Database page, click
>
> ![](media/image20.jpeg){width="6.148611111111111in"
> height="1.6319444444444444in"}**Cancel** to navigate to the Data Guard
> home page.

8.  On the Database Login Page, select **New** in the Credential option
    with the following values. Click **Login**.

    -   Username: sys

    -   Password: *\<password\>*

    -   Role: SYSDBA

    -   ![](media/image22.jpeg){width="5.825694444444444in"
        height="2.2354166666666666in"}Save As: NC\_ORCLCDB\_SYS

9.  ![](media/image24.jpeg){width="6.172916666666667in"
    height="3.2256944444444446in"}The Data Guard home page, you will see
    the data guard configuration that you created in practice 10-2.

10. ![](media/image26.jpeg){width="4.063888888888889in"
    height="2.0243055555555554in"}Review the **Overview** and **Primary
    Database** sections. It shows the status of the Data Guard
    configuration and the primary database.

11. ![](media/image28.jpeg){width="6.1722222222222225in"
    height="2.2618055555555556in"}Review the **Standby Databases**
    section. It shows the members of the Data Guard configuration and
    role/status of each member.

12. ![](media/image30.jpeg){width="6.189583333333333in"
    height="1.8958333333333333in"}Continue to review the **Standby
    Databases** section. It shows the Redo Source of each member in the
    Data Guard configuration and additional information. In this
    section, you can also Add Far Sync or Add Standby Database.

13. ![](media/image32.jpeg){width="6.218055555555556in"
    height="0.46111111111111114in"}Review the **Performance** and
    **Additional Administration** sections. It shows the additional
    links for the Data Guard performance.

14. ![](media/image34.jpeg){width="6.197222222222222in"
    height="1.7430555555555556in"}Select the **Verify Configuration**
    item from the menu. The following image shows the steps performed
    while verifying the configuration. After verification completes,
    detailed results are displayed.

> **Note:** The verify process will complete with warnings. You can
> safely ignore these warnings at this time.

15. ![](media/image36.jpeg){width="6.176388888888889in"
    height="1.8423611111111111in"}Click **OK**. The Data Guard
    Administration page is displayed.

Practices for Lesson 11: Monitoring a Data Guard Broker Configuration
=====================================================================

Practices for Lesson 11: Overview
---------------------------------

### Practices Overview

> In these practices, you will use the DGMGRL utility to monitor your
> physical standby database. You will also examine the use of trace
> files to monitor the Data Guard environment.

Practice 11-1: Monitoring the Physical Standby Database
-------------------------------------------------------

### Overview

> In this practice, you will use DGMGRL and connect with both local and
> remote connections. The password file will be updated on the primary
> database and copied to every other destination in the Data Guard
> configuration.

### Tasks

1.  Use a terminal window on localhost connected as oracle with the
    environment variables set to orcl2. Launch DGMGRL connecting as the
    SYSDG user with operating system authentication.

2.  Use the SHOW CONFIGURATION VERBOSE command to display the current
    values for the

> CommunicationTimeout property and the OperationTimeout property.

+----------------------------------+---------+--------------------+
| > FastStartFailoverThreshold     | > =     | > \'30\'           |
+==================================+=========+====================+
| > **OperationTimeout**           | > **=** | > **\'30\'**       |
+----------------------------------+---------+--------------------+
| > TraceLevel                     | > =     | > \'USER\'         |
+----------------------------------+---------+--------------------+
| > FastStartFailoverLagLimit      | > =     | > \'30\'           |
+----------------------------------+---------+--------------------+
| > **CommunicationTimeout**       | > **=** | > **\'180\'**      |
+----------------------------------+---------+--------------------+
| > ObserverReconnect              | > =     | > \'0\'            |
+----------------------------------+---------+--------------------+
| > FastStartFailoverAutoReinstate | > =     | > \'TRUE\'         |
+----------------------------------+---------+--------------------+
| > FastStartFailoverPmyShutdown   | > =     | > \'TRUE\'         |
+----------------------------------+---------+--------------------+
| > BystandersFollowRoleChange     | > =     | > \'ALL\'          |
+----------------------------------+---------+--------------------+
| > ObserverOverride               | > =     | > \'FALSE\'        |
+----------------------------------+---------+--------------------+
| > ExternalDestination1           | > =     | > \'\'             |
+----------------------------------+---------+--------------------+
| > ExternalDestination2           | > =     | > \'\'             |
+----------------------------------+---------+--------------------+
| > PrimaryLostWriteAction         | > =     | > \'CONTINUE\'     |
+----------------------------------+---------+--------------------+
| > ConfigurationWideServiceName   | > =     | > \'orclcdb\_CFG\' |
+----------------------------------+---------+--------------------+

3.  Modify the CommunicationTimeout property and set it to a value
    of 300. Verify the 300result.

> **Note:** This is not normally needed but it helps with labs running
> in the Virtual Machine architecture.

4.  Modify the OperationTimeout property and set it to the maximum value
    of 300. Verify the result.

5.  Use the SHOW DATABASE command for the physical standby database and
    determine the current transport lag, apply lag, and apply rate.

6.  Stop redo apply on the physical standby database to force an apply
    rate lag to occur.

7.  Without exiting DGMGRL, force a log switch on the primary database.

> **Note:** You are currently connected to the primary database.

8.  Use the SHOW DATABASE command for the physical standby database and
    display the current apply lag rate.

9.  Display the standby receive queue for the physical standby database.

10. ![](media/image16.jpeg){width="6.220833333333333in"
    > height="1.85625in"}(**Optional**) With the navigation techniques
    > learned in practice 10-3, navigate to the orcl2 database home
    > page. On the orcl2 database home page, click **Data Guard
    > Administration** in the Availability menu.

> ![](media/image18.jpeg){width="6.15in"
> height="2.727777777777778in"}**(Optional)** If only the Add Standby
> Database link is visible, then select it. It will not launch the Add
> Standby Database Wizard, but instead will navigate to the Data Guard
> home page.
>
> **(Optional)** If the Add Standby Database link shows the Add Standby
> Database page, click
>
> ![](media/image20.jpeg){width="6.148611111111111in"
> height="1.6319444444444444in"}**Cancel** to navigate to the Data Guard
> home page.

11. (**Optional**) On the Database Login Page, select **New** in the
    > Credential option with the following values. Click **Login**.

    -   Username: sys

    -   Password: *\<password\>*

    -   Role: SYSDBA

    -   ![](media/image22.jpeg){width="6.220833333333333in"
        height="2.386111111111111in"}Save As: NC\_ORCLCDB\_SYS

12. (**Optional**) On the Data Guard home page, you will see the status
    of redo apply service on the physical standby database

![](media/image38.jpeg){width="6.2027777777777775in"
height="1.5340277777777778in"}

13. (**Optional**) Click the Log File Details link in the Performance
    section.

14. (**Optional**) On the Log File Details page, you will see the list
    > of log files that have not been received and applied.

> ![](media/image39.jpeg){width="6.246527777777778in"
> height="2.0069444444444446in"}**Note:** The ORA-16664 message can be
> ignored.

15. Restart redo apply on the physical standby database. Verify that the
    > apply lag has been cleared. Exit DGMGRL when done.

> **Note:** You may have to wait a minute after restarting redo apply to
> verify the results.

Practice 11-2: Examining Data Guard Log and Trace Files
-------------------------------------------------------

### Overview

> In this practice, you will locate and examine the Data Guard log and
> trace files.

### Tasks

1.  Use a terminal window on localhost connected as oracle with the
    environment variables set to orcl2. Connect to the primary database
    using SQL\*Plus and determine the root directory for the Automatic
    Diagnostic Repository (ADR). Exit SQL\*Plus when done.

2.  Change directory to the \"trace\" subdirectory located in the
    Automatic Diagnostic Repository home location. The ADR home is
    located at

> \<diagnostic\_dest\>/diag/rdbms/\<dbname\>/\<instance\_name\>.

3.  Verify that the previous commands that changed the state of redo
    apply and connection timeout where recorded in the Data Guard broker
    log file. The broker log file is named drc\<db\_unique\_name\>.log.

4.  Use the \"ls -alt \| more\" command to list the directory contents
    of the trace directory sorted by modification time descending. The
    most recent modified file will be displayed first. Use \<Ctrl + C\>
    to exit.

5.  Connect to the primary database using SQL\*Plus and set the level to
    > 16 to track detailed archived redo log destination activity. Force
    > a log switch and exit SQL\*Plus when done.

6.  Use the \"ls -alt \| more\" command to list the directory contents
    of the trace directory sorted by modification time descending.
    Identify the newly created files in the directory that were not
    present for the previous step 4. Use \<Ctrl + C\> to exit.

7.  The resulting log writer process (LGWR) and network server sync
    process (NSS) trace files can be very large in size.

8.  Connect to the primary database using SQL\*Plus and set the
    log\_archive\_trace level to 0 to disable tracing. Exit SQL\*Plus
    when done.

Practice 11-3: Using the VALIDATE commands
------------------------------------------

### Overview

> In this practice, you will look at the various ways to use the DGMGRL
> VALIDATE commands.

### Tasks

1.  Use the terminal session connected to localhost as the oracle user
    and set the environment.

2.  Using DGMGRL, connect to the orclcdb database.

3.  Use the help command to display all possible VALIDATE commands.

4.  Use the VALIDATE command to perform a comparison of SPFILE entries
    between the

> orclcdb primary database and the stndby standby database.
>
> **Note:** The command above shows only the parameter settings with
> different values. If you
>
> want to list all parameter settings compared, use VALIDATE DATABASE
> VERBOSE stndby SPFILE.

5.  Validate network configuration for the stndby database.

6.  Validate network configuration for all members.

#### DGMGRL\> VALIDATE NETWORK CONFIGURATION FOR all;

> Connecting to instance \"orcl2\" on database \"orcl2\" \... Connected
> to \"orcl2\"
>
> Checking connectivity from instance \"orcl2\" on database \"orcl2
>
> to instance \"stndby\" on database \"stndby\"\...
>
> Succeeded.
>
> Checking connectivity from instance \"orcl2\" on database \"orcl2 to
> instance \"stndby2\" on database \"stndby2\"\...
>
> Succeeded.
>
> .
>
> Connecting to instance \"stndby\" on database \"stndby\" \...
> Connected to \"stndby\"
>
> Checking connectivity from instance \"stndby\" on database \"stndby to
> instance \"orcl2\" on database \"orcl2\"\...
>
> Succeeded.
>
> Checking connectivity from instance \"stndby\" on database \"stndby to
> instance \"stndby2\" on database \"stndby2\"\...
>
> Succeeded.
>
> Connecting to instance \"stndby2\" on database \"stndby2\" \...
> Connected to \"stndby2\"
>
> Checking connectivity from instance \"stndby2\" on database \"stndby2
> to instance \"orcl2\" on database \"orcl2\"\...
>
> Succeeded.
>
> Checking connectivity from instance \"stndby2\" on database \"stndby2
> to instance \"stndby\" on database \"stndby\"\...
>
> Succeeded.
>
> Oracle Clusterware is not configured on database \"orclcdb\".
> Connecting to database \"orcl2\" using static connect identifier
> \"(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=localhost.example.com)(POR
> T=1521))(CONNECT\_DATA=(SERVICE\_NAME=orcl2\_DGMGRL.example.com)(INS
> TANCE\_NAME=orcl2)(SERVER=DEDICATED)(STATIC\_SERVICE=TRUE)))\" \...
>
> Succeeded.

7.  Validate the static connect identifier of the orclcdb database.

8.  Validate the static connect identifier for all databases.

9.  Exit DGMGRL on localhost leaving the terminal window open for future
    practices.

Practices for Lesson 12: Configuring Data Protection Modes
==========================================================

Practices for Lesson 12: Overview
---------------------------------

### Practices Overview

> In these practices, you will examine the various protection modes and
> the impact that they may have on the primary database.

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

Practices for Lesson 13: Optimizing and Tuning a Data Guard Configuration
=========================================================================

Practices for Lesson 13: Overview
---------------------------------

### Practices Overview

> In these practices, you will configure network compression of redo
> data and SQL TUNING ADVISOR in a Data Guard environment.

Practice 13-1: Configuring Network Compression of Redo Data
-----------------------------------------------------------

### Overview

> In this practice, you will set the RedoCompression property to
> configure network compression of redo data.

### Tasks

1.  Use a terminal window logged in as oracle to localhost with the
    environment variables set for orclcdb appropriately. Launch
    SQL\*Plus on your primary database and determine if redo compression
    is enabled by querying V\$ARCHIVE\_DEST.

Cd

2.  Use a terminal window logged in as oracle to host02 with the
    environment variables set for orclcdbFS appropriately. Launch DGMGRL
    and connect to the primary database.

3.  Enable redo compression by setting the RedoCompression property for
    your database. Exit DGMGRL.

4.  Return to your SQL\*Plus session on localhost and query
    V\$ARCHIVE\_DEST again. Note that compression is set for
    LOG\_ARCHIVE\_DEST\_2. Exit SQL\*Plus.

Practice 13-4: Using SQL Tuning Advisor for an Active Data Guard Instance
-------------------------------------------------------------------------

### Overview

> In this practice, you will see how to use SQL Tuning Advisor for
> Active Data Guard.
>
> The Active Data Guard (ADG) Databases are widely used to offload
> reporting or ad hoc query-only jobs from primary. Reporting workload
> profile is different from primary and often requires tuning. Starting
> with Oracle Database 12.2, you can run SQL Tuning Advisor to tune SQLs
> workloads running on ADG database.

![](media/image40.jpeg){width="6.214055118110236in"
height="1.6163538932633421in"}

-   All changes are done on primary and propagated from primary to
    standby by redo apply.

-   The data required for running the tuning tasks are fetched from the
    primary.

-   Support for PDB level tuning

-   Test execution (heavy lifting) happens on standby; only minimal
    write related activity on primary.

### Tasks

1.  (**Reference Only, DO NOT RUN**) The environment for this practice
    has been set up with the setup\_STA.sh script. This script created
    the OE.PRODUCTS, OE.ORDER\_ITEMS, OE.orders, OE.CUSTOMERs, and
    OE.storeS tables.

2.  Use a terminal window logged in as oracle to localhost with the
    environment variables set for orclcdb appropriately. Log in to the
    DEV1 PDB as the SYS user and run the setup13- 4.sql script.

3.  Switch to the CDB root container and create a database link in the
    primary database for the standby database.

4.  Use a terminal window logged in as oracle to stndby with the
    environment variables set for stndby appropriately. Launch SQL\*Plus
    and run the problem query in the DEV1 PDB.

5.  Find sql\_id of the problem query.

6.  Open a new terminal window logged in as oracle to stndby with the
    environment variables set for stndby appropriately.

7.  In the same terminal session, verify that the sql\_id of the problem
    query is visible. **Note:** At times, the problem query doesn't
    appear in the CDB root container due to an internal delay. If that
    is the case, return to the terminal session used in step 4 and run
    the problem\_query.sql script again.

8.  Create a SQL Tuning Task.

> ![](media/image42.jpeg){width="6.096527777777778in"
> height="1.7944444444444445in"}**Note:** If you receive ORA-13780: SQL
> statement does not exist, return to the terminal session used in step
> 4 and run the problem\_query.sql script again.

9.  ![](media/image43.jpeg){width="6.21875in"
    height="1.8506944444444444in"}Execute the SQL Tuning Task.

10. Generate the SQL Tuning Task report.

> ![](media/image45.jpeg){width="6.209722222222222in"
> height="1.8319444444444444in"}**Note:** The result varies.
>
> Scope : COMPREHENSIVE
>
> Time Limit(seconds): 1800 Completion Status : COMPLETED Started at :
> 06/05/2020 22:21:31
>
> Completed at : 06/05/2020 22:21:35
>
> Schema Name : OE Container Name: DEV1
>
> SQL ID : an7zryzf86prm
>
> SQL Text : SELECT /\* problem\_query \*/ SUM(lo\_extendedprice \*
> lo\_discount) revenue FROM oe.lineorder l, oe.date\_dim d
>
> WHERE l.lo\_orderdate = d.d\_datekey
>
> FINDINGS SECTION (2 findings)

1.  Statistics Finding

> Table \"OE\".\"DATE\_DIM\" was not analyzed.
>
> Recommendation

-   Consider collecting optimizer statistics for this table. execute
    dbms\_stats.gather\_table\_stats(ownname =\> \'OE\',

> tabname =\>
>
> \'DATE\_DIM\', estimate\_percent =\> DBMS\_STATS.AUTO\_SAMPLE\_SIZE,
>
> method\_opt =\> \'FOR ALL COLUMNS SIZE AUTO\');
>
> Rationale
>
> The optimizer requires up-to-date statistics for the table in order to
> select a good execution plan.

2.  Statistics Finding

> Table \"OE\".\"order\_items\" was not analyzed.
>
> Recommendation

-   Consider collecting optimizer statistics for this table. execute
    dbms\_stats.gather\_table\_stats(ownname =\> \'OE\',

> tabname =\>
>
> \'ORDER\_ITEMS\', estimate\_percent =\>
> DBMS\_STATS.AUTO\_SAMPLE\_SIZE,
>
> method\_opt =\> \'FOR ALL COLUMNS SIZE AUTO\');
>
> Rationale
>
> The optimizer requires up-to-date statistics for the table in order to
>
> select a good execution plan.
>
> EXPLAIN PLANS SECTION
>
> 1- Original
>
> Plan hash value: 2963256899

+---------+----------------+----+-----------+--------+-----------------------------+
| > \| Id | > \| Operation | \| | > Name \| | > Rows | > \| Bytes \| Cost (%CPU)\| |
+=========+================+====+===========+========+=============================+
| > Time  | > \|           |    |           |        |                             |
+---------+----------------+----+-----------+--------+-----------------------------+

> \| 0 \| SELECT STATEMENT \| \| 1 \| 52 \| 6448
>
> (1)\| 00:00:01 \|

+--------+---+----+------------------+------+------+-----------------+-------+---------+
| > \|   | 1 | \| | > SORT AGGREGATE | > \| |      | > \| 1 \|       | 52 \| |         |
| >      |   |    | >                |      |      |                 |       |         |
| > \|   |   |    | > \|             |      |      |                 |       |         |
+========+===+====+==================+======+======+=================+=======+=========+
| > \|\* | 2 | \| | > HASH JOIN      | > \| | > \| | > 1610K\| 79M\| | 6448  | > (1)\| |
+--------+---+----+------------------+------+------+-----------------+-------+---------+

> 00:00:01 \|
>
> \| 3 \| TABLE ACCESS FULL\| DATE\_DIM \| 2556 \| 33228 \| 12
>
> (0)\| 00:00:01 \|
>
> \| 4 \| TABLE ACCESS FULL\| LINEORDER \| 1610K\| 59M\| 6431
>
> (1)\| 00:00:01 \|
>
> Query Block Name / Object Alias (identified by operation id):
>
> 1 - SEL\$1

3.  \- SEL\$1 / D\@SEL\$1

4.  \- SEL\$1 / L\@SEL\$1

> Predicate Information (identified by operation id):
>
> 2 - access(\"L\".\"LO\_ORDERDATE\"=\"D\".\"D\_DATEKEY\")
>
> Column Projection Information (identified by operation id):

1.  \- (\#keys=0) SUM(\"LO\_EXTENDEDPRICE\"\*\"LO\_DISCOUNT\")\[22\]

2.  \- (\#keys=1; rowset=256) \"LO\_DISCOUNT\"\[NUMBER,22\],
    > \"LO\_EXTENDEDPRICE\"\[NUMBER,22\]

3.  \- (rowset=256) \"D\".\"D\_DATEKEY\"\[NUMBER,22\]

4.  \- (rowset=256) \"L\".\"LO\_ORDERDATE\"\[NUMBER,22\],
    > \"LO\_EXTENDEDPRICE\"\[NUMBER,22\], \"LO\_DISCOUNT\"\[NUMBER,22\]

> Note
>
> \- dynamic statistics used: dynamic sampling (level=2)

11. Return to the terminal session connected to localhost. Switch to the
    > DEV1 container.

12. Optionally, implement the recommendations.

> **Note:** If the recommendation is about the implementation of a
> profile, you can accept the profile directly in the standby database.
> The accepted profile is written to the primary database. Then the same
> profile is available in the standby database via redo apply.

13. Exit SQL\*Plus on all hosts leaving the current terminal windows.


Practices for Lesson 15: Using Flashback Database in a Data Guard Configuration
===============================================================================

Practices for Lesson 15: Overview
---------------------------------

### Practices Overview

> In these practices, you will enable flashback database on both the
> primary database and the physical standby database. You will also test
> the automatic flashback of the physical standby database feature and
> manual flashback of the logical standby database.

Practice 15-1: Configuring Flashback Database on the Primary Database
---------------------------------------------------------------------

### Overview

> In this practice, you will configure flashback database on the primary
> database and verify that it has been enabled.

### Tasks

1.  Use a terminal window on localhost connected as oracle with the
    environment variables set to orclcdb. Launch SQL\*Plus and determine
    the current state of flashback database.

2.  Verify that the primary database is in archive log mode, a
    pre-requisite to flashback database.

3.  Verify that the fast recovery area has been configured for the
    primary database, a pre-requisite to flashback database.

+-----------------------+---+---------------+-----------------------+
| > SQL\> **show        |   |               |                       |
| > parameter           |   |               |                       |
| > db\_recovery**      |   |               |                       |
| >                     |   |               |                       |
| > NAME TYPE VALUE     |   |               |                       |
+=======================+===+===============+=======================+
| > db\                 |   | > string      | > /u01/app/oracle     |
| _recovery\_file\_dest |   | >             | >                     |
| >                     |   | > big integer | >                     |
| > db\_recov           |   |               | /fast\_recovery\_area |
| ery\_file\_dest\_size |   |               | >                     |
|                       |   |               | > 15000M              |
+-----------------------+---+---------------+-----------------------+

4.  Determine the current amount of time in minutes for the flashback
    window.

+------------------------------------------+---+-----------+---+---------+
| > SQL\> **show parameter flashback**     |   | > TYPE    |   | > VALUE |
| >                                        |   |           |   |         |
| > NAME                                   |   |           |   |         |
+==========================================+===+===========+===+=========+
| > db\_flashback\_retention\_target SQL\> |   | > integer |   | > 1440  |
+------------------------------------------+---+-----------+---+---------+

5.  Adjust the flashback window to be 3 days (1440 minutes/day x 3 days
    = 4320 minutes).

6.  Enable flashback database for the whole database.

7.  Verify that flashback database has been enabled.

8.  Determine the current size (in bytes) of the flashback data.

9.  Determine the name, quantity, and sizes of the flashback log files
    that were created when flashback database was enabled. Your file
    names will be different. Exit SQL\*Plus.

Practice 15-2: Configuring Flashback Database on the Physical Standby Database
------------------------------------------------------------------------------

### Overview

> In this practice, you will enable flashback database on the physical
> standby database.

### Tasks

1.  Use a terminal window on stndby connected as oracle with the
    environment variables set to stndby. Launch SQL\*Plus and determine
    the current state of the flashback database.

2.  Verify that the physical standby database is in archive log mode, a
    pre-requisite to flashback database.

3.  Verify that the fast recovery area has been configured for the
    physical standby database, a pre-requisite to flashback database.

+-----------------------+---+---------------+-----------------------+
| > SQL\> **show        |   |               |                       |
| > parameter           |   |               |                       |
| > db\_recovery**      |   |               |                       |
| >                     |   |               |                       |
| > NAME TYPE VALUE     |   |               |                       |
+=======================+===+===============+=======================+
| > db\                 |   | > string      | > /u01/app/oracle     |
| _recovery\_file\_dest |   | >             | >                     |
| >                     |   | > big integer | >                     |
| > db\_recov           |   |               | /fast\_recovery\_area |
| ery\_file\_dest\_size |   |               | >                     |
|                       |   |               | > 15000M              |
+-----------------------+---+---------------+-----------------------+

4.  Determine the current amount of time in minutes for the flashback
    window.

+--------------------------------------+---+-----------+---+---------+
| > SQL\> **show parameter flashback** |   |           |   |         |
+======================================+===+===========+===+=========+
| > NAME                               |   | > TYPE    |   | > VALUE |
+--------------------------------------+---+-----------+---+---------+
| > db\_flashback\_retention\_target   |   | > integer |   | > 1440  |
+--------------------------------------+---+-----------+---+---------+

5.  Adjust the flashback window to be 3 days (1440 minutes/day x 3 days
    = 4320 minutes).

6.  Enable flashback database for the whole database. Note the error
    message that is returned.

7.  Stop the managed recovery mode for the physical standby database.

8.  Return to the SQL\*Plus session on stndby connected to the stndby
    physical standby database and enable flashback database a second
    time.

9.  Verify that flashback database has been enabled.

10. Restart the managed recovery mode for the stndby physical standby
    database. Exit SQL\*Plus when done.

Practice 15-3: Configuring Flashback Database on the Logical Standby Database
-----------------------------------------------------------------------------

### Overview

> In this practice, you will enable flashback database on the logical
> standby database.

### Tasks

1.  Use a terminal window on stndby2 connected as oracle with the
    environment variables set to stndby2. Launch SQL\*Plus and determine
    the current state of flashback database.

2.  Verify that the logical standby database is in archive log mode, a
    pre-requisite to flashback database.

3.  Verify that the fast recovery area has been configured for the
    physical standby database, a pre-requisite to flashback database.

+-----------------------+---+---------------+-----------------------+
| > SQL\> **show        |   |               |                       |
| > parameter           |   |               |                       |
| > db\_recovery**      |   |               |                       |
| >                     |   |               |                       |
| > NAME TYPE VALUE     |   |               |                       |
+=======================+===+===============+=======================+
| > db\                 |   | > string      | > /u01/app/oracle     |
| _recovery\_file\_dest |   | >             | >                     |
| >                     |   | > big integer | >                     |
| > db\_recov           |   |               | /fast\_recovery\_area |
| ery\_file\_dest\_size |   |               | >                     |
|                       |   |               | > 15000M              |
+-----------------------+---+---------------+-----------------------+

4.  Determine the current amount of time in minutes for the flashback
    window.

+--------------------------------------+---+-----------+---+---------+
| > SQL\> **show parameter flashback** |   |           |   |         |
+======================================+===+===========+===+=========+
| > NAME                               |   | > TYPE    |   | > VALUE |
+--------------------------------------+---+-----------+---+---------+
| > db\_flashback\_retention\_target   |   | > integer |   | > 1440  |
+--------------------------------------+---+-----------+---+---------+

5.  Adjust the flashback window to be 3 days (1440 minutes/day x 3 days
    = 4320 minutes).

6.  Enable flashback database for the whole database. Note the error
    message that is returned.

7.  Verify that flashback database has been enabled.

Practice 15-4: Testing Automatic Flashback of Standby Database
--------------------------------------------------------------

### Overview

> In this practice, you will flash back your primary database after some
> incorrect updates to the database. After the primary database is
> recovered, you will observe the automatic flashback of standby
> database feature.

### Tasks

1.  Use a terminal window on localhost connected as oracle with the
    environment variables set to orclcdb. Launch SQL\*Plus to connect to
    DEV1 PDB as the SYS user and create a guaranteed restore point
    called orclcdb\_grp.

2.  View HR data to determine the sum of the SALARY column in the
    HR.EMPLOYEES table and the total number of employees in
    department 90. You will use this information for comparison during
    this practice.

3.  Execute the user\_errors.sql script to update tables in the HR
    schema. Assume that it creates issues from which you will "recover"
    by flashing back the database in this practice.

4.  Query the updated data in the HR schema and compare the results to
    the values you received in the queries in step 2.

5.  Use a terminal window on stndby connected as oracle with the
    environment variables set to stndby. Launch SQL\*Plus to connect to
    DEV1 PDB. If the DEV1 PDB is not open, open it first.

6.  Verify that the restore points were replicated to the stndby standby
    database.

> **Note:** The restore point created in the primary database was
> replicated to the physical standby database.

7.  Query the data in the HR schema in the stndby physical standby
    database.

> **Note:** As you can see, the unwanted changes were applied in the
> stndby physical standby database.

8.  Return to the terminal session connected to localhost. Shut down and
    mount the orclcdb

> database to prepare for the FLASHBACK DATABASE operation. Exit
> SQL\*Plus.

9.  Log in to the RMAN utility to run the FLASHBACK DATABASE command to
    flash back the database to the restore point called orclcdb\_grp.
    Exit RMAN.

10. Using SQL\*Plus, log in as the SYS user to open the primary database
    and the DEV1 PDB in read-only mode.

11. Connect to the DEV1 PDB to verify that the database was flashed back
    correctly by querying the HR.EMPLOYEES table again. The values
    should match the values you obtained in the queries in step 2.

> **Note:** The flashback operation cleaned up the unwanted changes in
> the primary database.

12. Now, restart the primary database with RESETLOGS and make sure that
    the DEV1 PDB is open.

13. Return to the terminal session connected to stndby to check if the
    automatic flashback feature was used in the stndby standby database.

> **Note:** The physical standby database still shows the unwanted
> changes.

14. In the same SQL\*Plus session on stndby, review the alert log file.
    Press CTRL+C to exit.

> **Note:** The alert log indicates that the automatic flashback on
> standby didn't work because the standby database is currently open.
> This feature works in the MOUNT state.

15. Connect as the SYS user and mount the stndby database.

16. Review the alert log file again. Press Ctrl+C to exit.

> **Note:** The alert log file includes the Flashback Media Recovery
> Complete message, which indicates the automatic flashback of physical
> standby feature was applied in the stndby physical standby database.

17. Open the standby database and DEV1 PDB.

18. Run the same query to see if the unwanted changes were cleaned up.

> **Note:** The flashback operation was automatically performed in the
> physical standby database. So, the unwanted changes were cleaned up.

19. Return to the SQL\*Plus session on localhost connected to the
    primary database. Switch to the DEV1 PDB and drop the restore point.

20. Exit SQL\*Plus on localhost and stndby leaving the terminal windows
    open for future practices.

Practice 15-5: Performing Flashback of the Logical Standby Database
-------------------------------------------------------------------

### Overview

> In this practice, you will examine the stndby2 logical standby
> database to test if the automatic flashback of standby database
> feature works with the logical standby database or not. Finally, you
> will perform the flashback of the stndby2 logical standby database
> manually.

### Tasks

1.  Use the terminal window connected to stndby as oracle with the
    environment variables set to stndby2. Connect to the DEV1 PDB.

2.  Query the updated data in the HR schema.

3.  Open a new terminal window connected to stndby. Review the alert log
    file for the

> stndby2 standby database.
>
> **Note:** The alert log file shows the automatic flashback of the
> logical standby database didn't work.

4.  Since the automatic flashback of standby feature works for the
    physical standby database, you will have to flash back the logical
    standby database manually. Use the terminal window to connect to
    localhost as oracle.

5.  Using SQL\*Plus, determine an SCN that is at least two SCNs prior to
    the SCN when the OPEN RESETLOGS command was issued. This is
    necessary to enable the standby to recover properly through OPEN
    RESETLOGS. Use the following query to find the "before RESETLOGS"
    SCN

6.  Return the SQL\*Plus session connected to the stndby2 database.
    Determine the target SCN for flashback operation at the logical
    standby. In this step, the FLASHBACK\_SCN value for PRIMARY\_SCN is
    from Step 5.

7.  Flash back the standby database to the "before RESETLOGS" SCN that
    you queried in step 6.

> **Note:** Your SCN is different.

8.  Open the stndby2 database in READ ONLY mode and verify the HR data
    in the DEV1 PDB.

> **Note:** As you can see, the logical standby database was
> successfully flashed back.

9.  Open the stndby2 database with RESETLOGS.

10. Restart SQL Apply on the standby database if it's not running. The
    standby database will be ready to receive and apply logs from the
    primary database.

> **Note:** If SQL Apply is already running, you will receive ORA-16103.
> Exit SQL\*Plus.

11. Launch the DGMGRL utility and connect as the SYSDG user.

12. Use the SHOW CONFIGURATION command to display the configuration
    status for the Data Guard configuration.

13. Exit DGMGRL and SQL\*Plus leaving the terminal windows open for
    future practices.

Practices for Lesson 16: Enabling Fast-Start Failover
=====================================================

Practices for Lesson 16: Overview
---------------------------------

### Practices Overview

> In these practices, you will set up and configure fast-start failover.
> You will then simulate a failure of the primary database and observe
> the automatic failover to the standby database.

Practice 16-1: Configuring Fast-Start Failover in Observer-Only Mode
--------------------------------------------------------------------

### Overview

> In this practice, you will configure fast-start failover in
> observe-only mode. After configuring fast- start failover in
> observe-only mode, you will start the observer process. Then you will
> simulate the crash of the primary database for FSFO dry-run.

### Tasks

1.  Use a terminal window on localhost connected as oracle with the
    environment variables set to orclcdb. Launch SQL\*Plus and perform a
    log switch on the primary database. Exit SQL\*Plus.

2.  Use a terminal window on connected as oracle with the environment
    variables set to stndby. Launch the DGMGRL utility and connect as
    the SYSDG user.

3.  Verify that there is no Transport Lag or Apply lag at the physical
    standby database and logical standby database before proceeding with
    labs.

sho

4.  Display the current configuration and note the current state of
    fast-start failover.

5.  Set up the FastStartFailoverTarget configuration property on the
    orclcdb primary database to indicate the desired stndby target
    standby database.

6.  Define the reciprocal fast-start failover target for when the stndby
    physical standby database becomes the primary database. This would
    be set automatically by the broker if far sync was not in the
    configuration.

7.  Display the FastStartFailoverTarget configuration property for both
    the primary database and the physical standby database.

8.  Modify the ObserverReconnect configuration property and set the
    value to 120 seconds.

9.  To enable fast-start failover the configuration must be upgraded to
    the maximum availability mode. Display the current RedoRoutes
    property for both the primary and standby database.

> **Note:** FASTSYNC would also be acceptable settings for the maximum
> availability.

10. Upgrade the protection mode to maximum availability.

11. Configure fast-start failover in observe-only mode to test how
    fast-failover will work in your environment.

12. Start the observer process.

> **Note:** The prompt will not return after starting the observer
> unless you start the observer in the background mode. Keep this
> terminal window open with the observer running in it.

13. Return to the terminal session connected to localhost. Simulate a
    crash of the primary database.

14. Return to the Observer session Review the output.

> DGMGRL\> **start observer**
>
> \...
>
> \[W000 2020-06-06T23:33:18.179-04:00\] Try to connect to the primary.
>
> \[W000 2020-06-06T23:34:48.972-04:00\] Primary database cannot be
> reached.
>
> \[W000 2020-06-06T23:34:48.972-04:00\] Fast-Start Failover threshold
> has not exceeded. **Retry for the next 30 seconds**
>
> \[W000 2020-06-06T23:34:49.973-04:00\] Try to connect to the primary.
>
> ORA-12537: TNS:connection closed
>
> Unable to connect to database using orclcdb
>
> \[W000 2020-06-06T23:35:15.727-04:00\] Primary database cannot be
> reached.
>
> \[W000 2020-06-06T23:35:15.727-04:00\] Fast-Start Failover threshold
> has not exceeded. **Retry for the next 3 seconds**
>
> \[W000 2020-06-06T23:35:16.727-04:00\] Try to connect to the primary.
>
> \[W000 2020-06-06T23:35:17.806-04:00\] Primary database cannot be
> reached.
>
> \[W000 2020-06-06T23:35:17.806-04:00\] Fast-Start Failover threshold
> has not exceeded. **Retry for the next 1 second**
>
> \[W000 2020-06-06T23:35:18.806-04:00\] Try to connect to the primary.
>
> \[W000 2020-06-06T23:35:20.000-04:00\] Primary database cannot be
> reached.
>
> \[W000 2020-06-06T23:35:20.000-04:00\] **Fast-Start Failover threshold
> has expired.**
>
> \[W000 2020-06-06T23:35:20.000-04:00\] Try to connect to the standby.
>
> \[W000 2020-06-06T23:35:20.000-04:00\] Making a last connection
> attempt to primary database before proceeding with Fast-Start
> Failover.
>
> \[W000 2020-06-06T23:35:20.000-04:00\] Check if the standby is ready
> for failover.
>
> \[W000 2020-06-06T23:35:20.005-04:00\] A fast-start failover would
> have been initiated\...
>
> \[W000 2020-06-06T23:35:20.005-04:00\] **Unable to failover since this
> observer is in observe-only mode**
>
> \[W000 2020-06-06T23:35:20.005-04:00\] **Fast-Start Failover is not
> possible because observe-only mode.**
>
> \[W000 2020-06-06T23:35:21.006-04:00\] Try to connect to the primary.
>
> \[W000 2020-06-06T23:35:22.095-04:00\] Primary database cannot be
> reached.
>
> \[W000 2020-06-06T23:35:23.096-04:00\] Try to connect to the primary.
>
> \[W000 2020-06-06T23:35:24.214-04:00\] Primary database cannot be
> reached.
>
> \[W000 2020-06-06T23:35:25.215-04:00\] Try to connect to the primary.
>
> \[W000 2020-06-06T23:35:49.321-04:00\] Primary database cannot be
> reached.
>
> \[W000 2020-06-06T23:35:49.321-04:00\] Fast-Start Failover threshold
> has not exceeded. Retry for the next 2 seconds
>
> \[W000 2020-06-06T23:35:50.322-04:00\] Try to connect to the primary.
>
> \[W000 2020-06-06T23:35:51.400-04:00\] Primary database cannot be
> reached.
>
> \[W000 2020-06-06T23:35:51.400-04:00\] Fast-Start Failover threshold
> has expired.
>
> \[W000 2020-06-06T23:35:51.400-04:00\] Try to connect to the standby.
>
> \[W000 2020-06-06T23:35:51.400-04:00\] Making a last connection
> attempt to primary database before proceeding with Fast-Start
> Failover.
>
> **Note:** The observe-only mode is useful to run the Fast-Start
> Failover in dry-run mode, where you want to be sure that your
> infrastructure is configured properly, without false alerts, before
> having it fully automated.

15. Return to the terminal session on localhost. Using SQL\*Plus,
    connect as the SYS user and start the primary database. Exit
    SQL\*Plus.

16. Launch the DGMGRL utility and connect as the SYSDG user.

17. Stop observer and disable Fast-Start Failover in Observe-only mode.

18. Exit DGMGRL and SQL\*Plus. Leave the terminal windows open for
    future practices.

Practice 16-2: Enabling Fast-Start Failover
-------------------------------------------

### Overview

> In this practice, you will enable fast-start failover on localhost
> where the stndby is currently running. After enabling fast-start
> failover, you will start the observer process.

### Tasks

1.  Use a terminal window on localhost connected as oracle with the
    environment variables set to stndby. Launch the DGMGRL utility and
    connect as the SYSDG user with operating system authentication.

2.  Verify that there is no Transport Lag or Apply lag at the physical
    > standby database and logical standby database before proceeding
    > with labs.

3.  Display the current configuration and note the current state of
    > fast-start failover.

4.  Enable fast-start failover.

5.  Display a detailed status of the current fast-start failover
    > settings.

6.  Start the observer process.

> **Note:** The prompt will not return after starting the observer. Keep
> this terminal window open with the observer running in it.

Practice 16-3: Testing Fast-Start Failover
------------------------------------------

### Overview

> In this practice, you will simulate a disaster on the primary database
> and observe the automatic failover to the standby database.

### Tasks

1.  Use a terminal window on localhost connected as oracle with the
    environment variables set to orclcdb. Connect to the primary
    database using SQL\*Plus and simulate a failure by issuing the
    shutdown abort command. Exit SQL\*Plus.

2.  Observe the status output in the terminal session connected to
    8c793fb03eed running the observer process from the previous lab
    step. It may take a minute before the failover is initiated.

3.  Use a terminal window on stndby connected as oracle with the
    environment variables set to stndby. Launch the DGMGRL utility and
    connect as the SYSDG user.

4.  Display the current configuration and note the current state of
    fast-start failover.

> **Note:** A series of error messages such as ORA-16844, ORA-16856, and
> ORA-16824 might be displayed for a while. Wait until you see only the
> ORA-16661 message for the orclcdb database.

5.  Use a terminal window on localhost connected as oracle with the
    environment variables set to orclcdb. Connect to the former primary
    database (the new physical standby database) using SQL\*Plus and
    mount the orclcdb database to initiate reinstatement. Exit
    SQL\*Plus.

+---------------------+-----------+---------+
| > Fixed Size        | 9137928   | > bytes |
+=====================+===========+=========+
| > Variable Size     | 377487360 | > bytes |
+---------------------+-----------+---------+
| > Database Buffers  | 234881024 | > bytes |
+---------------------+-----------+---------+
| > Redo Buffers      | 7639040   | > bytes |
+---------------------+-----------+---------+
| > Database mounted. |           |         |
| >                   |           |         |
| > SQL\> **exit**    |           |         |
+---------------------+-----------+---------+

6.  Observe the output in the terminal session on 8c793fb03eed running
    the observer process.

7.  Return to the DGMGRL session running on stndby and display the
    configuration.

> **Note:** The ORA-\* warning messages depend on the lag and overall
> performance of the environment. You may or may not see this warning
> statement. It is a matter of timing.

8.  It may take a few moments for the lag for the standby database to
    clear. Keep displaying the status until it has cleared. Do not
    continue with labs until the apply lag and transport lag have
    cleared.

Practice 16-4: Switchover to Reinstated Database
------------------------------------------------

### Overview

> In this practice, you will perform a switchover to return the
> configuration to the state that it was before the failover.

### Tasks

1.  Validate that the stndby primary database is ready for switchover.

2.  Validate that the orclcdb standby database is ready for switchover.

3.  Switch over to the orclcdb database.

4.  Display the resulting configuration.

> **Note:** A series of error messages such as ORA-16810 and ORA-16786
> might be displayed for a while. Wait until the status of the
> configuration becomes normal.

5.  Stop the observer process.

> **Note:** The prompt should now be returned in the terminal window
> that was connected to
>
> host02 running the observer process.

6.  Disable fast-start failover.

7.  Reset the protection mode back to maximum performance and exit
    DGMGRL.

Practices for Lesson 17: Backup and Recovery Considerations in an Oracle Data Guard Configuration
=================================================================================================

Practices for Lesson 17: Overview
---------------------------------

### Practices Overview

> In these practices, you will enable the change tracing feature and
> setup and configure the recovery manager (RMAN) catalog repository
> database and use it to perform backup and recovery in a Data Guard
> environment.

Practice 17-1: Enable Change Tracking on the Physical Standby Database
----------------------------------------------------------------------

### Overview

> In this practice, you will enable the change tracking feature on
> stndby for the physical standby database and verify its usage.

### Tasks

1.  Use a terminal window logged in as oracle to stndby with the
    environment variables set for stndby appropriately. Using operating
    system authentication, SQL\*Plus connects, by default, to the root
    container in the lab environment. Enable change tracking by using
    the file /u01/app/oracle/oradata/stndby/rman\_change\_track.file.

2.  Verify that block change tracking is enabled, displaying the file
    name used and file size of the block change tracking file.

3.  Exit SQL\*Plus on stndby of the physical standby database. It is
    recommended to keep the terminal session open with the environment
    variables set appropriately.

Practice 17-2: Creating a Recovery Manager Catalog
--------------------------------------------------

### Overview

> In this practice, you will set up and configure the recovery manager
> (RMAN) catalog repository database.

### Tasks

1.  Open a terminal window connected to localhost as the oracle OS user.
    Enter \<password\>

> when you are prompted for the password. Set the environment variables
> to ORCL.

2.  Invoke SQL\*Plus and connect as the SYS user with the SYSDBA
    privilege. List the PDBs in the connected database.

3.  Connect to the RCATPDB PDB.

4.  Determine where the current data files are stored at:

5.  Create a new tablespace for the recovery manager repository using
    the same storage architecture as the existing files. Name the
    tablesace rcts and give it an initial size of 30MB with autoextend
    turned on.

6.  Create a new schema rcowner setting the default tablespace to the
    tablespace just created.

7.  Grant the recovery catalog owner role to the user just created. Exit
    SQL\*Plus when done.

8.  Use a terminal window on localhost connected as oracle with the
    environment variables set to orclcdb. Launch the RMAN utility and
    connect to the rcatpdb service using the account just created.

9.  Create the recovery catalog.

Practice 17-3: Registering Your Database in the Recovery Catalog
----------------------------------------------------------------

### Overview

> In this practice, you register the primary database in the recovery
> catalog.

### Tasks

1.  Return to the RMAN session on localhost. Connect to the orclcdb
    primary database with

> SYSDBA privilege and register the database.
>
> **Note:** Your DBID may be different.

2.  List the DB\_UNIQUE\_NAME for all databases known to the recovery
    catalog.

+---------+---+---------+---------+---+---------+---+---------+
| >       |   |         |         |   |         |   |         |
|  RMAN\> |   |         |         |   |         |   |         |
| >       |   |         |         |   |         |   |         |
|  **list |   |         |         |   |         |   |         |
| > db    |   |         |         |   |         |   |         |
| \_uniqu |   |         |         |   |         |   |         |
| e\_name |   |         |         |   |         |   |         |
| > of    |   |         |         |   |         |   |         |
| > data  |   |         |         |   |         |   |         |
| base;** |   |         |         |   |         |   |         |
+=========+===+=========+=========+===+=========+===+=========+
| > List  |   | > Da    | > DB ID |   | > D     |   | > Db    |
| > of DB |   | tabases |         |   | atabase |   | \_uniqu |
| > Key   |   | > DB    |         |   | > Role  |   | e\_name |
|         |   | > Name  |         |   |         |   |         |
+---------+---+---------+---------+---+---------+---+---------+
| > 1     |   |         |         |   |         |   |         |
| >       |   |         |         |   |         |   |         |
| ORCLCDB |   |         |         |   |         |   |         |
| > 273   |   |         |         |   |         |   |         |
| 2402101 |   |         |         |   |         |   |         |
| >       |   |         |         |   |         |   |         |
| PRIMARY |   |         |         |   |         |   |         |
| >       |   |         |         |   |         |   |         |
| ORCLCDB |   |         |         |   |         |   |         |
+---------+---+---------+---------+---+---------+---+---------+

3.  Generate a schema report for the orclcdb primary database.

> 1 960 SYSTEM YES
>
> /u01/app/oracle/oradata/ORCLCDB/system01.dbf

3.  940 SYSAUX NO

> /u01/app/oracle/oradata/ORCLCDB/sysaux01.dbf

4.  280 UNDOTBS1 YES

> /u01/app/oracle/oradata/ORCLCDB/undotbs01.dbf

5.  270 PDB\$SEED:SYSTEM NO

> /u01/app/oracle/oradata/ORCLCDB/pdbseed/system01.dbf

6.  330 PDB\$SEED:SYSAUX NO

> /u01/app/oracle/oradata/ORCLCDB/pdbseed/sysaux01.dbf

7.  5 USERS NO

> /u01/app/oracle/oradata/ORCLCDB/users01.dbf

8.  100 PDB\$SEED:UNDOTBS1 NO

> /u01/app/oracle/oradata/ORCLCDB/pdbseed/undotbs01.dbf

9.  510 DEV1:SYSTEM YES

> /u01/app/oracle/oradata/ORCLCDB/dev1/system01.dbf

10. 370 DEV1:SYSAUX NO

> /u01/app/oracle/oradata/ORCLCDB/dev1/sysaux01.dbf

11. 100 DEV1:UNDOTBS1 YES

> /u01/app/oracle/oradata/ORCLCDB/dev1/undotbs01.dbf

12. 5 DEV1:USERS NO

> /u01/app/oracle/oradata/ORCLCDB/dev1/users01.dbf
>
> List of Temporary Files
>
> =======================
>
> File Size(MB) Tablespace Maxsize(MB) Tempfile Name
>
> \-\--
>
> 1 132 TEMP 32767
>
> /u01/app/oracle/oradata/ORCLCDB/temp01.dbf
>
> 2 36 PDB\$SEED:TEMP 32767
>
> /u01/app/oracle/oradata/ORCLCDB/pdbseed/temp012020-06-04\_02-09-
> 11-127-AM.dbf
>
> 3 36 DEV1:TEMP 32767
>
> /u01/app/oracle/oradata/ORCLCDB/dev1/temp01.dbf
>
> RMAN\>

4.  List all the archive logs for the orclcdb primary database.

5.  Display all the current configuration parameters for the orclcdb
    primary database.

#### RMAN\> show all for db\_unique\_name orclcdb;

> RMAN configuration parameters for database with db\_unique\_name
> ORCLCDB are:
>
> CONFIGURE RETENTION POLICY TO REDUNDANCY 1; \# default CONFIGURE
> BACKUP OPTIMIZATION OFF; \# default CONFIGURE DEFAULT DEVICE TYPE TO
> DISK; \# default CONFIGURE CONTROLFILE AUTOBACKUP ON; \# default
>
> CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO
>
> \'%F\'; \# default
>
> CONFIGURE DEVICE TYPE DISK PARALLELISM 1 BACKUP TYPE TO
>
> BACKUPSET; \# default
>
> CONFIGURE DATAFILE BACKUP COPIES FOR DEVICE TYPE DISK TO 1; \#
>
> default
>
> CONFIGURE ARCHIVELOG BACKUP COPIES FOR DEVICE TYPE DISK TO 1; \#
>
> default
>
> CONFIGURE MAXSETSIZE TO UNLIMITED; \# default CONFIGURE ENCRYPTION FOR
> DATABASE OFF; \# default CONFIGURE ENCRYPTION ALGORITHM \'AES128\'; \#
> default
>
> CONFIGURE COMPRESSION ALGORITHM \'BASIC\' AS OF RELEASE \'DEFAULT\'
> OPTIMIZE FOR LOAD TRUE ; \# default
>
> CONFIGURE RMAN OUTPUT TO KEEP FOR 7 DAYS; \# default CONFIGURE
> ARCHIVELOG DELETION POLICY TO NONE; \# default
>
> CONFIGURE SNAPSHOT CONTROLFILE NAME TO
>
> \'/u01/app/oracle/product/19.3.0/dbhome\_1/dbs/snapcf\_orclcdb.f\'; \#
> default
>
> RMAN\>

Practice 17-4: Configuring RMAN Parameters
------------------------------------------

### Overview

> In this practice, you will configure RMAN for use in a Data Guard
> environment.

### Tasks

1.  In your RMAN session (connected to your primary database), configure
    the backup retention policy to allow for recovery for seven days.

2.  Specify that archived redo log files can be deleted after they are
    applied to the standby database.

3.  Configure the connect identifier for your primary database.

4.  Configure the connect identifier for your physical standby database.

5.  Your physical standby database is registered with the recovery
    catalog. Use the LIST DB\_UNIQUE\_NAME command to see the
    registration information about your primary and standby databases.

6.  Use the REPORT SCHEMA command to view additional information about
    your physical standby database. Exit RMAN when done.

  File       Size(MB)      Tablespace              RB segs      Datafile Name
  ------- -- ---------- -- -------------------- -- --------- -- ---------------
  \-\--                                                         
  1          960           SYSTEM                  YES          
  3          940           SYSAUX                  NO           
  4          280           UNDOTBS1                YES          
  5          270           PDB\$SEED:SYSTEM        NO           
  6          330           PDB\$SEED:SYSAUX        NO           
  7          5             USERS                   NO           
  8          100           PDB\$SEED:UNDOTBS1      NO           
  9          510           DEV1:SYSTEM             YES          
  10         370           DEV1:SYSAUX             NO           
  11         100           DEV1:UNDOTBS1           YES          
  12         5             DEV1:USERS              NO           

Practice 17-5: Recovering a Data File on Your Primary Database Over the Network
-------------------------------------------------------------------------------

### Overview

> In this practice, you recover a data file in your primary database by
> using a data file from your physical standby database. You will create
> a new data file in order to simulate a disaster, without affecting the
> existing data files on the primary database.

### Tasks

1.  The logical standby database does not honor the
    DB\_FILE\_NAME\_CONVERT parameter. This will cause an error when a
    tablespace is created on the primary database and force the Logical
    Apply process to shut down because the directory doesn\'t exit. Use
    a terminal window logged in as oracle to stndby. Create a symbolic
    link ORCLCDB linking to stndby2 so that file creation can proceed.

> **Note:** The Data Guard documentation shows how to create a DDL
> handler using a procedure, along with the built-in DBMS\_LOGSTDBY.SKIP
> procedure to skip over the DDL with the wrong path names and invoke
> the handler to rename the path in the command.

2.  Use a terminal window logged in as oracle to localhost with the
    environment variables set for orclcdb appropriately. Launch
    SQL\*Plus and create a new tablespace SAMPLE in the DEV1 pluggable
    database with a data file

> /u01/app/oracle/oradata/orclcdb/dev1/sample01.dbf and a size of 5 MB.

3.  Connect to your physical standby instance as the SYSDBA user and
    show the

> standby\_file\_management parameter.

+--------------------------------------------------------+---+----------+---+---------+
| > SQL\> **connect sys/\<password\>\@stndby as sysdba** |   |          |   |         |
| >                                                      |   |          |   |         |
| > Connected.                                           |   |          |   |         |
| >                                                      |   |          |   |         |
| > SQL\> **show parameter standby\_file\_management**   |   |          |   |         |
+========================================================+===+==========+===+=========+
| > NAME                                                 |   | > TYPE   |   | > VALUE |
+--------------------------------------------------------+---+----------+---+---------+
| > standby\_file\_management SQL\>                      |   | > string |   | > AUTO  |
+--------------------------------------------------------+---+----------+---+---------+

4.  Verify that the data file has successfully been created on the
    physical standby database.

5.  Connect to your logical standby instance as the SYSDBA user.

6.  Verify that the data file has successfully been created on the
    logical standby database.

#### SQL\> select file\#,name from v\$datafile;

> FILE\# NAME
>
> 1 /u01/app/oracle/oradata/stndby2/system01.dbf

3.  /u01/app/oracle/oradata/stndby2/sysaux01.dbf

4.  /u01/app/oracle/oradata/stndby2/undotbs01.dbf

5.  /u01/app/oracle/oradata/stndby2/pdbseed/system01.dbf

6.  /u01/app/oracle/oradata/stndby2/pdbseed/sysaux01.dbf

7.  /u01/app/oracle/oradata/stndby2/users01.dbf

8.  /u01/app/oracle/oradata/stndby2/pdbseed/undotbs01.dbf

9.  /u01/app/oracle/oradata/stndby2/dev1/system01.dbf

10. /u01/app/oracle/oradata/stndby2/dev1/sysaux01.dbf

11. /u01/app/oracle/oradata/stndby2/dev1/undotbs01.dbf

12. /u01/app/oracle/oradata/stndby2/dev1/users01.dbf

> FILE\# NAME
>
> 25 /u01/app/oracle/oradata/ORCLCDB/dev1/sample01.dbf
>
> 12 rows selected.
>
> SQL\>

7.  Reconnect to your primary database and create the hr.employees2
    table as a copy of the hr.employees table into the newly created
    tablespace. Exit SQL\*Plus.

8.  Verify that the table was created by counting the number of rows it
    contains.

9.  Move the sample01.dbf file to sample01.sav to simulate a failure in
    the primary database.

10. Connect to the root container and shut down abort the primary
    database. Exit SQL\*Plus.

11. Launch SQL\*Plus and start the database instance. Exit SQL\*Plus.

+---------------------+-----------+---------+
| > Fixed Size        | 9137928   | > bytes |
+=====================+===========+=========+
| > Variable Size     | 377487360 | > bytes |
+---------------------+-----------+---------+
| > Database Buffers  | 234881024 | > bytes |
+---------------------+-----------+---------+
| > Redo Buffers      | 7639040   | > bytes |
+---------------------+-----------+---------+
| > Database mounted. |           |         |
+---------------------+-----------+---------+
| > Database opened.  |           |         |
+---------------------+-----------+---------+

12. Use RMAN to restore the missing datafile using the physical standby
    database over the network. Exit RMAN when done.

13. Launch SQL\*Plus and switch the container to the pluggable database.

14. Verify that the table has been recovered and the rows exist in the
    table.

15. Drop the tablespace that was created in the lab along with the data
    files. Exit SQL\*Plus.

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

Practices for Lesson 18: Enhanced Client Connectivity in a Data Guard Environment
=================================================================================

Practices for Lesson 18: Overview
---------------------------------

### Practices Overview

> In these practices, you will create a service to connect to the DEV1
> pluggable database, and also create a database startup trigger that
> will start the service on any host machine that the primary database
> is running on. You will also modify the service to support Application
> Continuity and test it.

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

2.  Launch SQL\*Plus and set the session container to the DEV1 pluggable
    database.

3.  Modify the service PRMY.EXAMPLE.COM to support Application
    Continuity. Exit SQL\*Plus.

#### SQL\> @/home/oracle/setup/modify\_svc.sql

> SQL\> DECLARE

2.  params dbms\_service.svc\_parameter\_array;

3.  BEGIN

4.  params(\'FAILOVER\_TYPE\'):=\'TRANSACTION\';

5.  params(\'REPLAY\_INITIATION\_TIMEOUT\'):=1800;

6.  params(\'RETENTION\_TIMEOUT\'):=86400;

7.  params(\'FAILOVER\_DELAY\'):=10;

8.  params(\'FAILOVER\_RETRIES\'):=30;

9.  params(\'FAILOVER\_RESTORE\'):=\'LEVEL1\';

10. params(\'commit\_outcome\'):=\'true\';

11. params(\'aq\_ha\_notifications\'):=\'true\';

12. dbms\_service.modify\_service(\'prmy.example.com\',params);

13. END;

> 14 /
>
> PL/SQL procedure successfully completed.
>
> SQL\> **exit**
>
> Disconnected from Oracle Database 19c Enterprise Edition Release
>
> 19.0.0.0.0 - Production Version 19.3.0.0.0 \[oracle\@localhost \~\]\$
>
> **Note:** You have to set two mandatory service attributes
> (FAILOVER\_TYPE and
>
> COMMIT\_OUTCOME) to enable the Application Continuity feature.

4.  Examine the script that you will soon use to execute the practice
    application. The script executes the application code called
    actest.jar.

5.  Examine the properties file.

    -   Use the Replay Data source:
        oracle.jdbc.replay.OracleDataSourceImpl

    -   Use the Application Continuity enabled service: prmy

    -   Use the Application Continuity supported connection pool: UCP

6.  Use the terminal window connected to host02. Execute the practice
    application. While the application runs, a periodic status message
    is displayed.

7.  While the application continues to execute, return to the DGMGRL
    session on localhost. Check the status of the data guard
    configuration and wait until all warning messages are cleared.

8.  Verify that both databases are ready for switchover, and then
    perform a switchover.

9.  Return to the terminal session on host02. Press Ctrl+C to abort the
    application.

<table>
<thead>
<tr class="header">
<th><blockquote>
<p>…</p>
<p>2</p>
</blockquote></th>
<th><blockquote>
<p>active</p>
</blockquote></th>
<th><blockquote>
<p>connections,</p>
</blockquote></th>
<th><blockquote>
<p>avg</p>
</blockquote></th>
<th><blockquote>
<p>response</p>
</blockquote></th>
<th><blockquote>
<p>time</p>
</blockquote></th>
<th><blockquote>
<p>from</p>
</blockquote></th>
<th><blockquote>
<p>db</p>
</blockquote></th>
<th><blockquote>
<p>5</p>
</blockquote></th>
<th><blockquote>
<p>ms</p>
</blockquote></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>2</td>
<td><blockquote>
<p>active</p>
</blockquote></td>
<td><blockquote>
<p>connections,</p>
</blockquote></td>
<td><blockquote>
<p>avg</p>
</blockquote></td>
<td><blockquote>
<p>response</p>
</blockquote></td>
<td><blockquote>
<p>time</p>
</blockquote></td>
<td><blockquote>
<p>from</p>
</blockquote></td>
<td><blockquote>
<p>db</p>
</blockquote></td>
<td><blockquote>
<p>5</p>
</blockquote></td>
<td><blockquote>
<p>ms</p>
</blockquote></td>
</tr>
<tr class="even">
<td>0</td>
<td><blockquote>
<p>active</p>
</blockquote></td>
<td><blockquote>
<p>connections,</p>
</blockquote></td>
<td><blockquote>
<p>avg</p>
</blockquote></td>
<td><blockquote>
<p>response</p>
</blockquote></td>
<td><blockquote>
<p>time</p>
</blockquote></td>
<td><blockquote>
<p>from</p>
</blockquote></td>
<td><blockquote>
<p>db</p>
</blockquote></td>
<td><blockquote>
<p>5</p>
</blockquote></td>
<td><blockquote>
<p>ms</p>
</blockquote></td>
</tr>
<tr class="odd">
<td>2</td>
<td><blockquote>
<p>active</p>
</blockquote></td>
<td><blockquote>
<p>connections,</p>
</blockquote></td>
<td><blockquote>
<p>avg</p>
</blockquote></td>
<td><blockquote>
<p>response</p>
</blockquote></td>
<td><blockquote>
<p>time</p>
</blockquote></td>
<td><blockquote>
<p>from</p>
</blockquote></td>
<td><blockquote>
<p>db</p>
</blockquote></td>
<td><blockquote>
<p>5</p>
</blockquote></td>
<td><blockquote>
<p>ms</p>
</blockquote></td>
</tr>
<tr class="even">
<td><blockquote>
<p>1</p>
<p>2</p>
</blockquote></td>
<td><blockquote>
<p>active active</p>
</blockquote></td>
<td><blockquote>
<p>connections, connections,</p>
</blockquote></td>
<td><blockquote>
<p>avg avg</p>
</blockquote></td>
<td><blockquote>
<p>response response</p>
</blockquote></td>
<td><blockquote>
<p>time time</p>
</blockquote></td>
<td><blockquote>
<p>from from</p>
</blockquote></td>
<td><blockquote>
<p>db db</p>
</blockquote></td>
<td><blockquote>
<p>111 ms</p>
<p>5 ms</p>
</blockquote></td>
<td></td>
</tr>
<tr class="odd">
<td>2</td>
<td><blockquote>
<p>active</p>
</blockquote></td>
<td><blockquote>
<p>connections,</p>
</blockquote></td>
<td><blockquote>
<p>avg</p>
</blockquote></td>
<td><blockquote>
<p>response</p>
</blockquote></td>
<td><blockquote>
<p>time</p>
</blockquote></td>
<td><blockquote>
<p>from</p>
</blockquote></td>
<td><blockquote>
<p>db</p>
</blockquote></td>
<td><blockquote>
<p>7</p>
</blockquote></td>
<td><blockquote>
<p>ms</p>
</blockquote></td>
</tr>
<tr class="even">
<td>0</td>
<td><blockquote>
<p>active</p>
</blockquote></td>
<td><blockquote>
<p>connections,</p>
</blockquote></td>
<td><blockquote>
<p>avg</p>
</blockquote></td>
<td><blockquote>
<p>response</p>
</blockquote></td>
<td><blockquote>
<p>time</p>
</blockquote></td>
<td><blockquote>
<p>from</p>
</blockquote></td>
<td><blockquote>
<p>db</p>
</blockquote></td>
<td><blockquote>
<p>6</p>
</blockquote></td>
<td><blockquote>
<p>ms</p>
</blockquote></td>
</tr>
<tr class="odd">
<td>1</td>
<td><blockquote>
<p>active</p>
</blockquote></td>
<td><blockquote>
<p>connections,</p>
</blockquote></td>
<td><blockquote>
<p>avg</p>
</blockquote></td>
<td><blockquote>
<p>response</p>
</blockquote></td>
<td><blockquote>
<p>time</p>
</blockquote></td>
<td><blockquote>
<p>from</p>
</blockquote></td>
<td><blockquote>
<p>db</p>
</blockquote></td>
<td><blockquote>
<p>5</p>
</blockquote></td>
<td><blockquote>
<p>ms</p>
</blockquote></td>
</tr>
<tr class="even">
<td>2</td>
<td><blockquote>
<p>active</p>
</blockquote></td>
<td><blockquote>
<p>connections,</p>
</blockquote></td>
<td><blockquote>
<p>avg</p>
</blockquote></td>
<td><blockquote>
<p>response</p>
</blockquote></td>
<td><blockquote>
<p>time</p>
</blockquote></td>
<td><blockquote>
<p>from</p>
</blockquote></td>
<td><blockquote>
<p>db</p>
</blockquote></td>
<td><blockquote>
<p>5</p>
</blockquote></td>
<td><blockquote>
<p>ms</p>
</blockquote></td>
</tr>
<tr class="odd">
<td>…</td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>
</tbody>
</table>

> **Note:** Your application is still connected without having any
> connection issues. There was only a small delay during the switchover
> operation.

10. (**Optional**) Return to the DGMGRL session on localhost.
    Optionally, switch back to the original state.

11. Exit DGMGRL on localhost.

Practices for Lesson 19: Patching and Upgrading Databases in a Data Guard Configuration
=======================================================================================

Practices for Lesson 19
-----------------------

> There are no practices for this lesson.
