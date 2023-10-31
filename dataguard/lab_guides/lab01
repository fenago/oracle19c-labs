# Oracle Data Guard 19c Lab Guide: Starting the Oracle Environment

## Objective:
In this lab guide, you will learn how to start the Oracle environment, specifically the listener and the Oracle database.

## Prerequisites:
- Ensure you have access to an Oracle 19c environment.
- You must have the necessary privileges to start the listener and the database.

## Steps:

### 1. Open the Terminal:
On your system, open the terminal (or command prompt) application. 

### 2. Switch to the Oracle User:
To switch to the `oracle` user, enter the following command:
```bash
su - oracle
```
You may be prompted for a password. Enter the password for the `oracle` user.

### 3. Start the Listener:
The listener is a crucial component in Oracle as it listens for incoming client connection requests and manages traffic to the database.
To start the listener, enter the following command:
```bash
lsnrctl start
```
Wait for a message indicating that the listener has successfully started.

### 4. Set the Oracle SID:
The Oracle System ID (SID) uniquely identifies a particular database on a system. 
To set the SID for your database, enter the following command:
```bash
export ORACLE_SID=orclcdb
```
**Note:** Make sure there's no space around the equals sign.

### 5. Connect to SQL*Plus as SYSDBA:
SQL*Plus is a command-line tool that allows you to interact with the Oracle database. 
To connect to the database as the SYSDBA (system database administrator), enter the following command:
```bash
sqlplus / as sysdba
```
You should now be in the SQL*Plus environment.

### 6. Start the Database:
To start the Oracle database, enter the following command at the SQL prompt:
```sql
startup
```
Wait for a message indicating that the database has been successfully started.

## Exiting the SQL*Plus and Returning to the Command Line:
After you have completed your tasks in SQL*Plus, you may want to exit and return to the command line.

1. At the SQL prompt, type `exit` and press Enter:
```sql
exit
```

2. You will now be returned to the command line.

## Conclusion:
You've successfully started the Oracle environment and learned how to exit SQL*Plus to return to the command line. Remember to always follow best practices when working with Oracle and ensure that you have the necessary privileges to perform any operation.
