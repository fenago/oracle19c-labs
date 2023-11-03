
Practice 17-3: Registering Your Database in the Recovery Catalog
----------------------------------------------------------------

### Overview

> In this practice, you register the primary database in the recovery
> catalog.

### Tasks

1.  Return to the RMAN session on localhost. Connect to the orclcdb
    primary database with
> SYSDBA privilege and register the database.

    ```
    RMAN> connect target 'sys/<password>@orclcdb as sysdba' connected to target database: ORCLCDB (DBID=2732402101) RMAN> register database;
    database registered in recovery catalog starting full resync of recovery catalog full resync complete

    RMAN>
    ```

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