
Practice 17-2: Creating a Recovery Manager Catalog
--------------------------------------------------

### Overview

> In this practice, you will set up and configure the recovery manager
> (RMAN) catalog repository database.

### Tasks

1.  Open a terminal window connected to localhost as the oracle OS user.
    Enter \<password\>

> when you are prompted for the password. Set the environment variables
> to ORCL.

2.  Invoke SQL\*Plus and connect as the SYS user with the SYSDBA
    privilege. List the PDBs in the connected database.

3.  Connect to the RCATPDB PDB.

4.  Determine where the current data files are stored at:

5.  Create a new tablespace for the recovery manager repository using
    the same storage architecture as the existing files. Name the
    tablesace rcts and give it an initial size of 30MB with autoextend
    turned on.

6.  Create a new schema rcowner setting the default tablespace to the
    tablespace just created.

7.  Grant the recovery catalog owner role to the user just created. Exit
    SQL\*Plus when done.

8.  Use a terminal window on localhost connected as oracle with the
    environment variables set to orclcdb. Launch the RMAN utility and
    connect to the rcatpdb service using the account just created.

9.  Create the recovery catalog.