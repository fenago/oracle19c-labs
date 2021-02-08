SELECT /*+ INDEX(promotions) */ *            
FROM promotions
WHERE promo_id > 300
/