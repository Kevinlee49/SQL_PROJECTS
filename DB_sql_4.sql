# stored procedures

USE thriftshop;
SELECT *FROM inventory; 

-- changing the delimeter
DELIMITER //
-- creating the procedure
CREATE PROCEDURE sp_selectALLInventory()
BEGIN 
	SELECT *FROM inventory;
END //
-- changing the delimiter back to the default
DELIMITER ; 

-- calling the procedure that we have created
CALL sp_selectALLInventory();

-- if we later want to DROP the procedure, we can use the this function
DROP PROCEDURE sp_selectALLInventory;

USE sloppyjoes;

CALL sp_staffOrderServed;

-- HINT: this is the query you want to imbed in a stored procedure
DELIMITER //
CREATE PROCEDURE sp_staffOrderServed()
BEGIN
SELECT 
	staff_id,
    COUNT(order_id) AS orders_served
FROM customer_orders
GROUP BY staff_id;
END //

DELIMITER ; 

USE thriftshop;
SELECT *FROM inventory; 
SELECT *FROM customer_purchases;

CREATE TRIGGER purchaseUpdateInventory
AFTER INSERT ON customer_purchases
FOR EACH ROW 
	UPDATE inventory
		-- subtracting an item for each purchase
		SET number_in_stock = number_in_stock - 1
	WHERE inventory_id = NEW.inventory_id;
    
INSERT INTO customer_purchases VALUES
(13,NULL,3,NULL), -- inventory_id = 3, velour jumpsuit
(14,NULL,4,NULL) -- inventory_id = 4, house slippers
;
##################################

USE sloppyjoes;

CREATE TRIGGER updateOrderServed
AFTER INSERT ON customer_orders
FOR EACH ROW 
	UPDATE staff
		SET orders_served = orders_served + 1
        WHERE staff.staff_id = NEW.staff_id;
        
SELECT *FROM staff;

-- then create my trigger
INSERT INTO customer_orders VALUES
(21,1,4,98),
(22,2,5,99),
(23,2,7,99),
(24,2,8,97);

-- finally, query the staff table again
SELECT *FROM staff;
