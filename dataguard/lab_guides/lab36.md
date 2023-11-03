
Practice 18-2: Modifying the Primary Database Service for Application Continuity
--------------------------------------------------------------------------------

### Overview

> In this practice, you will modify the service PRMY created in the DEV1
> pluggable database on the primary database to support Application
> Continuity.

### Tasks

1.  Open a terminal window logged in as oracle to localhost with the
    environment variables set for orclcdb appropriately. Run the
    setup18.sh script to prepare for a simple testing.

    ```
    [oracle@localhost]$ . oraenv
    ORACLE_SID = [oracle] ? orclcdb
    The Oracle base has been set to /u01/app/oracle [oracle@localhost ~]$ /home/oracle/setup/lab_18-2/setup18.sh

    drop table emp
    * ERROR at line 1:
    ORA-00942: table or view does not exist

    Table created. 
    ```

2.  Launch SQL\*Plus and set the session container to the DEV1 pluggable
    database.

    ```
    [oracle@localhost ~]$ sqlplus / as sysdba
    ```

3.  Modify the service PRMY.EXAMPLE.COM to support Application
    Continuity. Exit SQL\*Plus.

    ```
    SQL> @/home/oracle/setup/modify_svc.sql
    ```

4.  Examine the script that you will soon use to execute the practice
    application. The script executes the application code called
    actest.jar.

    ```
    [oracle@localhost ~]$ cat /home/oracle/setup/lab_18-2/runreplay
    java -
    classpath ./actest.jar:$ORACLE_HOME/ucp/lib/ucp.jar:$ORACLE_HOME/ jdbc/lib/ojdbc8.jar actest.ACTest actest_replay.properties
    [oracle@localhost ~]$
    ```

5.  Examine the properties file.

    -   Use the Replay Data source:
        oracle.jdbc.replay.OracleDataSourceImpl

    -   Use the Application Continuity enabled service: prmy

    -   Use the Application Continuity supported connection pool: UCP

    ```
    [oracle@localhost ~]$
    cat /home/oracle/setup/lab_18-2/actest_replay.properties
    username=hr password=hr autoCommit=false

    # Use new replay datasource datasource=oracle.jdbc.replay.OracleDataSourceImpl

    url=jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=h ost01.example.com)(PORT=1521)(ADDRESS=(PROTOCOL=tcp)(HOST=stndby. example.com)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=prmy)))

    # UCP setting:
    ucp_pool_size=2 ucp_validate_connection_on_borrow=true ucp_connection_wait_timeout=60

    # Think Time taken to process the results from the database. Time in milliseconds.
    # -1 means no sleep. thread_think_time=20

    # Number of concurrent threads running in the application # UCP is tuned to have MAX and MIN limit set to this number_of_threads=6

    verbose=true [oracle@localhost ~]$
    ```

6.  Use the terminal window connected to host02. Execute the practice
    application. While the application runs, a periodic status message
    is displayed.

    ```
    [oracle@host02 ~]$ cd /home/oracle/setup/lab_18-2/ [oracle@host02 lab_18-2]$ ./runreplay ######################################################
    Connecting to jdbc:oracle:thin:@(DESCRIPTION_LIST=(DESCRIPTION=(ADDRESS=(PROTOC OL=tcp)(HOST=localhost.example.com)(PORT=1521))(CONNECT_DATA=(SERVIC E_NAME=PRMY.EXAMPLE.COM)))(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HO ST=stndby.example.com)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=PRM Y.EXAMPLE.COM))))
    # of Threads	: 6
    UCP pool size	: 2
    Thread think time	: 20 ms ######################################################

    2 active connections, avg response time from db 6 ms
    1 active connections, avg response time from db 5 ms
    1 active connections, avg response time from db 5 ms
    ...
```

7.  While the application continues to execute, return to the DGMGRL
    session on localhost. Check the status of the data guard
    configuration and wait until all warning messages are cleared.

    ```
    DGMGRL> show configuration
    ```

8.  Verify that both databases are ready for switchover, and then
    perform a switchover.

    ```
    DGMGRL> validate database orclcdb
    ```

9.  Return to the terminal session on host02. Press Ctrl+C to abort the
    application.

    ```
    …
    2	
    active	
    connections,	
    avg	
    response	
    time	
    from	
    db	
    5	
    ms
    2	active	connections,	avg	response	time	from	db	5	ms
    0	active	connections,	avg	response	time	from	db	5	ms
    2	active	connections,	avg	response	time	from	db	5	ms
    1
    2	active active	connections, connections,	avg avg	response response	time time	from from	db db	111 ms
    5 ms
    2	active	connections,	avg	response	time	from	db	7	ms
    0	active	connections,	avg	response	time	from	db	6	ms
    1	active	connections,	avg	response	time	from	db	5	ms
    2	active	connections,	avg	response	time	from	db	5	ms
    …									
    ```


> **Note:** Your application is still connected without having any
> connection issues. There was only a small delay during the switchover
> operation.

10. (**Optional**) Return to the DGMGRL session on localhost.
    Optionally, switch back to the original state.

    ```
    DGMGRL> switchover to orclcdb
    Performing switchover NOW, please wait...
    Operation requires a connection to database "orclcdb" Connecting ...
    Connected to "orclcdb" Connected as SYSDG.
    New primary database "orclcdb" is opening...
    Operation requires start up of instance "stndby" on database "stndby"
    Starting instance "stndby"... Connected to an idle instance. ORACLE instance started.
    Connected to "stndby" Database mounted.
    Database opened. Connected to "stndby" 
    ```

11. Exit DGMGRL on localhost.
