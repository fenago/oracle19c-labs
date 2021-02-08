SELECT /*+ NO_INDEX(t OBJECT_ID_ATT_INDX) */ comm
  FROM iottab t
 WHERE object_id = 1
   AND object_id_cat = 0
   AND object_id_att = 426 ;

