COL EXTENSION_NAME FORMAT a30 
COL EXTENSION FORMAT a35

SELECT EXTENSION_NAME, EXTENSION 
FROM	USER_STAT_EXTENSIONS
WHERE TABLE_NAME='CUSTOMERS';
