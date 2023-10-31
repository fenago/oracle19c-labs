# Oracle Data Guard 19c Lab Guide: Create a Logical Standby (Temporarily a Physical)

## Overview

In this lab, you'll get hands-on experience in preparing the `stndby2` to accommodate a logical standby database. You'll use both RMAN and SQL to accomplish this.

---

## Tasks:

### 1. **Preparation**:
   - Log into a terminal as `oracle` and connect to `orcl2`.
   - Modify the `crdir_stndby.sh` script to reference `stndby2` and execute it. Alternatively, create the necessary directories manually.
   - Note: We're leveraging the script from practice 3-2 to speed up the process.

### 2. **Configuration**:
   - Edit the `initstndby2.ora` file, replacing all instances of `stndby` with `stndby2`.

### 3. **Using RMAN for Duplication**:
   - Connect to the target database via RMAN:
     ```sql
     RMAN target sys/fenago@orcl2 auxiliary sys/fenago@stndby2
     ```
   - Execute the command to create `stndby2`:
     ```sql
     RMAN> duplicate target database for standby from active database;
     ```

### 4. **Restoration and Memory Script Execution**:
   - Follow the on-screen instructions to restore the database. This involves various commands and the execution of memory scripts that set up the necessary parameters and paths for the standby database.

### 5. **Final Steps**:
   - Once the duplication process is complete, allocate the necessary channels and initiate the managed recovery process for the standby database.
   - Finally, release all allocated channels and connections.

---

## Conclusion:

At the end of this lab, you will have successfully set up a temporary physical standby (`stndby2`) that can be later converted to a logical standby. This is crucial for scenarios where you want to maintain both physical and logical standbys for your primary database.
