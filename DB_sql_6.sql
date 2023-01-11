USE mavenbearbuilders;
SET autocommit = 1;
CREATE TABLE refunds(
	order_item_refund_id BIGINT,
    created_at DATETIME, # DATE or DATETIME
    order_item_id BIGINT,
    order_id BIGINT, # 
    refund_amount_usd DECIMAL(6,2),
    PRIMARY KEY (order_item_refund_id) # !!! don't forget to write primary key when I create a table
);
# I forgot to write 
# FOREIGN KEY (order_item_id) REFERENCES order_items(order_item_id)
SELECT * FROM refunds;
SELECT *FROM bearbuilders;
DELETE FROM refunds
WHERE order_item_refund_id BETWEEN 6 AND 10; # Be careful deleting without using the PK(Primary Key)

/*
ALTER TABLE `mavenbearbuilders`.`bearbuilders` 
RENAME TO  `mavenbearbuilders`.`order_items` ;

ALTER TABLE `mavenbearbuilders`.`refunds` 
RENAME TO  `mavenbearbuilders`.`order_item_refunds` ;
*/
SELECT * FROM order_item_refunds;
SELECT * FROM order_items;

SELECT 
	MAX(created_at),
    COUNT(*) AS records
FROM order_items;

SELECT 
	MAX(created_at),
    COUNT(*) AS records
FROM order_item_refunds;