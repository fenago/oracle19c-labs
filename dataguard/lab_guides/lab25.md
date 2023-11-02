
Lab: Configuring Network Compression of Redo Data
-------------------------------------------------


### Overview

> In this lab, you will set the RedoCompression property to
> configure network compression of redo data.

### Tasks

1.  Use a terminal window logged in as oracle to localhost with the
    environment variables set for orclcdb appropriately. Launch
    SQL\*Plus on your primary database and determine if redo compression
    is enabled by querying V\$ARCHIVE\_DEST.

    ```
    [oracle@localhost ~]$ . oraenv
    ORACLE_SID = [oracle] ? orclcdb
    The Oracle base has been set to /u01/app/oracle 

    [oracle@localhost ~]$ sqlplus / as sysdba


    SQL> col dest_name format a30
    SQL> select dest_name, compression from v$archive_dest;
    ```

2.  Use a terminal window logged in as oracle to host02 with the
    environment variables set for orclcdbFS appropriately. Launch DGMGRL
    and connect to the primary database.

    ```
    [oracle@host02 ~]$ . oraenv
    ORACLE_SID = [oracle] ? orclcdb
    The Oracle base has been set to /u01/app/oracle 

    [oracle@host02 ~]$ dgmgrl

    DGMGRL> connect sysdg/<password>@orclcdb 

    Connected to "orclcdb"
    Connected as SYSDG.
    DGMGRL>
    ```

3.  Enable redo compression by setting the RedoCompression property for
    your database. Exit DGMGRL.

    ```
    DGMGRL> edit database 'orclcdb' set property 'RedoCompression'='ENABLE';

    DGMGRL> exit
    ```

4.  Return to your SQL*Plus session on localhost and query `V$ARCHIVE_DEST` again. Note that compression is
    set for `LOG_ARCHIVE_DEST_2`. Exit SQL*Plus..

    ```
    SQL> select dest_name, compression from v$archive_dest;

    SQL> show parameter log_archive_dest_2

    exit
    ```