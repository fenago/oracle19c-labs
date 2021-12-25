-- CREATE PRESIDENT TABLESPACE PERSONELL IN YOUR ASSIGNED DATABASE 
	--CREATE TABLESPACE personell
        --datafile 'C:\WORK\PERS.dbf' size 10m;	
           --  x is for your assigned drive
--	COMMIT;
-- CREATE PRESIDENT TABLE WITH A PRIMARY KEY CONSTRAINT ON
-- THE PRES_NAME COLUMN
      CREATE TABLE PRESIDENT
     (PRES_NAME                      char(20) not null,
      BIRTH_YR                       number(4) NOT NULL,
      YRS_SERV                       number(4) not null,
      DEATH_AGE                      number(4),
      PARTY                          char(20) not null,
      STATE_BORN                     char(20) not null,
	PRIMARY KEY (PRES_NAME) 
      )
      TABLESPACE USERS
      ;
/
