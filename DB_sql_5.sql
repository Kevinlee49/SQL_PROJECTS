/*
1. Kris wants me to track information on her customers
(first name, last name, email), her employees (first name, last name, start date, position held),
her products, and the purchases customers make (which customer, when it was purchased, for how much money).
Think about how many tables you should create. Which data goes in which tables?
How should the tables relate to one another?
*/
-- table: customers
-- customer_id
-- first name
-- last name
-- eamil

-- table: employees
-- employee_id
-- first name
-- last name
-- start_date
-- position

-- table: products
-- product_id
-- product_name
-- launched_date

-- table: customer_purchases
-- customer_purchase_id
-- customer_id
-- product_id
-- purchased_at
-- amount_usd

/*
2. Given the database design you came up with, use Workbench to create an EER diagram of the database.
Include things like primary keys and foreign keys, and anything else you think
you should have in the tables. Make sure to use reasonable data types for each column.

/*
3. Create a schema called Kris. Within that schema, create the tables that you have diagrammed out.
Make sure they relate to each other, and that they have the same reasonable data types you selected previously.
*/

-- CREATE SCHEMA `kris` ;
-- CREATE TABLE `kris`.`customers` (
--   `customer_id` BIGINT NOT NULL,
--   `first_name` VARCHAR(45) NOT NULL,
--   `last_name` VARCHAR(45) NOT NULL,
--   `email_address` VARCHAR(45) NOT NULL,
--   PRIMARY KEY (`customer_id`)); 

USE thriftshop;
SELECT * FROM inventory;
INSERT INTO inventory VALUES (7,'hoodies',12);

SELECT @@autocommit;
SET autocommit = 0; -- 0,1 or OFF,ON

DELETE FROM inventory
WHERE inventory_id = 7;

ROLLBACK;
COMMIT;

CREATE SCHEMA survey;
USE survey;

CREATE TABLE salary_survey(
	country VARCHAR(120),
    years_experienced BIGINT,
    employment_status VARCHAR(120),
    job_title VARCHAR(120),
    is_manager VARCHAR(5),
    education_level VARCHAR(50)
);

SELECT * FROM salary_survey;

--

CREATE SCHEMA mavenbearbuilders;
USE mavenbearbuilders;
SET autocommit = 1;
DROP TABLE bearbuilders;
CREATE TABLE bearbuilders(
	order_item_id BIGINT,
    created_at DATE, # or DATETIME
    order_id BIGINT,
    priced_usd DECIMAL(6,2), # !!! don't forget to use DECIMAL for price and cogs
    cogs_usd DECIMAL(6,2),
    website_session_id BIGINT,
    PRIMARY KEY (order_item_id) # !!! don't forget to write primary key when I create a table
);
SELECT * FROM bearbuilders;

SELECT 
	MIN(created_at),
    MAX(created_at)
    FROM bearbuilders;



