set echo on

alter session set "_db_discard_lost_masterkey"=true;

ADMINISTER KEY MANAGEMENT SET KEYSTORE CLOSE
               IDENTIFIED BY Welcome_1 CONTAINER = ALL;
ADMINISTER KEY MANAGEMENT CREATE KEYSTORE
               '/u01/app/oracle/admin/ORCL/tde_wallet'
               IDENTIFIED BY Welcome_1;
			   
ADMINISTER KEY MANAGEMENT SET KEYSTORE OPEN
               IDENTIFIED BY Welcome_1 CONTAINER = ALL;
			   

ADMINISTER KEY MANAGEMENT SET KEY
               IDENTIFIED BY Welcome_1 WITH BACKUP
               CONTAINER = ALL;
alter session set "_db_discard_lost_masterkey"=true;
			   
exit
