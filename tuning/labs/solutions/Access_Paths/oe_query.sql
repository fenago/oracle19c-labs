SELECT *
FROM orders h, order_items l
WHERE l.order_id = h.order_id;
