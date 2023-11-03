


Practice 17-4: Configuring RMAN Parameters
------------------------------------------

### Overview

> In this practice, you will configure RMAN for use in a Data Guard
> environment.

### Tasks

1.  In your RMAN session (connected to your primary database), configure
    the backup retention policy to allow for recovery for seven days.

    ```
    RMAN> configure retention policy to recovery window of 7 days;
    ```

2.  Specify that archived redo log files can be deleted after they are
    applied to the standby database.

    ```
    RMAN> configure archivelog deletion policy to applied on all standby;
    ```

3.  Configure the connect identifier for your primary database.

    ```
    RMAN> configure db_unique_name orclcdb connect identifier 'orclcdb';
    ```

4.  Configure the connect identifier for your physical standby database.

    ```
    RMAN> configure db_unique_name orcldg connect identifier 'orcldg';
    ```

5.  Your physical standby database is registered with the recovery
    catalog. Use the LIST DB\_UNIQUE\_NAME command to see the
    registration information about your primary and standby databases.

    ```
    RMAN> list db_unique_name of database;
    ```

6.  Use the REPORT SCHEMA command to view additional information about
    your physical standby database. Exit RMAN when done.

    ```
    RMAN> report schema for db_unique_name orcldg;

    RMAN> report schema for db_unique_name orcldg;
    ```