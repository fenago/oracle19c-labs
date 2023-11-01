# Using the VALIDATE commands

## Overview

In this exercise, you'll explore the various ways to use the DGMGRL `VALIDATE` commands.

---

## Tasks:

### 1. **Setting the Environment**:
   - On the terminal session connected to localhost, authenticate as the `oracle` user and establish the environment.

### 2. **Connect with DGMGRL**:
   - Using DGMGRL, establish a connection to the `orclcdb` database.

### 3. **Discover VALIDATE Commands**:
   - Use the `help` command to present all available `VALIDATE` commands.

### 4. **Compare SPFILE Entries**:
   - Deploy the `VALIDATE` command to compare `SPFILE` entries between the `orclcdb` primary database and the `stndby` standby database.
     - **Note**: The command typically displays only differing parameter settings. To list all compared parameter settings, use `VALIDATE DATABASE VERBOSE stndby SPFILE`.

### 5. **Validate Network for Standby**:
   - Check the network configuration for the `stndby` database.

### 6. **Validate Network for All**:
   - Validate the network configuration for all database members.

### 7. **Examine Static Connect for orclcdb**:
   - Check the static connect identifier of the `orclcdb` database.

### 8. **Examine Static Connect for All**:
   - Validate the static connect identifier for all databases.

### 9. **Exit DGMGRL**:
   - Terminate the DGMGRL session on localhost but leave the terminal window active for subsequent exercises.

---

## Conclusion:

Upon completing this exercise, you'll have gained insights into the various `VALIDATE` commands available in DGMGRL and how they can be employed to inspect different aspects of a Data Guard setup.
