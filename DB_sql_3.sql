USE mavenfuzzyfactorymini;

SELECT *FROM orders_mini;
SELECT *FROM order_items_mini
WHERE order_id = 9994; -- this is the foreign key, which links to the primary kew in orders (order_id)

USE onlinelearningschool;
SELECT *FROM courses;
SELECT *FROM course_ratings;
SELECT *FROM course_ratings_summaries;
 
# using index
USE candystore;
ALTER TABLE `candystore`.`customer_reviews` 
ADD PRIMARY KEY (`customer_review_id`),
ADD INDEX `employee_id` (`employee_id` ASC) VISIBLE;

# using the unique constraint
USE thriftshop;
SELECT *FROM inventory; 
ALTER TABLE `thriftshop`.`inventory` 
ADD UNIQUE INDEX `item_name_UNIQUE` (`item_name` ASC) VISIBLE;

-- INSERT INTO inventory VALUES
-- (14, 'fur for skin',1);

-- Error Code: 1064. 
-- You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version 
-- for the right syntax to use near '{14, 'fur for skin',1}' at line 2	0.000 sec

-- INSERT INTO inventory(inventory_id, item_name,number_in_stock) VALUES (14,'hoy new product',5);
-- DELETE FROM inventory WHERE inventory_id = 14;


-- ALTER TABLE `thriftshop`.`inventory` 
-- CHANGE COLUMN `number_in_stock` `number_in_stock` BIGINT NOT NULL ;

USE sloppyjoes;
SELECT *FROM customer_orders;
SELECT *FROM menu_items;

SELECT *FROM staff;
ALTER TABLE `sloppyjoes`.`staff` 
CHANGE COLUMN `first_name` `first_name` VARCHAR(50) NOT NULL ,
CHANGE COLUMN `last_name` `last_name` VARCHAR(50) NOT NULL ,
CHANGE COLUMN `orders_served` `orders_served` BIGINT NOT NULL ;

SELECT *FROM menu_items;
ALTER TABLE `sloppyjoes`.`menu_items` 
CHANGE COLUMN `item_name` `item_name` VARCHAR(50) NOT NULL ,
CHANGE COLUMN `price` `price` DECIMAL(13,2) NOT NULL ,
ADD UNIQUE INDEX `item_name_UNIQUE` (`item_name` ASC) VISIBLE;

SELECT *FROM customer_orders;

UPDATE customer_orders
SET order_total = 0 
WHERE order_id IN (3,8,12,16,19);

SELECT *FROM customer_orders;
ALTER TABLE `sloppyjoes`.`customer_orders` 
CHANGE COLUMN `order_total` `order_total` DECIMAL(13,2) NOT NULL ,
ADD INDEX `staff_id_idx` (`staff_id` ASC) VISIBLE;
;
ALTER TABLE `sloppyjoes`.`customer_orders` 
ADD CONSTRAINT `staff_id`
  FOREIGN KEY (`staff_id`)
  REFERENCES `sloppyjoes`.`staff` (`staff_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `sloppyjoes`.`customer_orders` 
CHANGE COLUMN `order_total` `order_total` DECIMAL(13,2) NOT NULL ;















