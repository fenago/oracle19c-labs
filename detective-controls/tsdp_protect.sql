Use SQL Developer
orclpdb1_sys

begin
 sys.dbms_tsdp_manage.add_sensitive_type
 (sensitive_type => 'email_type',
  user_comment => 'Test');
end;
/

begin
 sys.dbms_tsdp_manage.add_sensitive_column
 (schema_name => 'HR',
  table_name => 'employees',
  column_name => 'email', 
  sensitive_type => 'email_type');
end;
/

declare
 redact_feature_options dbms_tsdp_protect.feature_options;
 policy_conditions dbms_tsdp_protect.policy_conditions;
begin
 redact_feature_options('expression') := '1=1';
 redact_feature_options('function_type') := 'dbms_redact.random';
 policy_conditions(dbms_tsdp_protect.datatype) := 'varchar2';
 dbms_tsdp_protect.add_policy
 ('redact_random_email',dbms_tsdp_protect.redact,redact_feature_options,policy_conditions);
end;
/  

begin
  dbms_tsdp_protect.associate_policy
  (policy_name => 'redact_random_email',
  sensitive_type => 'email_type',
   associate => true);
end;
/

begin 
 dbms_tsdp_protect.enable_protection_type
  (sensitive_type => 'email_type');
  end;
  /

Use SQL Developer 
orclpdb1_hr 

select last_name,email
from hr.employees;

Once Validation is complete as orclpdb1_hr use orclpdb1_sys or orclpdb1_system

select last_name,email from hr.employees

