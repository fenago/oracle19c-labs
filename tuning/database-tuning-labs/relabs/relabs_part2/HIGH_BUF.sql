SELECT
   obj      object,
   dbarfil  file#,
   dbablk   block#,
   tch      touches
FROM
   x$bh
WHERE 
   tch > 10
ORDER BY 
   tch desc;
