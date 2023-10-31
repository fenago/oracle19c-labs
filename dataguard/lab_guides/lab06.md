# Lab: Oracle Data Guard 19c Lab Guide: Controlling PDB Replication

## Overview

In this practice, you will create two new PDBs (DEV2 and DEV3) in the primary database to demonstrate the control of the PDB replication to the standby database.

## Tasks:

1. **Prepare the Environment**:

- Use the terminal session on `localhost`. 
- Create a directory for the new data files of `DEV2`.

```
[oracle@localhost ~]$ . oraenv
ORACLE_SID = [orclcdb] ? orclcdb

[oracle@localhost ~]$ mkdir -p /u01/app/oracle/oradata/ORCLCDB/dev2
```


2. **Clone DEV2 from ORCLPDB1**:

- Invoke SQL*Plus and connect to the CDB root as a user (SYS user in this practice) granted with the `CREATE PLUGGABLE DATABASE` privilege.
- Clone `dev2` from `orclpdb1`.


```
[oracle@localhost ~]$ sqlplus / as sysdba

SQL>  show pdbs;

SQL> CREATE PLUGGABLE DATABASE dev2 FROM orclpdb1
CREATE_FILE_DEST='/u01/app/oracle/oradata/ORCLCDB/dev2';
```

3. **Check the Open Mode of DEV2**:

- Confirm the current open mode of `DEV2`.

```
SQL>  show pdbs;
```

4. **Open DEV2 in READ WRITE Mode**:
    - Switch `DEV2` to `READ WRITE` mode.

```
SQL> alter pluggable database DEV2 open;
```

5. **Connect to the Standby Database (terminal 2)**:

- Use the terminal session connected to `orcldg`.
- Connect as `SYS` to the `orcldg` standby database.

```
[oracle@localhost ~]$ . oraenv
ORACLE_SID = [orclcdb] ? orcldg

[oracle@localhost ~]$ sqlplus / as sysdba
```


6. **Check the ENABLED_PDBS_ON_STANDBY Parameter**:

- List the value of the `ENABLED_PDBS_ON_STANDBY` parameter.

```
SQL> show parameter ENABLED_PDBS_ON_STANDBY
```

7. **Verify the PDBs in the Standby Database**:

- Check which PDBs are currently available in the `orcldg` standby database.


```
SQL>  show pdbs;
```

8. **Modify the ENABLED_PDBS_ON_STANDBY Parameter**:

- Adjust the `ENABLED_PDBS_ON_STANDBY` parameter to only include `ORCLPDB1` and `DEV2` PDBs in the standby database.

```
SQL> alter system set ENABLED_PDBS_ON_STANDBY = "ORCLPDB1","DEV2";
```

9. **Prepare DEV3**:

- Return to the terminal session on `localhost` connected to the `orcldg` database.
    - Create a directory for `DEV3` using SQL Developer.

```
SQL> !mkdir -p /u01/app/oracle/oradata/ORCLCDB/dev3
```

10. **Clone DEV3 from ORCLPDB1**:

- Create `DEV3` by cloning from `ORCLPDB1` in the `orcldg` primary database.
- Confirm the open mode of `DEV3`.

```
SQL> CREATE PLUGGABLE DATABASE dev3 FROM orclpdb1
CREATE_FILE_DEST='/u01/app/oracle/oradata/ORCLCDB/dev3';
```


11.	Check the open mode of DEV3.


```
SQL>  show pdbs;
```

12. **Open DEV3 in READ WRITE Mode**:
    - Switch `DEV3` to `READ WRITE` mode.

```
SQL> alter pluggable database DEV3 open;

Pluggable database altered. 
```

13. **Verify the PDBs in the Standby Database**:

- Switch to the terminal session on `orcldg` connected to the `orcldg` database.
- Confirm the PDBs currently available in the standby database.

```
SQL> show pdbs
```

14. **Check Recovery Status**:

The DEV3 PDB is listed in the output of the previous step, but it doesn’t mean that it is protected. Run the following query to check the recovery_status column. This column shows whether recovery is enabled or disabled for the PDB.

- Determine if the `DEV3` PDB is protected by checking the `recovery_status` column.

```
SQL> col name format a10
SQL> SELECT name, open_mode, recovery_status FROM v$pdbs;
```

15. **Cleanup**:

- To reset the environment, adjust the `ENABLED_PDBS_ON_STANDBY` parameter in `orcldg` back to its original value.

```
SQL> ALTER SYSTEM SET enabled_pdbs_on_standby="*";
```

16. **Exit**:

- Exit SQL*Plus on both `localhost` and `orcldg`, but keep the terminal windows open for subsequent labs.

## Conclusion:

You've successfully controlled the replication of PDBs in a Data Guard environment and verified the replication status on the standby database.