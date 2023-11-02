# Oracle Data Guard 19c Lab Guide: Convert Physical Standby to Logical Standby

## Overview

In this lab, you'll transition the newly established physical standby database, `stndby2`, into a logical standby setup.

---

## Tasks:

### 1. **Stopping Redo Apply on `stndby2`**:
   - On localhost, in a terminal window, log in as `oracle` ensuring that the environment variables are set to `stndby2`.
   - Cease the redo apply on the `stndby2` physical standby.

### 2. **Building the LogMiner Dictionary**:
   - Using a terminal window on localhost and connected as `oracle` with environment variables set to `orclcdb`, initiate the process to integrate the LogMiner dictionary into the redo stream.
   - It's imperative to await the completion of this step before continuing with subsequent tasks.

### 3. **Redo Data Application**:
   - Access a terminal window targeted at `stndby2`.
   - Make sure to be connected as `oracle` with the environment variables set to `stndby2`.
   - Pursue the application of redo data to the physical standby. This step ensures that the database is primed for a transition to a logical standby.

### 4. **SGA Modification**:
   - Enhance the SGA size designated for the logical standby database. **Note**: This step is a placeholder and should not be executed in this context.

### 5. **Logical Standby Database Restart**:
   - On `stndby2`, halt the logical standby database.
   - Reinitialize it in the MOUNT state.
     ```sql
     SQL> shutdown
     ORA-01507: database not mounted
     ORACLE instance shut down. 
     SQL> startup mount
     ORACLE instance started.
     Database mounted.
     SQL>
     ```

### 6. **Display LOG_ARCHIVE_DEST Parameters**:
   - On `stndby2`, manifest the `LOG_ARCHIVE_DEST` parameters that were propagated from the primary database. The display will only comprise of entries that possess values.

### 7. **Adjust LOG_ARCHIVE_DEST_2 Entry**:
   - Since the logical database (`stndby`) will not serve as a target for role reversal in this tutorial, remove the `LOG_ARCHIVE_DEST_2` entry on it.

### 8. **Open the Logical Standby Database**:
   - Launch the logical standby database, `stndby2`.

### 9. **Initiate SQL Apply**:
   - Commence SQL Apply to instigate the application of redo data arriving from the primary database.

### 10. **Open the ORCLPDB1 PDB**:
   - Activate the `ORCLPDB1` PDB and confirm the mode it operates in.

### 11. **Session Conclusion**:
   - Conclude any active SQL*Plus sessions on all host systems. However, ensure that terminal session windows remain active with the environment variables in place.

---

## Conclusion:

By the conclusion of this lab, you'll have transitioned from a physical standby setup (`stndby2`) to a logical standby configuration. This offers you flexibility in your disaster recovery and data protection strategies.
