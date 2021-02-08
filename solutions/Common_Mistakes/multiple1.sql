--Execute as cm
set echo on

set timing on

SELECT COUNT (*)
FROM myemp
WHERE salary < 2000;

SELECT COUNT (*)
FROM myemp
WHERE salary BETWEEN 2000 AND 4000;

SELECT COUNT (*)
FROM myemp
WHERE salary>4000;

set timing off

