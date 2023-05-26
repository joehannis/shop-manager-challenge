-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE items, orders_items RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.
INSERT INTO items (item_name, price, quantity) VALUES ('bread', 2.50, 100);
INSERT INTO items (item_name, price, quantity) VALUES ('milk', 0.75, 150);
INSERT INTO items (item_name, price, quantity) VALUES ('butter', 3.00, 80);