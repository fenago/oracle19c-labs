Practice 17-1: Enable Change Tracking on the Physical Standby Database
----------------------------------------------------------------------

### Overview

> In this practice, you will enable the change tracking feature on
> stndby for the physical standby database and verify its usage.

### Tasks

1.  Use a terminal window logged in as oracle to stndby with the
    environment variables set for stndby appropriately. Using operating
    system authentication, SQL\*Plus connects, by default, to the root
    container in the lab environment. Enable change tracking by using
    the file /u01/app/oracle/oradata/stndby/rman\_change\_track.file.

2.  Verify that block change tracking is enabled, displaying the file
    name used and file size of the block change tracking file.

3.  Exit SQL\*Plus on stndby of the physical standby database. It is
    recommended to keep the terminal session open with the environment
    variables set appropriately.

