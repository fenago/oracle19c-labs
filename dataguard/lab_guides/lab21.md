# Examining Data Guard Log and Trace Files

## Overview

In this exercise, you'll discover and scrutinize the Data Guard log and trace files.

---

## Tasks:

### 1. **Locate ADR's Root Directory**:
   - In a terminal on localhost, with environment variables set to `orcl2`, connect to the primary database via SQL*Plus. Identify the root directory for the Automatic Diagnostic Repository (ADR). Close SQL*Plus afterward.

### 2. **Navigate to ADR's Trace Subdirectory**:
   - Transition to the `trace` subdirectory in the ADR home, which is found at `<diagnostic_dest>/diag/rdbms/<dbname>/<instance_name>`.

### 3. **Check Data Guard Broker Log**:
   - Confirm that past commands that altered the state of redo apply and connection timeout are logged in the Data Guard broker log. This log is dubbed `drc<db_unique_name>.log`.

### 4. **Inspect Trace Directory**:
   - Run `ls -alt | more` to view the trace directory's contents, sorted by descending modification time. The most recently modified files appear first. Exit with <Ctrl + C>.

### 5. **Modify Archive Redo Log Tracking**:
   - Connect to the primary database using SQL*Plus. Adjust the tracking level to 16 for detailed monitoring of archived redo log destination activities. Enforce a log switch, and then close SQL*Plus.

### 6. **Re-inspect Trace Directory**:
   - Once more, execute `ls -alt | more` to view the trace directory's contents, sorted by descending modification time. Spot the newly formed files that weren't present during the prior step 4. To exit, use <Ctrl + C>.

### 7. **Review Trace Files**:
   - Note that the resulting log writer process (LGWR) and network server sync process (NSS) trace files can be considerably large.

---

## Conclusion:

By the end of this exercise, you will have acquired knowledge on how to locate and review the Data Guard log and trace files, offering you deeper insights into the operations and potential issues of your Data Guard setup.