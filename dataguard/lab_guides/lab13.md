# Oracle Data Guard 19c Lab Guide: Identify Unsupported Objects for Logical Standbys

## Overview

In this lab, you will inspect the primary database to discern which objects will not be compatible with a logical standby setup.

---

## Tasks:

### 1. **Setup and Preliminary Checks**:
   - On `localhost`, open a terminal window and connect as `oracle`.
   - Ensure the environment variables are set to `orclcdb`.
   - Launch SQL*Plus.
   - Make sure all pluggable databases are accessible for queries. If any pluggable database is in the `MOUNTED` state or shut down, the subsequent steps might not yield comprehensive results.

### 2. **Tables Without Unique Identifiers**:
   - Identify all tables, across all PDBs, that lack unique logical identifiers in the primary database. This query may take some time.
   - _Note: The provided query for this task has been adjusted from the original documentation to inspect schema objects across all PDBs._

### 3. **Internal Schemas**:
   - Determine the inbuilt schemas that come with the Oracle Database.
   - Any custom table added to these schemas will not be replicated on the logical standby database. Furthermore, such tables won't appear in the `DBA_LOGSTDBY_UNSUPPORTED` or `CDB_LOGSTDBY_UNSUPPORTED` views in the next step, despite being unsupported.
   - _Note: This query has been adapted to explore schema objects across all PDBs._

### 4. **Unsupported Tables**:
   - Identify tables that are not part of internal schemas and won't be handled by SQL Apply due to incompatible data types.

### 5. **Conflicting Columns and Data Types**:
   - Check columns and their respective data types that might conflict with SQL Apply.
   - After completing your inspections, exit SQL*Plus.

---

## Conclusion:

By the end of this lab, you will have a clear understanding of which objects in your primary database might pose challenges when setting up a logical standby. This knowledge is crucial for ensuring smooth replication and minimizing disruptions.
