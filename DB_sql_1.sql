# CREATE SCHEMA mythirdcodeschema DEFAULT CHARACTER SET utf8mb4;

USE myfirstcodeschema;

# CREATE TABLE myfirstcodetable( 
#    myfirstcodetable_id BIGINT NOT NULL,
#    my_character_field VARCHAR(50),
#    my_text_field TEXT,
#    my_created_at TIMESTAMP,
#    PRIMARY KEY (myfirstcodetable_id)
#);

SELECT
	my_text_field,
    my_created_at
FROM myfirstcodetable;

-- USE toms_marketing_stuff;
-- DROP TABLE publisher_spend;
-- CREATE TABLE publisher_spend( 
--    publisher_spend_id VARCHAR(45) NOT NULL,
--    publisher_id BIGINT NOT NULL,
--    month DATE NOT NULL,
--    spend DECIMAL(10,2) NOT NULL,
--    PRIMARY KEY (publisher_id)
-- );

SELECT *FROM publisher_spend;
SELECT *FROM publishers;


USE thriftshop;

SELECT *FROM customer_purchases;
SELECT *FROM customers;
SELECT *FROM inventory;

-- ALTER TABLE customer_purchases
-- DROP COLUMN customer_id;

-- ALTER TABLE customer_purchases
-- ADD COLUMN purchase_amount DECIMAL(10,2) AFTER customer_purchase_id;
# 10 represents total number of digits, 2 - number of right decimal place

USE candystore;
SELECT *FROM employees;

-- ALTER TABLE employees
-- DROP COLUMN hourly_wage;

