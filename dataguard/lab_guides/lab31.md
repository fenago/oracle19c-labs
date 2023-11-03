
Practice 17-3: Registering Your Database in the Recovery Catalog
----------------------------------------------------------------

### Overview

> In this practice, you register the primary database in the recovery
> catalog.

### Tasks

1.  Return to the RMAN session on localhost. Connect to the orclcdb
    primary database with SYSDBA privilege and register the database.

    ```
    RMAN> connect target 'sys/<password>@orclcdb as sysdba' 
    
    RMAN> register database;
    ```

> **Note:** Your DBID may be different.

2.  List the DB\_UNIQUE\_NAME for all databases known to the recovery
    catalog.
    
    ```
    RMAN> list db_unique_name of database;
    ```

3.  Generate a schema report for the orclcdb primary database.

    ```
    RMAN> report schema for db_unique_name orclcdb;
    ```

4.  List all the archive logs for the orclcdb primary database.

    ```
    RMAN> list archivelog all for db_unique_name orclcdb;
    ```

5.  Display all the current configuration parameters for the orclcdb
    primary database.

    ```
    RMAN> show all for db_unique_name orclcdb;
    ```