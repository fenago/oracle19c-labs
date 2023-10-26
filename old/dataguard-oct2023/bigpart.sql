-- must be logged on as a dba for this to Run on orclcdb. 


DROP   TABLE        BIG;
CREATE TABLE        BIG
       (BIGNO       NUMBER(9),
        BNAME       VARCHAR2(20),
        bcomments   varchar2(50),
        binteger    number(9)
        );
*/
BEGIN
  FOR I IN 1..60000000 LOOP
      IF I BETWEEN 1 AND 20000000 THEN
         INSERT INTO BIG VALUES(I,'ONE THOUSAND','TEST UP TO 20000000',I+I);
      ELSIF I BETWEEN 20000001 AND 35000000 THEN
         INSERT INTO BIG VALUES(I,'BET 20M AND 35M','TEST UP TO 35000000',I+I);
      ELSE
         INSERT INTO BIG VALUES(I,NULL,'TEST UP TO 6000000',I+I);
      END IF;
      IF MOD(I,5000) = 0 THEN COMMIT;
      END IF;
  END LOOP;
END;
/
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
  FOR I IN 1..50000 LOOP
      IF I < 10001 THEN
         INSERT INTO BIG2 VALUES(I,'ONE THOUSAND','BIG2 UP TO 10000',I+11);
      ELSIF I BETWEEN 10001 AND 25000 THEN
            INSERT INTO BIG2 VALUES(I,'BET 10K AND 25K','BIG2 1001 TO 5000',I+55);
      ELSE
            INSERT INTO BIG2 VALUES(I,NULL,'BIG2 UP TO 50000',I+99);
      END IF;
      IF MOD(I,5000) = 0 THEN COMMIT;
      END IF;
  END LOOP;
END;
/
CREATE INDEX BIG2_BIGNO  ON BIG2(BIGNO) tablespace jerindex NOLOGGING
;
CREATE INDEX BIG2_BNAME  ON BIG2(BNAME) tablespace jerindex NOLOGGING
;
CREATE INDEX BIG2_BNAME_BIGNO ON BIG2(BNAME,BIGNO) tablespace jerindex
NOLOGGING;
--CREATE PUBLIC SYNONYM BIG2 FOR BIG2;

drop table bigpart;
create table bigpart
  (bigno  number(9) not null,
   bname  varchar2(30),
   bcomments  varchar2(60),
   binteger  number(9))
  storage (initial 100k  next 100k pctincrease 0)
  pctfree 0 pctused 80
  partition by range (bigno)
  (partition bigno1 values less than (10000000)
    tablespace users,
   partition bigno2 values less than (20000000)
   tablespace  user_data,
   partition bigno3 values less than (30000001)
    tablespace tools);
BEGIN
  FOR I IN 1..30000000 LOOP
      IF I BETWEEN 1 AND 10000000 THEN
         INSERT INTO BIGpart VALUES(I,'ONE THOUSAND','TEST UP TO 10000000',I+I);
      ELSIF I BETWEEN 10000001 AND 20000000 THEN
         INSERT INTO BIGpart VALUES(I,'BET 10m AND 20m','TEST UP TO 10500000',I+I);
      ELSE
         INSERT INTO BIGpart VALUES(I,NULL,'TEST UP TO 30000000',I+I);
      END IF;
      IF MOD(I,5000) = 0 THEN COMMIT;
      END IF;
  END LOOP;
END;
/
drop index bigpartx;
drop index bigpartnox;
drop index bigpartcom;
create index bigpartx on bigpart (bname) NOLOGGING;
create index bigpartnox on bigpart (bigno) NOLOGGING;
CREATE INDEX BIGPARTCOM ON BIGPART (BIGNO,BCOMMENTS) NOLOGGING;

  

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
and b3.bcomments like '%TEST%' and b1.binteger between 5000 and 9000000;
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
and b3.bcomments like '%TEST%' and b1.binteger between 5000 and 20000000;
set feedback on
set termout on

