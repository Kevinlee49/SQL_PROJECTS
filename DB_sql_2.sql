-- DROP SCHEMA mysecondcodeschema;
USE thriftshop;
SELECT *FROM inventory;
-- INSERT INTO inventory VALUES
-- (10, 'ader gloves',1);

-- INSERT INTO inventory (inventory_id, item_name, number_in_stock) VALUES
-- (11, 'ader cap',3),
-- (12, 'ader hoodie', 14),
-- (13, 'ader boots', 4);

-- INSERT INTO inventory (inventory_id, item_name) VALUES
-- (14, 'ader socks');

-- INSERT INTO inventory VALUES
-- (15, 'item that will not exist',null);

SELECT *FROM inventory;
UPDATE inventory
SET number_in_stock = 0 -- sold out 
WHERE inventory_id = 9;

UPDATE inventory
SET number_in_stock = 0  
WHERE inventory_id IN (1,9);

-- UPDATE inventory
-- SET number_in_stock = 0  
-- WHERE item_name = 'ski blanket';
# important thing!!!
# Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  

USE candystore;
SELECT *FROM employees;

INSERT INTO employees (employee_id,first_name,last_name,hire_date,position) VALUES
(7,'Charles','Munger','2020-03-15','Clerk'),
(8,'Wiliam', 'Gates', '2020-03-15','Clerk'); 

ALTER TABLE employees
ADD COLUMN avg_customer_rating DECIMAL(10,2) AFTER position;

-- UPDATE employees
-- SET avg_customer_rating = 5.0
-- WHERE employee_id = 8;

-- UPDATE employees
-- SET avg_customer_rating = 4.9
-- WHERE employee_id = 4;

# if using case statement, you don't need to update this one by one
USE thriftshop;
SELECT *FROM inventory;

DELETE FROM inventory
WHERE inventory_id = 7;
# autocommit, 1 - on, 2 - off
# using rollback, I can undo the execution.
SELECT @@autocommit; 
SET autocommit = OFF; # or SET autocommit = 0; 

DELETE FROM inventory
WHERE inventory_id = 8; # WHERE inventory_id BETWEEN 1 AND 6; - delete multiple ids

ROLLBACK; 
-- COMMIT; # confirm the delete, so I can not undo.

-- ALTER TABLE `thriftshop`.`customers` 
-- ADD PRIMARY KEY (`customer_id`);
-- ;
SELECT *FROM customers;

SELECT @@autocommit; 
SET autocommit = OFF; # or SET autocommit = 0; 

DELETE FROM customers
WHERE customer_id BETWEEN 1 AND 6;

ROLLBACK;

-- TRUNCATE TABLE customers; # can not be rollback.
