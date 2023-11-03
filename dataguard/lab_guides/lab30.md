
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

    ```
    [oracle8c793fb03eed ~]$ . oraenv ORACLE_SID = [ORCL] ? ORCL
    The Oracle base remains unchanged with value /u01/app/oracle
    ```

2.  Invoke SQL\*Plus and connect as the SYS user with the SYSDBA
    privilege. List the PDBs in the connected database.

    ```
    [oracle8c793fb03eed ~]$ sqlplus / as sysdba
    ```

3.  Connect to the RCATPDB PDB.

    ```
    SQL> alter session set container=ORCL;
    Session altered. SQL>
    ```

4.  Determine where the current data files are stored at:

    ```
    SQL> select file_name from dba_data_files;
    ```

5.  Create a new tablespace for the recovery manager repository using
    the same storage architecture as the existing files. Name the
    tablesace rcts and give it an initial size of 30MB with autoextend
    turned on.

    ```
    SQL> create tablespace rcts datafile '/u01/app/oracle/oradata/ORCL/rcts01.dbf' size 30M autoextend on;

    Tablespace created.
    ```

6.  Create a new schema rcowner setting the default tablespace to the
    tablespace just created.

    ```
    SQL> create user rcowner identified by <password> default tablespace rcts quota unlimited on rcts;

    User created.
    ```

7.  Grant the recovery catalog owner role to the user just created. Exit
    SQL\*Plus when done.

    ```
    SQL> grant recovery_catalog_owner to rcowner;
    Grant succeeded.

    SQL> exit
    Disconnected from Oracle Database 19c Enterprise Edition Release
    19.0.0.0.0 - Production Version 19.3.0.0.0
    [oracle8c793fb03eed ~]$
    ```

8.  Use a terminal window on localhost connected as oracle with the
    environment variables set to orclcdb. Launch the RMAN utility and
    connect to the rcatpdb service using the account just created.

    ```
    [oracle@localhost ~]$ . oraenv
    ORACLE_SID = [oracle] ? orclcdb
    The Oracle base has been set to /u01/app/oracle
    [oracle@localhost ~]$ rman catalog rcowner/<password>@em13c:1521/ORCL

    Recovery Manager: Release 19.0.0.0.0 - Production on Sun Jun 7 13:05:44 2020
    Version 19.3.0.0.0

    (c) 1982, 2019, Oracle and/or its affiliates. All rights reserved.

    connected to recovery catalog database
    ```
    
9.  Create the recovery catalog.

    ```
    RMAN> create catalog;
    recovery catalog created
    ```