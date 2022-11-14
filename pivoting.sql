USE mavenfuzzyfactory;

SELECT
	/* order_id,
    items_purchased */
    primary_product_id,
    /* CASE WHEN items_purchased = 1 THEN order_id 
    ELSE NULL END AS single_item_orders,
    
    CASE WHEN items_purchased = 2 THEN order_id 
    ELSE NULL END AS two_item_orders, */
    COUNT(DISTINCT CASE WHEN items_purchased = 1 THEN order_id ELSE NULL END) 
    AS count_single_item_orders,
    COUNT(DISTINCT CASE WHEN items_purchased = 2 THEN order_id ELSE NULL END) 
    AS count_two_item_orders
    
FROM orders
WHERE order_id BETWEEN 31000 AND 32000
GROUP BY 1