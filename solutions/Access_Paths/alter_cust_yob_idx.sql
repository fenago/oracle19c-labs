select * from v$parameter 
where name = 'optimizer_use_invisible_indexes';

alter index cust_cust_year_of_birth_bidx invisible;

select index_name, visibility from user_indexes 
where table_owner='SH' and table_name='CUSTOMERS';

