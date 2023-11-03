
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