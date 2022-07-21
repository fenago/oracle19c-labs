echo "***** Stopping agent on host01 *****"
plink -X -ssh -pw oracle -l oracle host01 /u01/app/oracle/agent/agent_inst/bin/emctl stop agent
echo "***** Stopping agent on host02 *****"
plink -X -ssh -pw oracle -l oracle host02 /u01/app/oracle/agent/agent_inst/bin/emctl stop agent
echo "***** Stopping agent on host03 *****"
plink -X -ssh -pw oracle -l oracle host03 /u01/app/oracle/agent/agent_inst/bin/emctl stop agent
echo "***** Stopping agent on host04 *****"
plink -X -ssh -pw oracle -l oracle host04 /u01/app/oracle/agent/agent_inst/bin/emctl stop agent
echo "***** Stopping OMS on em12 *****"
plink -X -ssh -pw oracle -l oracle em12 /u01/app/oracle/middleware/oms/bin/emctl stop oms -all
echo "***** Stopping agent on em12 *****"
plink -X -ssh -pw oracle -l oracle em12 /u01/app/oracle/agent/agent_inst/bin/emctl stop agent 
echo "***** Stopping DB/Listener on em12 *****"
plink -X -ssh -pw oracle -l oracle em12 /u01/app/oracle/product/11.2.0/dbhome_1/bin/dbshut /u01/app/oracle/product/11.2.0/dbhome_1
