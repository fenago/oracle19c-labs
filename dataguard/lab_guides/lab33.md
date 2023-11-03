
Lab: Recovering a Data File on Your Primary Database Over the Network
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
    a terminal window logged in as oracle to orcldg. Create a symbolic
    link ORCLCDB linking to orcldg2 so that file creation can proceed.

    ```
    [oracle@orcldg ~]$ cd /u01/app/oracle/oradata
    [oracle@orcldg oradata]$ ln -s orcldg2 ORCLCDB
    ```

> **Note:** The Data Guard documentation shows how to create a DDL
> handler using a procedure, along with the built-in DBMS\_LOGSTDBY.SKIP
> procedure to skip over the DDL with the wrong path names and invoke
> the handler to rename the path in the command.

2.  Use a terminal window logged in as oracle to localhost with the
    environment variables set for orclcdb appropriately. Launch
    SQL\*Plus and create a new tablespace SAMPLE in the DEV1 pluggable
    database with a data file `/u01/app/oracle/oradata/orclcdb/dev1/sample01.dbf` and a size of 5 MB.

    ```
    [oracle@localhost ~]$ sqlplus / as sysdba

    SQL> alter session set container=DEV1;

    SQL> create tablespace SAMPLE datafile '/u01/app/oracle/oradata/ORCLCDB/dev1/sample01.dbf' size 5M;
    ```


3.  Connect to your physical standby instance as the SYSDBA user and
    show the standby\_file\_management parameter.

    ```
    SQL> connect sys/<password>@stndby as sysdba

    SQL> show parameter standby_file_management
    ```

4.  Verify that the data file has successfully been created on the
    physical standby database.

    ```
    SQL> col name format a65
    SQL> select file#,name from v$datafile;
    ```

5.  Connect to your logical standby instance as the SYSDBA user.

    ```
    SQL> connect sys/<password>@orcldg2 as sysdba
    ```

6.  Verify that the data file has successfully been created on the
    logical standby database.

    ```
    SQL> select file#,name from v$datafile;
    ```

7.  Reconnect to your primary database and create the hr.employees2
    table as a copy of the hr.employees table into the newly created
    tablespace. Exit SQL\*Plus.

    ```
    SQL> connect system/<password>@localhost:1521/DEV1.example.com
    Connected.

    SQL> create table hr.employees2 tablespace sample as select * from hr.employees;

    Table created.
    ```

8.  Verify that the table was created by counting the number of rows it
    contains.

    ```
    SQL> select count(*) from hr.employees2;
    ```

9.  Move the sample01.dbf file to sample01.sav to simulate a failure in
    the primary database.

    ```
    SQL> !mv /u01/app/oracle/oradata/ORCLCDB/dev1/sample01.dbf
    /u01/app/oracle/oradata/ORCLCDB/dev1/sample01.sav
    ```

10. Connect to the root container and shut down abort the primary
    database. Exit SQL\*Plus.

    ```
    SQL> connect sys/<password>@orclcdb as sysdba

    SQL> shutdown abort

    SQL> exit
    ```

11. Launch SQL\*Plus and start the database instance. Exit SQL\*Plus.

    ```
    [oracle@localhost]$ sqlplus / as sysdba

    SQL> startup

    SQL> alter pluggable database dev1 open;

    SQL> exit
    ```

12. Use RMAN to restore the missing datafile using the physical standby
    database over the network. Exit RMAN when done.

    ```
    [oracle@localhost ~]$ rman target sys/<password>@orclcdb

    RMAN> restore datafile 25 from service 'stndby';

    RMAN> recover datafile 25;

    RMAN> exit
    ```

13. Launch SQL\*Plus and switch the container to the pluggable database.

    ```
    [oracle@localhost ~]$ sqlplus / as sysdba

    SQL> show pdbs
    ```

14. Verify that the table has been recovered and the rows exist in the
    table.

    ```
    SQL> alter session set container = DEV1;

    SQL> select * from hr.employees2;
    ```

15. Drop the tablespace that was created in the lab along with the data
    files. Exit SQL\*Plus.

    ```
    SQL> drop tablespace sample including contents and datafiles;
    
    SQL> exit
    ```