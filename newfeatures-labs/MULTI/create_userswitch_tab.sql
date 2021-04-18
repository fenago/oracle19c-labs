set echo on
DROP USER userswitch CASCADE;
CREATE USER userswitch IDENTIFIED BY Welcome_1;
GRANT dba TO userswitch;
CREATE TABLE userswitch.bigtab (label varchar2(30));
 begin
for i in 1..10000 loop
insert into userswitch.bigtab values ('DATA FROM PDB1');
commit;
end loop;
end;
/
