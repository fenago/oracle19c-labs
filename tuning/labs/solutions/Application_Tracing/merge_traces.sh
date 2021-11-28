#!/bin/bash

cd /home/oracle/labs/solutions/Application_Tracing

trcsess output=mytrace.trc service=TRACESERV /u01/app/oracle/diag/rdbms/orcl/orcl/trace/*.trc

