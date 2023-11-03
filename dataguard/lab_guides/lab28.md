
Practice 14-2: Keeping Physical Standby Session Connected During Role Transition
--------------------------------------------------------------------------------

### Overview

> In this practice, you will use Enterprise Manager Cloud Control 13c
> and DGMGRL to view the configuration status, validate that the
> databases are ready for a role reversal, and then perform a
> switchover. During the switchover, you will observe how the session
> connected to the physical standby database is controlled with the
> STANDBY\_DB\_PRESERVE\_STATES parameter.

### Tasks

1.  ![](media/image15.jpeg){width="6.2in"
    height="2.4923611111111112in"}With the navigation techniques learned
    in practice 10-3, navigate to the Databases pages.

2.  ![](media/image47.jpeg){width="6.2756944444444445in"
    height="1.917361111111111in"}Add the stndby database as an EM target
    in preparation of the Switchover practice through Enterprise
    Manager. Click **Add** \> **Oracle Database**.

3.  ![](media/image49.jpeg){width="6.18125in"
    height="3.0965277777777778in"}On the Database Discovery: Search
    Criteria page, enter the name of the host (stndby) by clicking the
    magnifying glass icon and selecting the host name in the dialog box.
    Then click **Next** to proceed.

4.  On the Database Discovery: Results page, select the stndby database
    and provide the following information:

    -   Monitor Username: sys

    -   Monitor Password: \<password\>

    -   Role: SYSDBA

> ![](media/image51.jpeg){width="6.18125in" height="1.6625in"}**Note:**
> You can also choose dbsnmp to lower the privilege instead of the SYS
> user.

5.  ![](media/image53.jpeg){width="6.18125in"
    height="1.1243055555555554in"}Select the listed listener on stndby.
    Click **Next**.

6.  On the Database Discovery: Review page, click **Save**.

7.  In the Confirmation dialog box, click **Close**.

8.  ![](media/image55.jpeg){width="6.284722222222222in"
    height="1.9375in"}On the Databases page, set the Auto Refresh option
    to 30 seconds and wait until the stndby.example.com target becomes
    normal. Click the link for the orclcdb.example.com target.

9.  On the orclcdb.example.com database home page, select **Data Guard
    Administration**

> ![](media/image16.jpeg){width="6.21875in"
> height="1.8506944444444444in"}from the Availability menu.
>
> ![](media/image18.jpeg){width="6.14375in"
> height="2.7284722222222224in"}**(Optional)** If only the **Add Standby
> Database** link is visible, then select it. It will not launch the Add
> Standby Database Wizard, but instead, will navigate to the Data Guard
> home page.
>
> **(Optional)** If the Add Standby Database link shows the Add Standby
> Database page, click
>
> ![](media/image20.jpeg){width="6.152777777777778in"
> height="1.6340277777777779in"}**Cancel** to navigate to the Data Guard
> home page.
>
> (**Optional**) On the Database Login Page, select **New** in the
> Credential option with the following values. Click **Login**.

-   Username: sys

-   Password: *\<password\>*

-   Role: SYSDBA

-   Save As: NC\_ORCLCDB\_SYS2

10. ![](media/image57.jpeg){width="5.468055555555556in"
    height="4.804166666666666in"}On the Data Guard home page, make sure
    that the status of the current primary and physical standby is
    Normal.

11. Use the terminal connected to localhost as oracle with the
    environment variables set to

> orclcdb. Launch SQL\*Plus and connect as the SYS user.

12. Set the value of the STANDBY\_DB\_PRESERVE\_STATES parameter to
    SESSION and restart the orclcdb database.

> **Note:** When a physical standby database is converted to a primary,
> you have the option of keeping any sessions connected to the physical
> standby connected, without disruption,
>
> during the switchover or failover. SESSION means user sessions are
> retained during a switchover or failover.

13. Open the DEV1 PDB and start the Media Recovery Process. Exit
    SQL\*Plus.

> **Note:** If the Media Recovery process is already running, you will
> receive the ORA-01153
>
> error message. You can safely proceed to the next step.

14. Now, let's establish a new session for testing.

15. With the navigation techniques learned, return to the EM Data Guard
    Home page. Switch over to the orclcdb physical standby database like
    the following.

> **Note:** If the EM page shows a warning message due to the restart of
> the orclcdb database, refresh the bowser.

a.  ![](media/image59.jpeg){width="5.893055555555556in"
    height="2.079861111111111in"}On the EM Data Guard Home page, select
    orclcdb.example.com in the Standby Databases section. Click
    **Switchover**.

b.  On the Host Login (localhost.example.com) page, select **Preferred**
    in the Credential option. Click **Continue**.

> ![](media/image61.jpeg){width="5.892361111111111in"
> height="1.3756944444444446in"}

c.  ![](media/image63.jpeg){width="5.876388888888889in"
    height="1.3208333333333333in"}On the Host Login (stndby.example.com)
    page, select **Preferred** in the Credential option. Click
    **Continue**.

d.  On the Confirmation page, click **Yes**.

> ![](media/image65.jpeg){width="5.910416666666666in"
> height="1.413888888888889in"}

e.  ![](media/image67.jpeg){width="5.907638888888889in"
    height="1.1965277777777779in"}Monitor the progress of Switchover.
    **DON'T WAIT** for completion. Move on to the next step.

```{=html}
<!-- -->
```
16. Return to the SQL\*Plus session connected on localhost. Check the
    current status of the OE

> session periodically. Exit SQL\*Plus.

+---------------+---+-----+---+----------+---------+
| > SQL\> **/** |   | SID |   | SERIAL\# |         |
| >             |   |     |   |          |         |
| > USERNAME    |   |     |   |          |         |
+===============+===+=====+===+==========+=========+
| > OE          |   |     |   | > 42     | > 40779 |
| >             |   |     |   |          |         |
| > SQL\> **/** |   |     |   |          |         |
+---------------+---+-----+---+----------+---------+
| > USERNAME    |   | SID |   | SERIAL\# |         |
+---------------+---+-----+---+----------+---------+
| > OE          |   |     |   | > 42     | > 40779 |
| >             |   |     |   |          |         |
| > SQL\> **/** |   |     |   |          |         |
+---------------+---+-----+---+----------+---------+

+----------------+---+-----+---+----------+---------+
| USERNAME       |   | SID |   | SERIAL\# |         |
+================+===+=====+===+==========+=========+
| OE             |   |     |   | > 42     | > 40779 |
|                |   |     |   |          |         |
| SQL\> **/**    |   |     |   |          |         |
+----------------+---+-----+---+----------+---------+
| USERNAME       |   | SID |   | SERIAL\# |         |
+----------------+---+-----+---+----------+---------+
| OE             |   |     |   | > 42     | > 40779 |
|                |   |     |   |          |         |
| SQL\> **exit** |   |     |   |          |         |
+----------------+---+-----+---+----------+---------+

> **Note:** The OE session hangs for a while and resumes. With the new
> feature, the session is retained during role transition.

17. ![](media/image69.jpeg){width="4.983333333333333in"
    height="3.8979166666666667in"}Return to the EM page. Once the
    switchover operation is complete, you will see the new primary
    database on the Data Guard home page.