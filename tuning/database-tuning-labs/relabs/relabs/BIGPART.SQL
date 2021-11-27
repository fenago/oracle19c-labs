-- must be logged on as a dba for this Run. 
/* create tablespace jerindex
datafile 'c:\oracle\jerindex01.dbf' size 100m
autoextend on next 2m;
create tablespace tools
datafile 'c:\oracle\tools01.dbf' size 100m
autoextend on next 5m;
create tablespace user_data
datafile 'c:\oracle\userdata01.dbf' size 100m
autoextend on next 5m; */ 

DROP   TABLE        BIG;
CREATE TABLE        BIG
       (BIGNO       NUMBER(9),
        BNAME       VARCHAR2(20),
        bcomments   varchar2(50),
        binteger    number(9)
        );
CREATE  INDEX BIG_BIGNO ON BIG(BIGNO) NOLOGGING
        STORAGE (INITIAL     80K
                 NEXT        80K
                 MINEXTENTS  1
                 ) tablespace jerindex
                 ;
CREATE  INDEX BIG_BNAME ON BIG(BNAME) NOLOGGING
/*      TABLESPACE JERINDEX    */
        STORAGE (INITIAL     80K
                 NEXT        80K
                 MINEXTENTS  1
                ) tablespace jerindex
                 ;
CREATE  INDEX BIG_BNAME_BIGNO ON BIG(BNAME,BIGNO,BINTEGER) NOLOGGING
     TABLESPACE JERINDEX;    

BEGIN
  FOR I IN 1..16000000 LOOP
      IF I BETWEEN 1 AND 2000 THEN
         INSERT INTO BIG VALUES(I,'ONE THOUSAND','TEST UP TO 2000',I+I);
      ELSIF I BETWEEN 2001 AND 5000 THEN
         INSERT INTO BIG VALUES(I,'BET 2K AND 5K','TEST UP TO 5000',I+I);
      ELSE
         INSERT INTO BIG VALUES(I,NULL,'TEST UP TO 100000',I+I);
      END IF;
      IF MOD(I,1000) = 0 THEN COMMIT;
      END IF;
  END LOOP;
END;
/

/*
DROP    TABLE BIG2;
CREATE  TABLE BIG2
        (BIGNO     NUMBER(6),
         BNAME     VARCHAR2(20),
         B2COMMENTS VARCHAR2(50),
         B2INTEGER  NUMBER(9))
         PCTFREE 80
         PCTUSED 15
        STORAGE (INITIAL     40K
                 NEXT        40K
        MINEXTENTS  5
        )
        ;
BEGIN
  FOR I IN 1..5000 LOOP
      IF I < 1001 THEN
         INSERT INTO BIG2 VALUES(I,'ONE THOUSAND','BIG2 UP TO 1000',I+11);
      ELSIF I BETWEEN 2000 AND 5000 THEN
            INSERT INTO BIG2 VALUES(I,'BET 2K AND 5K','BIG2 1001 TO 5000',I+55);
      ELSE
            INSERT INTO BIG2 VALUES(I,NULL,'BIG2 UP TO 100000',I+99);
      END IF;
      IF MOD(I,1000) = 0 THEN COMMIT;
      END IF;
  END LOOP;
END;
/
CREATE INDEX BIG2_BIGNO  ON BIG2(BIGNO) tablespace jerindex NOLOGGING
;
CREATE INDEX BIG2_BNAME  ON BIG2(BNAME) tablespace jerindex NOLOGGING
;
CREATE INDEX BIG2_BNAME_BIGNO ON BIG2(BNAME,BIGNO) tablespace jerindex
;
--CREATE PUBLIC SYNONYM BIG2 FOR BIG2;


commit;  
drop table bigpart;
create table bigpart
  (bigno  number(9) not null,
   bname  varchar2(30),
   bcomments  varchar2(60),
   binteger  number(9))
  storage (initial 100k  next 100k pctincrease 0)
  pctfree 0 pctused 80
  partition by range (bigno)
  (partition bigno1 values less than (1000000)
    tablespace users,
   partition bigno2 values less than (2000000)
   tablespace  user_data,
   partition bigno3 values less than (3000001)
    tablespace tools);
BEGIN
  FOR I IN 1..6000000 LOOP
      IF I BETWEEN 1 AND 1000000 THEN
         INSERT INTO BIGpart VALUES(I,'ONE THOUSAND','TEST UP TO 2000',I+I);
      ELSIF I BETWEEN 1000001 AND 2000000 THEN
         INSERT INTO BIGpart VALUES(I,'BET 2K AND 5K','TEST UP TO 5000',I+I);
      ELSE
         INSERT INTO BIGpart VALUES(I,NULL,'TEST UP TO 300000',I+I);
      END IF;
      IF MOD(I,1000) = 0 THEN COMMIT;
      END IF;
  END LOOP;
END;
/
drop index bigpartx;
drop index bigpartnox;
drop index bigpartcom;
create index bigpartx on bigpart (bname);
create index bigpartnox on bigpart (bigno);
CREATE INDEX BIGPARTCOM ON BIGPART (BIGNO,BCOMMENTS);
set feedback off
set termout off
select b1.bigno, b2.bname,b3.bcomments
from big b1, big2 b2, bigpart b3
where b1.bigno = b2.bigno 
and b1.bigno = b3.bigno 
and b1.bname = b3.bname
and b3.bcomments like '%TEST%';
select b1.bigno, b2.bname,b2.b2comments,b3.bcomments,b3.binteger
from big b1, big2 b2, bigpart b3
where b1.bigno > b2.bigno 
and b1.bigno = b3.bigno 
and b1.bname = b3.bname
and b3.bcomments like '%TEST%' and b1.binteger between 5000 and 900000;
update bigpart
set bcomments = 'Above the 100000 threshold'
where bigno > 1000000;
update bigpart
set bname = 'Above the 2000000 threshold'
where bigno > 2000000;
select b1.bigno, b2.bname,b2.b2comments,b3.bcomments,b3.binteger
from big b1, big2 b2, bigpart b3
where b1.bigno = b2.bigno 
and b1.bigno = b3.bigno 
and b3.bname <> b1.bname
and b3.bcomments like '%TEST%' and b1.binteger between 5000 and 2000000;
set feedback on
set termout on
*/
