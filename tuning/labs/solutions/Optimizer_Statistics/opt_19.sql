BEGIN

DBMS_STATS.DROP_EXTENDED_STATS('sh','customers','(LOWER(cust_stat e_province))');
END;
/
