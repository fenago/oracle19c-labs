
Practice 13-1: Configuring Network Compression of Redo Data
-----------------------------------------------------------

### Overview

> In this practice, you will set the RedoCompression property to
> configure network compression of redo data.

### Tasks

1.  Use a terminal window logged in as oracle to localhost with the
    environment variables set for orclcdb appropriately. Launch
    SQL\*Plus on your primary database and determine if redo compression
    is enabled by querying V\$ARCHIVE\_DEST.

Cd

2.  Use a terminal window logged in as oracle to host02 with the
    environment variables set for orclcdbFS appropriately. Launch DGMGRL
    and connect to the primary database.

3.  Enable redo compression by setting the RedoCompression property for
    your database. Exit DGMGRL.

4.  Return to your SQL\*Plus session on localhost and query
    V\$ARCHIVE\_DEST again. Note that compression is set for
    LOG\_ARCHIVE\_DEST\_2. Exit SQL\*Plus.