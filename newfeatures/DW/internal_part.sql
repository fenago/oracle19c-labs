SET ECHO ON

CREATE TABLE hypt.part_tab
      (history_event NUMBER , time_id DATE) 
       TABLESPACE ts1 
   PARTITION BY RANGE (time_id) 
   (PARTITION cent18 VALUES LESS THAN (TO_DATE('01-Jan-1800','dd-MON-yyyy')) ,
    PARTITION cent19 VALUES LESS THAN (TO_DATE('01-Jan-1900','dd-MON-yyyy')) ,
    PARTITION cent20 VALUES LESS THAN (TO_DATE('01-Jan-2000','dd-MON-yyyy')) ,
    PARTITION y2000 VALUES LESS THAN  (TO_DATE('01-Jan-2001','dd-MON-yyyy')) TABLESPACE ts2,
    PARTITION pmax VALUES LESS THAN (MAXVALUE));
