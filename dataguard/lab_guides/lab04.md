# Oracle Data Guard 19c Scripts Guide: Exploring `dg_scripts`

## Objective:
This guide will introduce you to some important scripts located in the `dg_scripts` directory, which play a pivotal role in managing and monitoring the Oracle Data Guard environment.

## Prerequisites:
- Ensure you have access to an Oracle 19c environment.
- Familiarity with SQL*Plus and basic Oracle administration tasks is beneficial.

## Accessing the `dg_scripts` Directory:

To access the `dg_scripts` directory, follow these steps:

1. Open a new terminal.
2. Switch to the Oracle user:
```bash
su - oracle
```
3. Navigate to the `dg_scripts` directory:
```bash
cd /u01/app/oracle/admin/scripts/dg_scripts
```

## Important Scripts:

### 1. `create_standby.sql`
This script is likely used to facilitate the creation of the standby database by generating necessary configuration and setting up parameters.

### 2. `dg_verify.sql`
This script verifies the Data Guard configuration, ensuring that everything is set up correctly and that both primary and standby databases are in sync.

### 3. `enable_dg.sql`
Enables the Data Guard configuration, allowing the standby database to start receiving redo logs from the primary database.

### 4. `gap_status.sql`
Checks for any gaps in the archived redo logs between the primary and standby databases. This is crucial for ensuring data integrity and synchronization.

### 5. `mr.sql`
select * from v$managed_standby
where process like 'MR%'

### 6. `defer_log_ship.sql`
This script defers or postpones the shipping of redo logs from the primary to the standby database. This can be useful during maintenance activities.

### 7. `disable_dg.sql`
Disables the Data Guard configuration, stopping the standby database from receiving redo logs.

### 8. `enable_log_ship.sql`
Re-enables the shipping of redo logs after they have been deferred using `defer_log_ship.sql`.

### 9. `log_ship.sql`
Could be a utility script to manually ship redo logs from the primary to the standby database.

## Running the Scripts:

To execute any of these scripts on your Oracle environment:

1. Connect to SQL*Plus as an appropriate user (typically `sys` as `sysdba`):
\```bash
sqlplus sys as sysdba
\```
2. Run the desired script. For example, to run `create_standby.sql`:
\```sql
@create_standby.sql
\```

## Conclusion:
These scripts are essential tools in the arsenal of a DBA managing Oracle Data Guard environments. While the names of the scripts give a hint about their functionality, it's always advisable to explore the content of each script to understand its exact operations. Always exercise caution and ensure you have backups before running any script on a production environment.

