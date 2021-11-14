set echo on
EXEC dvsys.dbms_macadm.delete_app_exception( owner => 'C##REPORT', package_name => '')
EXEC dvsys.dbms_macadm.disable_app_protection
exit