# Create and Enable a Data Guard Broker Configuration

## Overview

In this lab, you will establish and name the Data Guard configuration. This will incorporate the physical standby database, logical standby database, and any associated rules for redo routing. 

> **Note**: The lab guide omits any steps involving `host02` or Far Sync due to unavailability. 

---

## Tasks:

### 1. **Configuration on localhost (Primary)**:
   - On `localhost` (primary), using a terminal window, connect as `oracle` with environment variables set for `orclcdb`. 
   - Using SQL*Plus, connect to the primary database and adjust the `LOG_ARCHIVE_DEST_2` and `LOG_ARCHIVE_DEST_3` parameters since they are defined as network locations. 
   - Initiate the Data Guard Broker process and confirm the modifications are persistent. Exit SQL*Plus.

   ```
   [oracle@localhost ~]$ sqlplus / as sysdba

   SQL*Plus: Release 19.0.0.0.0 - Production on Thu Jun 4 15:18:19 2020
   Version 19.3.0.0.0

   (c) 1982, 2019, Oracle. All rights reserved.


   Connected to:
   Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
   Version 19.3.0.0.0

   SQL> alter system set dg_broker_start=true scope=both;

   System altered.

   SQL> exit
   Disconnected from Oracle Database 19c Enterprise Edition Release
   19.0.0.0.0 - Production
   ```

### 3. **Configuration on orcldg (Physical Standby)**:
   - On `orcldg`, use a terminal window connected as `oracle` with environment variables set to `orcldg`. 
   - Connect to the physical standby using SQL*Plus and cease managed recovery. 
   - Adjust the `LOG_ARCHIVE_DEST_2` parameter because it's defined as a network location. 
   - Start the Data Guard broker process for the physical standby database.

   ```
   [oracle@orcldg ~]$ . oraenv

   ORACLE_SID = [orcldg2] ? orcldg

   SQL> alter database recover managed standby database cancel;

   Database altered.
      Do this only if log_archive_dest_2 has a value.

   SQL> show parameter dest_2
   SQL> alter system set log_archive_dest_2='' scope=both;

   System altered.
      
   SQL> alter system set dg_broker_start=true scope=both;

   System altered.
   ```

### 4. **Configuration on orcldg for Logical Standby**:
   - On the same terminal window for `orcldg`, exit SQL*Plus. 
   - Modify the environment variables for the `orcldg2` logical standby database. 
   - Since there are no network locations defined for redo transportation for the logical standby, initiate the Data Guard broker process. Exit SQL*Plus.

   ```
   SQL> exit

   
   [oracle@orcldg ~]$ . oraenv
   ORACLE_SID = [oracle] ? orcldg2
   
   [oracle@orcldg ~]$ sqlplus / as sysdba

   SQL> alter database stop logical standby apply;

   Database altered.

   SQL> alter system set dg_broker_start=true scope=both;

   System altered.
   
   Disconnected from Oracle Database 19c Enterprise Edition Release
   19.0.0.0.0 - Production Version 19.3.0.0.0
   [oracle@orcldg ~]$
   ```

### 5. **Launching DGMGRL on localhost**:
   - Back on `localhost`, in a terminal window, launch DGMGRL and attempt to display the configuration.

   ```
   [oracle@localhost ~]$ dgmgrl
   DGMGRL for Linux: Release 19.0.0.0.0 - Production on Thu Jun 4 15:27:39 2020
   Version 19.3.0.0.0

   (c) 1982, 2019, Oracle and/or its affiliates. All rights reserved.

   Welcome to DGMGRL, type "help" for information.

   DGMGRL> connect sysdg/<password>@orclcdb

   Connected to "orclcdb" Connected as SYSDG. DGMGRL> show configuration
   ORA-16532: Oracle Data Guard broker configuration does not exist

   Configuration details cannot be determined by DGMGRL DGMGRL>
   ```

### 6. **Creating Data Guard Broker Configuration**:
   - Generate the Data Guard broker configuration and then showcase the configuration.

   ```
   ***BEFORE YOU DO THE CREATE first check to see if it is already configured

   DGMGRL> show configuration

   DGMGRL> create configuration 'DRSolution' as primary database is 'orclcdb' connect identifier is orclcdb;

   DGMGRL> show configuration
   ```

### 7. **Add Physical Standby to Configuration**:
   - Incorporate the physical standby database `orcldg` into the configuration and display the results.

   ```
   Before doing the below check to see if the orcldg database is already in the DRSolution configuration:

   DGMGRL> show configuration – If not do below.

   DGMGRL> add database 'orcldg' as connect identifier is orcldg;

   Database "orcldg" added 

   DGMGRL> show configuration
   ```

### 8. **Add Logical Standby to Configuration**:
   - Incorporate the logical standby database `orcldg2` into the configuration and display the results.

   ```
   AGAIN do: DGMGRL> show configuration to see if it is already added.

   DGMGRL> add database 'orcldg2' as connect identifier is orcldg2;

   DGMGRL> show configuration
   ```

### 9. **Enable Data Guard Broker Configuration**:
   - Activate the Data Guard broker configuration and display the results.

   ```
   DGMGRL> enable configuration

   DGMGRL> show configuration
   ```

### 10. **Defining Redo Routing Rules**:
   - Establish redo routing rules for the configuration and showcase the results. The current primary database `orclcdb` should forward redo synchronously. For role reversal situations, the primary database will be `orcldg`. Redo should be forwarded synchronously in these cases.

   ```
   DGMGRL> EDIT DATABASE 'orclcdb' SET PROPERTY 'RedoRoutes' =
   '(orclcdb:orcldg SYNC)';

   Property "RedoRoutes" updated

   DGMGRL> EDIT 'orclcdb' SET PROPERTY 'RedoRoutes' =
   '(orclcdb:orcldg,orcldg2 ASYNC)';

   Property "RedoRoutes" updated
   ```

> **Note**: Ensure that your output aligns with the above. If discrepancies arise, you might need to frequently issue the `SHOW CONFIGURATION` command. This gives the Virtual Machines the time to process all the background tasks. If you encounter issues, such as the `orcldg2` logical standby database reporting errors, delve into the problem with the "show database orcldg2" command. If needed, consult with an expert or instructor for troubleshooting.




## Conclusion:

Upon completing this lab, you will have effectively set up and enabled a Data Guard Broker Configuration, incorporating both physical and logical standby databases.
