Start Redo Transport and Verify Operation

Overview
In this practice, you will start the redo transport from localhost to stndby for the new physical standby and verify operation.

Tasks
1.	Use a terminal window for localhost logged in as oracle with the environment variables set to orclcdb and start redo transport by defining log_archive_dest_3 pointing to the logical standby database.
Note: For this step, we are configuring redo transportation from the primary database to the logical standby database This is designed to illustrate a typical configuration where the primary database transports redo directly to the standby site, and provide a little variation in the architecture. Again, this is for illustration only. At a later time, we will change this to use the far sync instance.

2.	Determine the last sequence number archived on the primary database.
 
3.	Use a terminal window on stndby2


4.	 connected as oracle with the environment variables set to stndby2. Start SQL*Plus and determine the last sequence number of the physical standby instance.

5.	Return to the terminal window of localhost, and force a log switch to advance the online redo log sequence number. Verify that the sequence number has increased.
 
6.	Return to the terminal window of stndby, and verify that the stndby physical standby instance is receiving redo from the primary database instance.
