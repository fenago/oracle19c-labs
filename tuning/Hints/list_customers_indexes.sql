set echo on

col table_name format a25
col index_name format a30
col index_type format a20


SELECT   ui.table_name
,        decode(ui.index_type
               ,'NORMAL', ui.uniqueness
               ,ui.index_type) AS index_type
,        ui.index_name
FROM     user_indexes  ui
WHERE    ui.table_name = 'CUSTOMERS'
ORDER BY ui.table_name
,        ui.uniqueness desc;

