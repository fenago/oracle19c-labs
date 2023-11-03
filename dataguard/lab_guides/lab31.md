
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