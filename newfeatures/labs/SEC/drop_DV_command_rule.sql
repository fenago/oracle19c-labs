set echo on
exec dvsys.DBMS_MACADM.DELETE_RULE_SET(rule_set_name  => 'Check_user')
exec dvsys.DBMS_MACADM.DELETE_COMMAND_RULE (COMMAND => 'AUDIT POLICY', OBJECT_OWNER => '%', OBJECT_NAME  => 'POL1')
exit