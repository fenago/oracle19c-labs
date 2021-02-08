set echo on

drop user iot cascade;

create user iot identified by iot default tablespace users temporary tablespace temp;

grant connect, resource, dba to iot;

connect iot/iot

drop table iottab purge;

CREATE TABLE IOTTAB (
   OBJECT_ID      NUMBER(14, 0) NOT NULL ENABLE
 , OBJECT_ID_ATT  NUMBER(14, 0) NOT NULL ENABLE
 , OBJECT_ID_CAT  NUMBER(14, 0) NOT NULL ENABLE
 , BEGIN          DATE NOT NULL ENABLE
 , END            DATE NOT NULL ENABLE
 , STATUS         NUMBER
 , COMM           VARCHAR2(32) NOT NULL ENABLE
 , CONSTRAINT IOTTAB_PK
      PRIMARY KEY (OBJECT_ID
                 , OBJECT_ID_ATT
                 , OBJECT_ID_CAT
                 , BEGIN
                 , END) ENABLE )
ORGANIZATION INDEX PCTTHRESHOLD 50 ;

CREATE INDEX OBJECT_ID_ATT_INDX ON IOTTAB (OBJECT_ID_ATT);
 
-- load data

begin
for i in 400001..500000 loop
  insert into iottab values(i,mod(i,428),mod(i,20),sysdate-mod(i,100),sysdate+mod(i,100),mod(i,3),'aaaaaaaaaaaaaaaaaaaaaaaaaa'||i);
end loop;
commit;
end;
/


begin
for i in 100001..200000 loop
  insert into iottab values(i,mod(i,428),mod(i,20),sysdate-mod(i,100),sysdate+mod(i,100),mod(i,3),'aaaaaaaaaaaaaaaaaaaaaaaaaa'||i);
end loop;
commit;
end;
/


begin
for i in 300001..400000 loop
  insert into iottab values(i,mod(i,428),mod(i,20),sysdate-mod(i,100),sysdate+mod(i,100),mod(i,3),'aaaaaaaaaaaaaaaaaaaaaaaaaa'||i);
end loop;
commit;
end;
/


begin
for i in 500001..600000 loop
  insert into iottab values(i,mod(i,428),mod(i,20),sysdate-mod(i,100),sysdate+mod(i,100),mod(i,3),'aaaaaaaaaaaaaaaaaaaaaaaaaa'||i);
end loop;
commit;
end;
/


begin
for i in 1..100000 loop
  insert into iottab values(i,mod(i,428),mod(i,20),sysdate-mod(i,100),sysdate+mod(i,100),mod(i,3),'aaaaaaaaaaaaaaaaaaaaaaaaaa'||i);
end loop;
commit;
end;
/

exit;

