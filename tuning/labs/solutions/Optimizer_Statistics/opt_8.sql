
SELECT INDEX_NAME, BLEVEL, LEAF_BLOCKS, CLUSTERING_FACTOR FROM	USER_INDEXES
WHERE TABLE_NAME = 'CUSTOMERS3'
AND	INDEX_NAME = 'CUSTOMERS3_LAST_NAME_IDX';
