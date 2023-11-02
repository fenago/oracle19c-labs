

Practice 13-4: Using SQL Tuning Advisor for an Active Data Guard Instance
-------------------------------------------------------------------------

### Overview

> In this practice, you will see how to use SQL Tuning Advisor for
> Active Data Guard.
>
> The Active Data Guard (ADG) Databases are widely used to offload
> reporting or ad hoc query-only jobs from primary. Reporting workload
> profile is different from primary and often requires tuning. Starting
> with Oracle Database 12.2, you can run SQL Tuning Advisor to tune SQLs
> workloads running on ADG database.

![](media/image40.jpeg){width="6.214055118110236in"
height="1.6163538932633421in"}

-   All changes are done on primary and propagated from primary to
    standby by redo apply.

-   The data required for running the tuning tasks are fetched from the
    primary.

-   Support for PDB level tuning

-   Test execution (heavy lifting) happens on standby; only minimal
    write related activity on primary.

### Tasks

1.  (**Reference Only, DO NOT RUN**) The environment for this practice
    has been set up with the setup\_STA.sh script. This script created
    the OE.PRODUCTS, OE.ORDER\_ITEMS, OE.orders, OE.CUSTOMERs, and
    OE.storeS tables.

2.  Use a terminal window logged in as oracle to localhost with the
    environment variables set for orclcdb appropriately. Log in to the
    DEV1 PDB as the SYS user and run the setup13- 4.sql script.

3.  Switch to the CDB root container and create a database link in the
    primary database for the standby database.

4.  Use a terminal window logged in as oracle to stndby with the
    environment variables set for stndby appropriately. Launch SQL\*Plus
    and run the problem query in the DEV1 PDB.

5.  Find sql\_id of the problem query.

6.  Open a new terminal window logged in as oracle to stndby with the
    environment variables set for stndby appropriately.

7.  In the same terminal session, verify that the sql\_id of the problem
    query is visible. **Note:** At times, the problem query doesn't
    appear in the CDB root container due to an internal delay. If that
    is the case, return to the terminal session used in step 4 and run
    the problem\_query.sql script again.

8.  Create a SQL Tuning Task.

> ![](media/image42.jpeg){width="6.096527777777778in"
> height="1.7944444444444445in"}**Note:** If you receive ORA-13780: SQL
> statement does not exist, return to the terminal session used in step
> 4 and run the problem\_query.sql script again.

9.  ![](media/image43.jpeg){width="6.21875in"
    height="1.8506944444444444in"}Execute the SQL Tuning Task.

10. Generate the SQL Tuning Task report.

> ![](media/image45.jpeg){width="6.209722222222222in"
> height="1.8319444444444444in"}**Note:** The result varies.
>
> Scope : COMPREHENSIVE
>
> Time Limit(seconds): 1800 Completion Status : COMPLETED Started at :
> 06/05/2020 22:21:31
>
> Completed at : 06/05/2020 22:21:35
>
> Schema Name : OE Container Name: DEV1
>
> SQL ID : an7zryzf86prm
>
> SQL Text : SELECT /\* problem\_query \*/ SUM(lo\_extendedprice \*
> lo\_discount) revenue FROM oe.lineorder l, oe.date\_dim d
>
> WHERE l.lo\_orderdate = d.d\_datekey
>
> FINDINGS SECTION (2 findings)

1.  Statistics Finding

> Table \"OE\".\"DATE\_DIM\" was not analyzed.
>
> Recommendation

-   Consider collecting optimizer statistics for this table. execute
    dbms\_stats.gather\_table\_stats(ownname =\> \'OE\',

> tabname =\>
>
> \'DATE\_DIM\', estimate\_percent =\> DBMS\_STATS.AUTO\_SAMPLE\_SIZE,
>
> method\_opt =\> \'FOR ALL COLUMNS SIZE AUTO\');
>
> Rationale
>
> The optimizer requires up-to-date statistics for the table in order to
> select a good execution plan.

2.  Statistics Finding

> Table \"OE\".\"order\_items\" was not analyzed.
>
> Recommendation

-   Consider collecting optimizer statistics for this table. execute
    dbms\_stats.gather\_table\_stats(ownname =\> \'OE\',

> tabname =\>
>
> \'ORDER\_ITEMS\', estimate\_percent =\>
> DBMS\_STATS.AUTO\_SAMPLE\_SIZE,
>
> method\_opt =\> \'FOR ALL COLUMNS SIZE AUTO\');
>
> Rationale
>
> The optimizer requires up-to-date statistics for the table in order to
>
> select a good execution plan.
>
> EXPLAIN PLANS SECTION
>
> 1- Original
>
> Plan hash value: 2963256899

+---------+----------------+----+-----------+--------+-----------------------------+
| > \| Id | > \| Operation | \| | > Name \| | > Rows | > \| Bytes \| Cost (%CPU)\| |
+=========+================+====+===========+========+=============================+
| > Time  | > \|           |    |           |        |                             |
+---------+----------------+----+-----------+--------+-----------------------------+

> \| 0 \| SELECT STATEMENT \| \| 1 \| 52 \| 6448
>
> (1)\| 00:00:01 \|

+--------+---+----+------------------+------+------+-----------------+-------+---------+
| > \|   | 1 | \| | > SORT AGGREGATE | > \| |      | > \| 1 \|       | 52 \| |         |
| >      |   |    | >                |      |      |                 |       |         |
| > \|   |   |    | > \|             |      |      |                 |       |         |
+========+===+====+==================+======+======+=================+=======+=========+
| > \|\* | 2 | \| | > HASH JOIN      | > \| | > \| | > 1610K\| 79M\| | 6448  | > (1)\| |
+--------+---+----+------------------+------+------+-----------------+-------+---------+

> 00:00:01 \|
>
> \| 3 \| TABLE ACCESS FULL\| DATE\_DIM \| 2556 \| 33228 \| 12
>
> (0)\| 00:00:01 \|
>
> \| 4 \| TABLE ACCESS FULL\| LINEORDER \| 1610K\| 59M\| 6431
>
> (1)\| 00:00:01 \|
>
> Query Block Name / Object Alias (identified by operation id):
>
> 1 - SEL\$1

3.  \- SEL\$1 / D\@SEL\$1

4.  \- SEL\$1 / L\@SEL\$1

> Predicate Information (identified by operation id):
>
> 2 - access(\"L\".\"LO\_ORDERDATE\"=\"D\".\"D\_DATEKEY\")
>
> Column Projection Information (identified by operation id):

1.  \- (\#keys=0) SUM(\"LO\_EXTENDEDPRICE\"\*\"LO\_DISCOUNT\")\[22\]

2.  \- (\#keys=1; rowset=256) \"LO\_DISCOUNT\"\[NUMBER,22\],
    > \"LO\_EXTENDEDPRICE\"\[NUMBER,22\]

3.  \- (rowset=256) \"D\".\"D\_DATEKEY\"\[NUMBER,22\]

4.  \- (rowset=256) \"L\".\"LO\_ORDERDATE\"\[NUMBER,22\],
    > \"LO\_EXTENDEDPRICE\"\[NUMBER,22\], \"LO\_DISCOUNT\"\[NUMBER,22\]

> Note
>
> \- dynamic statistics used: dynamic sampling (level=2)

11. Return to the terminal session connected to localhost. Switch to the
    > DEV1 container.

12. Optionally, implement the recommendations.

> **Note:** If the recommendation is about the implementation of a
> profile, you can accept the profile directly in the standby database.
> The accepted profile is written to the primary database. Then the same
> profile is available in the standby database via redo apply.

13. Exit SQL\*Plus on all hosts leaving the current terminal windows.
