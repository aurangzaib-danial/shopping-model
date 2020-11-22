
 -- Tables
 -- Users
 -- Orders
 -- Products
 -- Order_Products 

 -- Relations 
 -- user has many orders
 -- order and products have a many-to-many relation

CREATE TABLE users (id INTEGER PRIMARY KEY, name VARCHAR(100));
CREATE TABLE products (id INTEGER PRIMARY KEY, name VARCHAR(100), price REAL);
CREATE TABLE orders (id INTEGER PRIMARY KEY, order_date DATE, confirmed BOOLEAN, user_id INTEGER);
CREATE TABLE order_products (order_id INTEGER, product_id INTEGER);

INSERT INTO users (name) VALUES ('Sunny'), ('George');
INSERT INTO products (name, price) VALUES
('iPhone', 5),
('Macbook', 10),
('HP Printer', 3),
('Headphone', 1);

INSERT INTO orders (order_date, confirmed, user_id) VALUES
('2020-01-15', 0, 1),
('2020-02-25', 1, 2),
('2020-03-20', 1, 1);

INSERT INTO order_products (order_id, product_id) VALUES
(1, 1),
(1, 3), -- 8
(2, 2),
(2, 4), -- 11
(3, 2); -- 10

-- Sunny 18
-- George 11

-- Questions
-- 1. Total of a order
-- 2. All orders of a user with their total price
-- 3. Orders of a user between two dates
-- 4. Most valued customer (combined price of orders)
-- 5. Most expensive product
-- 6. Confirmed and unconfirmed orders
-- 7. Products of a order

-- 1. Total of a order
SELECT orders.id, SUM(products.price) AS order_total FROM orders 
JOIN order_products ON orders.id = order_products.order_id
JOIN products ON order_products.product_id = products.id
WHERE orders.id = 1;

-- 2. All orders of a user with their total price
SELECT orders.id, SUM(products.price) AS order_total FROM orders 
JOIN order_products ON orders.id = order_products.order_id
JOIN products ON order_products.product_id = products.id
WHERE orders.user_id = 1
GROUP BY orders.id;

-- 3. Orders between two dates
SELECT * FROM orders 
WHERE user_id = 2 AND 
order_date BETWEEN '2020-01-01' AND '2020-03-02'

-- 4. Most valued customer (combined price of orders)
SELECT users.name as most_valuable_customer, SUM(products.price) AS total_purchase FROM orders 
JOIN order_products ON orders.id = order_products.order_id
JOIN products ON order_products.product_id = products.id
JOIN users ON orders.user_id = users.id
GROUP BY users.id
ORDER BY total_purchase DESC
LIMIT 1;

-- 5. Most expensive product
SELECT name, price FROM products ORDER BY price DESC LIMIT 1;

-- 6. unconfirmed orders
SELECT * FROM orders WHERE confirmed = 0;

-- 7. Products of a order
SELECT products.name FROM orders 
JOIN order_products ON orders.id = order_products.order_id
JOIN products ON order_products.product_id = products.id
WHERE orders.id = 2;

