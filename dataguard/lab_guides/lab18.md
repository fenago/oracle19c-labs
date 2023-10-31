# Create and Enable a Data Guard Broker Configuration

## Overview

In this lab, you will establish and name the Data Guard configuration. This will incorporate the physical standby database, logical standby database, and any associated rules for redo routing. 

> **Note**: The lab guide omits any steps involving `host02` or Far Sync due to unavailability. 

---

## Tasks:

### 1. **Configuration on localhost (Primary)**:
   - On `localhost` (primary), using a terminal window, connect as `oracle` with environment variables set for `orcl2`. 
   - Using SQL*Plus, connect to the primary database and adjust the `LOG_ARCHIVE_DEST_2` and `LOG_ARCHIVE_DEST_3` parameters since they are defined as network locations. 
   - Initiate the Data Guard Broker process and confirm the modifications are persistent. Exit SQL*Plus.

### 3. **Configuration on stndby (Physical Standby)**:
   - On `stndby`, use a terminal window connected as `oracle` with environment variables set to `stndby`. 
   - Connect to the physical standby using SQL*Plus and cease managed recovery. 
   - Adjust the `LOG_ARCHIVE_DEST_2` parameter because it's defined as a network location. 
   - Start the Data Guard broker process for the physical standby database.

### 4. **Configuration on stndby for Logical Standby**:
   - On the same terminal window for `stndby`, exit SQL*Plus. 
   - Modify the environment variables for the `stndby2` logical standby database. 
   - Since there are no network locations defined for redo transportation for the logical standby, initiate the Data Guard broker process. Exit SQL*Plus.

### 5. **Launching DGMGRL on localhost**:
   - Back on `localhost`, in a terminal window, launch DGMGRL and attempt to display the configuration.

### 6. **Creating Data Guard Broker Configuration**:
   - Generate the Data Guard broker configuration and then showcase the configuration.

### 7. **Add Physical Standby to Configuration**:
   - Incorporate the physical standby database `stndby` into the configuration and display the results.

### 8. **Add Logical Standby to Configuration**:
   - Incorporate the logical standby database `stndby2` into the configuration and display the results.

### 9. **Enable Data Guard Broker Configuration**:
   - Activate the Data Guard broker configuration and display the results.

### 10. **Defining Redo Routing Rules**:
   - Establish redo routing rules for the configuration and showcase the results. The current primary database `orclcdb` should forward redo synchronously. For role reversal situations, the primary database will be `stndby`. Redo should be forwarded synchronously in these cases.

> **Note**: Ensure that your output aligns with the above. If discrepancies arise, you might need to frequently issue the `SHOW CONFIGURATION` command. This gives the Virtual Machines the time to process all the background tasks. If you encounter issues, such as the `stndby2` logical standby database reporting errors, delve into the problem with the "show database stndby2" command. If needed, consult with an expert or instructor for troubleshooting.

---

## Conclusion:

Upon completing this lab, you will have effectively set up and enabled a Data Guard Broker Configuration, incorporating both physical and logical standby databases.
