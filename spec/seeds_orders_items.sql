-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE orders_items RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.
INSERT INTO orders_items (order_id, item_id) VALUES (1, 1);
INSERT INTO orders_items (order_id, item_id) VALUES (1, 2);
INSERT INTO orders_items (order_id, item_id) VALUES (2, 3);;