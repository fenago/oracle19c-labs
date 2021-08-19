-- run with sqlplus /nolog
connect / as sysdba

DROP user NIC cascade;

create user nic identified by nic;
GRANT DBA to NIC;
GRANT SELECT_CATALOG_ROLE to NIC;
GRANT select any dictionary to NIC;

connect nic/nic

set echo on

drop cluster emp_dept including tables;

drop table emp purge;
drop table dept purge;


CREATE TABLE emp (
   empno     NUMBER(7)            ,
   ename     VARCHAR2(15) NOT NULL,
   job       VARCHAR2(9)          ,
   mgr       NUMBER(7)            ,
   hiredate  DATE                 ,
   sal       NUMBER(7)          ,
   comm      NUMBER(7)          ,
   deptno    NUMBER(3)
);  

CREATE TABLE dept (
   deptno NUMBER(3) ,
   dname  VARCHAR2(14),
   loc    VARCHAR2(14),
   c      VARCHAR2(500)
);

CREATE INDEX emp_index
   ON emp(deptno)
   TABLESPACE users
   STORAGE (INITIAL 50K
      NEXT 50K
      MINEXTENTS 2
      MAXEXTENTS 10
      PCTINCREASE 33);

CREATE INDEX dept_index
   ON dept(deptno)
   TABLESPACE users
   STORAGE (INITIAL 50K
      NEXT 50K
      MINEXTENTS 2
      MAXEXTENTS 10
      PCTINCREASE 33);


begin
 for i in 1..999 loop
  insert into dept values (i,'D'||i,'L'||i,dbms_random.string('u',500));
 end loop;
 commit;
end;
/


begin
 for i in 1..500000 loop
  insert into emp values (i,dbms_random.string('u',15),dbms_random.string('u',9),i,sysdate,i,i,mod(i,999));
 end loop;
 commit;
end;
/

exec dbms_stats.gather_schema_stats('NIC');

exit;
