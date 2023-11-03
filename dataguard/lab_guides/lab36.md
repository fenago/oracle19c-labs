
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

2.  Launch SQL\*Plus and set the session container to the DEV1 pluggable
    database.

3.  Modify the service PRMY.EXAMPLE.COM to support Application
    Continuity. Exit SQL\*Plus.

#### SQL\> @/home/oracle/setup/modify\_svc.sql

> SQL\> DECLARE

2.  params dbms\_service.svc\_parameter\_array;

3.  BEGIN

4.  params(\'FAILOVER\_TYPE\'):=\'TRANSACTION\';

5.  params(\'REPLAY\_INITIATION\_TIMEOUT\'):=1800;

6.  params(\'RETENTION\_TIMEOUT\'):=86400;

7.  params(\'FAILOVER\_DELAY\'):=10;

8.  params(\'FAILOVER\_RETRIES\'):=30;

9.  params(\'FAILOVER\_RESTORE\'):=\'LEVEL1\';

10. params(\'commit\_outcome\'):=\'true\';

11. params(\'aq\_ha\_notifications\'):=\'true\';

12. dbms\_service.modify\_service(\'prmy.example.com\',params);

13. END;

> 14 /
>
> PL/SQL procedure successfully completed.
>
> SQL\> **exit**
>
> Disconnected from Oracle Database 19c Enterprise Edition Release
>
> 19.0.0.0.0 - Production Version 19.3.0.0.0 \[oracle\@localhost \~\]\$
>
> **Note:** You have to set two mandatory service attributes
> (FAILOVER\_TYPE and
>
> COMMIT\_OUTCOME) to enable the Application Continuity feature.

4.  Examine the script that you will soon use to execute the practice
    application. The script executes the application code called
    actest.jar.

5.  Examine the properties file.

    -   Use the Replay Data source:
        oracle.jdbc.replay.OracleDataSourceImpl

    -   Use the Application Continuity enabled service: prmy

    -   Use the Application Continuity supported connection pool: UCP

6.  Use the terminal window connected to host02. Execute the practice
    application. While the application runs, a periodic status message
    is displayed.

7.  While the application continues to execute, return to the DGMGRL
    session on localhost. Check the status of the data guard
    configuration and wait until all warning messages are cleared.

8.  Verify that both databases are ready for switchover, and then
    perform a switchover.

9.  Return to the terminal session on host02. Press Ctrl+C to abort the
    application.


> **Note:** Your application is still connected without having any
> connection issues. There was only a small delay during the switchover
> operation.

10. (**Optional**) Return to the DGMGRL session on localhost.
    Optionally, switch back to the original state.

11. Exit DGMGRL on localhost.
