# Oracle Data Guard 19c Lab Guide: Managing Private Temporary Table for DDL/DML

## Overview

In this practice, you will work with private temporary tables in the `orcldg` physical standby database and explore DML/DDL operations on these tables.

Private temporary tables are advantageous in scenarios where:
- A specific application stores temporary data in transient tables for a single-time population, infrequent reads, followed by a drop at the end of a transaction or session.
- A session persists indefinitely and needs distinct temporary tables for varying transactions.
- Creating a temporary table shouldn't start a new transaction or commit an existing one.
- Different sessions of the same user need to use identical names for a temporary table.
- A temporary table is needed for a read-only database.

---

## Tasks:

1. **Setup and Login**:
    - Open a terminal window and log in as the `oracle` user to `orcldg`.
    - Ensure the environment variables are correctly set for `orcldg`.
    - Log in as the `SYSTEM` user.

    ```
    [oracle@orcldg ~]$ . oraenv
    ORACLE_SID = [oracle] ? orcldg

    [oracle@orcldg ~]$ sqlplus system/<password>
    ```

2. **Attempt PTT Creation**:
    - Try to create a private temporary table (PTT).

    ```
    SQL> CREATE PRIVATE TEMPORARY TABLE mine (x NUMBER, y VARCHAR2(10));


    CREATE PRIVATE TEMPORARY TABLE mine (x NUMBER, y VARCHAR2(10))
    *
    ERROR at line 1:
    ORA-00903: invalid table name
    ```

3. **Check Prefix for PTT**:
    - Determine the value of the `PRIVATE_TEMP_TABLE_PREFIX` parameter.
    ```sql
    SHOW PARAMETER PRIVATE_TEMP_TABLE_PREFIX
    ```

4. **Create PTT with Prefix**:
    - Create a PTT using the identified prefix.

    ```
    SQL> CREATE PRIVATE TEMPORARY TABLE ora$ptt_mine (x NUMBER, y VARCHAR2(10));

    Table created.
    ```

5. **Insert Rows into PTT**:
    - Populate the PTT with some sample data.

    ```
    SQL> INSERT INTO ora$ptt_mine VALUES (1,'Work1');

    1 row created.
    ```

6. **Display PTT Data**:
    - Query and display data from the PTT.

    ```
    SQL> SELECT * FROM ora$ptt_mine;
    ```

7. **Inspect PTT Details**:
    - Extract all information related to the PTT using the `show_ptt.sql` script.
        
    ```
    SQL> @/home/oracle/setup/show_ptt.sql
    ```

8. **Verify PTT Isolation**:
    - Open another terminal window, log in as `oracle` to `orcldg`, and set environment variables.

     ```
    [oracle@orcldg ~]$ . oraenv
    ORACLE_SID = [oracle] ? orcldg
    
    [oracle@orcldg ~]$ sqlplus system/<password>
    ```

    - Log in as the `SYSTEM` user and verify that the PTT created in the first session isn't visible in this second session.

    ```
    SQL> desc ORA$PTT_MINE
    ERROR:
    ORA-04043: object ORA$PTT does not exist
    ```

9. **Test PTT Lifetime (Transaction Duration)**:
    - Return to the first terminal window and issue a `ROLLBACK` statement. The PTT should be dropped since its default duration is `TRANSACTION`.

    ```
    SQL> ROLLBACK;

    SQL> @/home/oracle/setup/show_ptt.sql

    ...

    SQL> SELECT sid, serial#, table_name, tablespace_name, duration FROM dba_private_temp_tables;
=
    ```

10. **Create PTT with Session Duration**:
    - In the same terminal, create a new PTT with a `SESSION` duration.

```
SQL> CREATE PRIVATE TEMPORARY TABLE ora$ptt_mine2 (x NUMBER, y VARCHAR2(10)) ON COMMIT PRESERVE DEFINITION;

Table created.
```

11. **Examine PTT Details**:
    - Extract all details related to the newly created PTT.

    ```
    SQL> @/home/oracle/setup/show_ptt.sql
    ```


12. **Insert and Display PTT Data**:
    - Populate the new PTT and then query to display its data.

    ```
    SQL> INSERT INTO ora$ptt_mine2 VALUES (2,'Work2');

    SQL> SELECT * FROM ora$ptt_mine2;
    ```

13. **Commit and Verify PTT Persistence**:
    - Issue a `COMMIT` statement and then retrieve information about the PTT. Since its duration is `SESSION`, the PTT should persist post-commit.

    ```
    SQL> COMMIT;

    SQL> @/home/oracle/setup/show_ptt.sql

    ...
    SQL> SELECT sid, serial#, table_name, tablespace_name, duration FROM dba_private_temp_tables;
    ```

14. **Cleanup**:
    - Exit SQL*Plus on both `localhost` and `orcldg`, but keep the terminal windows open for subsequent labs.



## Conclusion:

You've effectively managed and operated with private temporary tables in a Data Guard environment, understanding their transient nature and how they can be leveraged for temporary data operations without affecting the underlying database structure.
