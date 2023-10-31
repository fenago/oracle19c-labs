# Oracle Data Guard 19c Lab Guide: Starting a Standby Database

## Objective:
In this lab guide, you'll learn how to create a standby database in a Data Guard 19c environment. The standby database will be used as a backup to the primary database, allowing for data protection and disaster recovery.

## Prerequisites:
- Ensure you have access to an Oracle 19c environment.
- You must have the necessary privileges to create and manage a standby database.

## Steps:

### Setting Up the Standby (Secondary) Environment:

#### 1. Set the Oracle SID for the Standby Database:
The Oracle System ID (SID) uniquely identifies a particular database on a system. For the standby database, we'll use a different SID from the primary.
```bash
export ORACLE_SID=orcldg
```
**Note:** Ensure there's no space around the equals sign.

**Explanation:** The SID for the standby database (in this example, "orcldg") is different from the primary database to distinguish between the two environments.

#### 2. Connect to SQL*Plus as SYSDBA on the Standby:
SQL*Plus is a command-line tool that allows you to interact with the Oracle database. Connecting as SYSDBA provides administrative privileges.
```bash
sqlplus / as sysdba
```
**Explanation:** The `/ as sysdba` syntax allows you to connect to the database without a username or password, assuming you have the necessary operating system privileges.

#### 3. Start the Standby Database in "NOMOUNT" Mode:
In this step, you'll start the Oracle instance without mounting the database. This is the first stage in the process of creating the standby database.
```sql
startup nomount
```
**Explanation:** Starting the database in "NOMOUNT" mode initializes the Oracle instance (background processes and memory structures) without actually mounting a database. It's a necessary step before creating or restoring a database.

### Creating the Standby Database:
Once the standby environment is set up, you would typically follow additional steps to actually create or configure the standby database. This usually involves:
- Transferring a backup of the primary database to the standby server.
- Using `RMAN` (Oracle's Recovery Manager) to restore the database backup on the standby server.
- Configuring Data Guard to manage and synchronize the primary and standby databases.

**Note:** These detailed steps are beyond the scope of the initial instructions provided but are crucial for a complete Data Guard setup.

## Exiting SQL*Plus and Returning to the Command Line:
After you've completed the steps in SQL*Plus, you may want to exit and return to the command line:
```sql
exit
```
**Explanation:** The `exit` command will close SQL*Plus and return you to the bash or command prompt.

## Conclusion:
You've successfully set up the initial environment for a standby database in a Data Guard 19c setup. Remember, this is just the beginning of the Data Guard configuration process. Further steps involving backup, restoration, and synchronization are needed to have a fully operational standby database in sync with the primary. Always follow best practices when working with Oracle and ensure you have the necessary privileges for every operation.

