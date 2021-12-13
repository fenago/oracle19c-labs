--THESE ARE THE OTHER PRESIDENT TABLES
   CREATE TABLE PRESIDENT
     (PRES_NAME                      char(20) not null,
      BIRTH_YR                       number(4) NOT NULL,
      YRS_SERV                       number(4) not null,
      DEATH_AGE                      number(4),
      PARTY                          char(20) not null,
      STATE_BORN                     char(20) not null
      );

CREATE TABLE ELECTION
     (ELECTION_YEAR                      number(4),
        CANDIDATE                        char(20),
        VOTES                            number(4),
        WINNER_LOSER_INDIC               char(1))
           ;
commit;
  CREATE TABLE ADMIN_PR_VP
     (ADMIN_NR                           number(4),
      PRES_NAME                          char(20),
      VICE_PRES_NAME                     char(20))
           ;
commit;

  CREATE TABLE ADMINISTRATION   
     (ADMIN_NR                           number(4),
      PRES_NAME                          char(20),
      YEAR_INAUGURATED                   number(4))
          ;
commit;

  CREATE TABLE PRES_HOBBY
      (PRES_NAME                         char(20),
       HOBBY                             char(20))
          ;
commit;

  CREATE TABLE PRES_MARRIAGE
      (PRES_NAME                         char(20),
       SPOUSE_NAME                       char(20),
       PR_AGE                            number(4),
       SP_AGE                            number(4),
       NR_CHILDREN                       number(4),
       MAR_YEAR                          number(4))
          ;
commit;

  CREATE TABLE STATE
      (STATE                             char(20),
       ADMIN_ENTERED                     number(4),
       YEAR_ENTERED                      number(4))
          ;

commit;

