# Oracle Data Guard 19c Lab Guide: Refreshing the Password File


## Objective:
In this lab, you will test the automatic password change propagation feature. As of Oracle Database 19c Release 2 (19.3.0.1), password file changes done on the primary database are automatically propagated to standby databases.

## Prerequisites:
- Ensure you have access to an Oracle 19c environment.
- Oracle listener and the database should be already running.

## Steps:

### 1. Open the Terminal:
On your system, open the terminal (or command prompt) application. 

### 2. Switch to the Oracle User:
To switch to the `oracle` user, enter the following command:
```bash
su - oracle
```

### 3. Set the Oracle SID:
The Oracle System ID (SID) uniquely identifies a particular database on a system. 
To set the SID for your database, enter the following command:
```bash
export ORACLE_SID=orclcdb
```

### 4. Connect to SQL*Plus as SYSDBA:

Enter the following command:

```bash
sqlplus / as sysdba
```
You should now be in the SQL*Plus environment.

### 5. List Users:

List all users in the password file by using V$PWFILE_USERS.

```sql
SQL> col username format a10

SQL> SELECT username, sysdba, sysdg FROM v$pwfile_users;
```

### 6. Standby Database (Terminal 2)

Repeat the above steps for stnadby `orcldg` database in the new terminal.

1. Open a new terminal window and connect to standby `orcldg` as the oracle
user. Right click on desktop and select open terminal. Then `su - oracle`


2. Use the oraenv utility to set the environment variables for the orcldg instance.

`. oraenv`

3. List all users in the password file by using V$PWFILE_USERS.

```sql
SQL> col username format a10
SQL> SELECT username, sysdba, sysdg FROM v$pwfile_users;
```

4.	Stop Media Recovery Process on purpose. Do this in standby (Terminal 2):

```sql
SQL> alter database recover managed standby database cancel;
```

Database altered.


### 7. Create User in ORCLCDB (Terminal 1)

1.	Return to the terminal connected to primary database orclcdb. Create a user called CDBA with a password of fenago.


```sql
SQL> CREATE USER c##dba1 IDENTIFIED BY fenago;
```

User created.


2. Grant SYSDBA and CREATE SESSION privileges.

```sql
SQL> grant sysdba, create session to c##dba1 container=all;
```

3.	Review the output of V$PWFILE_USERS. The output shows that the newly created user was added to the password file.

```sql
SQL> SELECT username, sysdba, sysdg FROM v$pwfile_users;
```

4.	Return to the **terminal 2** session connected to standby to review the output of V$PWFILE_USERS. The new entry doesn’t appear in the output because the Media Recovery process was stopped

```sql
SQL> col username format a10

SQL> SELECT username, sysdba, sysdg FROM v$pwfile_users;
```

### 8. Start the Media Recovery Process (Terminal 2)

1.	Start the Media Recovery Process (mrp0). In orcldg 

```sql
SQL> alter database recover managed standby database disconnect from session;
```

2.	Verify V$PWFILE_USERS for the granted role.

```sql
SQL> SELECT username, sysdba, sysdg FROM v$pwfile_users;
```

**Note:** At times, the new entry doesn’t appear in the list immediately. In this case, run the following
GRANT command again at localhost to see if the new entry can be added.

```sql
SQL> GRANT sysdba, create session TO cdba;
```

### 9. Change User Password (Terminal 1)

Return to the terminal session connected to primary and change the password for CDBA
user.

`SQL> ALTER USER cdba IDENTIFIED BY Welcome_1;`

### 10. Start the Media Recovery Process (Terminal 2)

Test the connection to the standby database (orcldg) with the new password.

`SQL> CONNECT c##dba1/Welcome_1@orcldg as sysdba`


### 11. Drop User (Terminal 1)

18.	Drop the `c##dba1` user (primary).


```sql
SQL> connect / as sysdba
Connected

SQL> DROP USER cdba CASCADE;
```

### 12. Exiting the SQL*Plus and Returning to the Command Line:
After you have completed your tasks in SQL*Plus, you may want to exit and return to the command line.

1. At the SQL prompt, type `exit` and press Enter:
```sql
exit
```

2. You will now be returned to the command line.

## Conclusion:
You've successfully created new user in primary which was automatically propagated to standby database.