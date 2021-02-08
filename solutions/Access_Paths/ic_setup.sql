-- run with sqlplus /nolog

connect / as sysdba

DROP user IC cascade;

CREATE USER ic IDENTIFIED BY ic;

GRANT DBA TO ic;
GRANT SELECT_CATALOG_ROLE TO ic;
GRANT SELET ANY DICTIONARY TO ic;

connect ic/ic

set echo on

drop table emp purge;
drop table dept purge;

drop cluster emp_dept including tables;

CREATE CLUSTER emp_dept (deptno NUMBER(3))
   SIZE 600
   TABLESPACE users
   STORAGE (INITIAL 200K
      NEXT 300K
      MINEXTENTS 2
      PCTINCREASE 33);

CREATE TABLE emp (
   empno     NUMBER(7)            ,
   ename     VARCHAR2(15) NOT NULL,
   job       VARCHAR2(9)          ,
   mgr       NUMBER(7)            ,
   hiredate  DATE                 ,
   sal       NUMBER(7)          ,
   comm      NUMBER(7)          ,
   deptno    NUMBER(3))
   CLUSTER emp_dept (deptno);  

CREATE TABLE dept (
   deptno NUMBER(3) ,
   dname  VARCHAR2(14),
   loc    VARCHAR2(14),
   c      VARCHAR2(500))
   CLUSTER emp_dept (deptno);

CREATE INDEX emp_dept_index
   ON CLUSTER emp_dept
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

exec dbms_stats.gather_schema_stats('IC');

exit;
