-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE orders, orders_items RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.
INSERT INTO orders (customer_name, order_date) VALUES ('John Doe', '26/05/2023');
INSERT INTO orders (customer_name, order_date) VALUES ('Jane Doe', '05/08/2020');
INSERT INTO orders (customer_name, order_date) VALUES ('Jimmy Dog', '30/06/2018');