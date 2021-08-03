load data 
infile '/home/oracle/labs//DB/cities.tbl'
badfile 'cities.bad'
discardfile 'cities.disc'
truncate
into table hr.cities fields terminated by ','
nullif = blanks
(
code,
name
)
