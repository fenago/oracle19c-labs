SELECT /*+ USE_HASH(h l) */ *
FROM orders h, order_items l
WHERE l.order_id = h.order_id;
