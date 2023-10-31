# Oracle Data Guard 19c Lab Guide: Enabling the Standby Database

## Objective:
In this lab guide, you'll learn how to enable and configure a standby database in an Oracle Data Guard 19c environment. This will provide data protection and disaster recovery capabilities for your primary database.

## Prerequisites:
- Ensure you have access to an Oracle 19c environment.
- You must have the necessary privileges to create and manage a standby database.
- The primary database should be running, and the standby database should be initialized in `NOMOUNT` mode.

## Steps:

### Enabling the Standby Database:

#### 1. Connect to RMAN with the Primary and Standby Database:
Oracle Recovery Manager (RMAN) is the utility used to back up, restore, and duplicate Oracle databases. In this step, you'll connect to both the primary and standby databases using RMAN.
```bash
$ rman target sys/fenago@orclcdb auxiliary sys/fenago@orcldg
```
**Explanation:** 
- The `target` is the primary database, identified by the connection string `sys/fenago@orclcdb`.
- The `auxiliary` is the standby database, identified by the connection string `sys/fenago@orcldg`.

#### 2. Duplicate the Primary Database for Standby:
Within the RMAN prompt, execute the following command to duplicate the primary database to create the standby:
```sql
rman> duplicate target database for standby from active database;
```
**Explanation:** 
- This command tells RMAN to duplicate the currently active primary database to create the standby database.
- The `for standby` clause indicates the purpose of the duplication is to create a standby database.

### Additional Data Guard Scripts:
Oracle Data Guard deployments often come with a set of scripts that help manage and monitor the Data Guard configuration. As per your note, these scripts can be found under `$ORACLE_BASE/admin/scripts/dg_scripts`.

To execute a specific script (for example, `script_name.sql`), navigate to the directory and run:
```bash
$ sqlplus / as sysdba @script_name.sql
```
**Note:** Always review and understand the purpose of each script before execution.

## Conclusion:
You've successfully enabled and configured the standby database in your Oracle Data Guard 19c environment. The standby is now ready to receive and apply redo data from the primary database, ensuring data protection and disaster recovery capabilities. Always follow best practices when working with Oracle, and ensure you have the necessary privileges for every operation.
