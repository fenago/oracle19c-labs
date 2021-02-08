SELECT  /*+ result_cache q_name(Q1) */
  COUNT(*)
FROM cachejfv c1, cachejfv c2, cachejfv c3, cachejfv c4, cachejfv c5,
  cachejfv c6, cachejfv c7
WHERE c1.c='b' AND c2.c  ='b' AND c3.c  ='b' AND c4.c  ='b'
AND c5.c  ='b' AND c6.c  ='b' AND c7.c  ='b';

