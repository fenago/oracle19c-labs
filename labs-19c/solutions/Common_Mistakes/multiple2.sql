set echo on

set timing on

SELECT COUNT (CASE WHEN salary < 2000 
                   THEN 1 ELSE null END) count1, 
       COUNT (CASE WHEN salary BETWEEN 2001 AND 4000 
                   THEN 1 ELSE null END) count2, 
       COUNT (CASE WHEN salary > 4000 
                   THEN 1 ELSE null END) count3 
FROM myemp; 

