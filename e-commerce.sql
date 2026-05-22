CREATE DATABASE e_commerce;

USE e_commerce;

--Customer table:
CREATE TABLE customers
(
customer_id INT PRIMARY KEY,
name VARCHAR(20),
city VARCHAR(20)
);


--insert values in customers table:
INSERT INTO customers VALUES 
(1,'Samiksha','Pune'),
(2,'Tanaya','Mumbai'),
(3,'Siddhi','Delhi');


SELECT * FROM customers;


--products table:
CREATE TABLE products
(
product_id INT PRIMARY KEY,
product_name VARCHAR(50),
price INT
);

--insert values in products table:
INSERT INTO products VALUES
(101,'Laptop',50000),
(102,'Phone',20000),
(103,'Headphones',20000);

SELECT * FROM products;


----orders table:
CREATE TABLE orders
(
order_id INT PRIMARY KEY,
customer_id INT,
product_id INT,
quantity INT

FOREIGN KEY(customer_id) REFERENCES customers(customer_id),

FOREIGN KEY(product_id) REFERENCES products(product_id)
);

--insert values in orders table:
INSERT INTO orders VALUES
(1,1,101,1),
(2,2,102,2),
(3,3,103,3);

SELECT * FROM orders;


-- show customer name and city:
select name,city from customers;


--show products with price greater than 10000:
select * from products where price > 10000;


--inner join:
SELECT c.name,p.product_name,o.quantity
FROM orders o
INNER JOIN customers c
ON c.customer_id = o.customer_id
INNER JOIN products p
ON p.product_id = o.product_id;


--left join:
SELECT c.name,p.product_name,o.quantity
FROM orders o
LEFT JOIN products p 
ON p.product_id = o.product_id
LEFT JOIN customers c
ON c.customer_id = o.customer_id;


--right join:
SELECT c.name,p.product_name,o.quantity
FROM orders o
RIGHT JOIN products p 
ON p.product_id = o.product_id
RIGHT JOIN customers c
ON c.customer_id = o.customer_id;

--full outer join:
SELECT c.name,p.product_name,o.quantity
FROM customers c
FULL OUTER JOIN orders o
ON c.customer_id = o.order_id
FULL OUTER JOIN products p
ON p.product_id = o.product_id;


--Total orders per customer:
SELECT customer_id,SUM(quantity) AS Total_Items 
FROM orders
GROUP BY customer_id;


--average product price:
SELECT AVG(price) AS AVG_Price FROM Products;

--maximum product price:
SELECT MAX(price) AS MAX_Price FROM products;

--upper function:
SELECT UPPER(name) FROM customers;

--len function:
SELECT LEN(name) FROM customers;

--Show customer name and their ordered product names.
SELECT c.name,p.product_name 
FROM orders o
INNER JOIN customers c
ON c.customer_id = o.customer_id
INNER JOIN products p
ON p.product_id = o.product_id;

--Display all orders with product price and quantity.
SELECT p.price,o.quantity
FROM orders o
INNER JOIN products p
ON p.product_id = o.product_id;

--Show customers who have not placed any orders.
SELECT c.name
FROM customers c
LEFT JOIN orders o
ON c.customer_id=o.customer_id
WHERE o.order_id IS NULL; 


--List all products that were ordered.
SELECT DISTINCT p.product_name
FROM products p
INNER JOIN orders o
ON p.product_id = o.product_id;


--total revenue:
SELECT SUM(p.price * o.quantity) AS Total_Revenue
FROM orders o
INNER JOIN products p
ON p.product_id = o.product_id;

--create stored procedure:
CREATE PROCEDURE GetCustomerOrders
AS
BEGIN
	
	SELECT c.name,p.product_name,o.quantity
	FROM orders o
	INNER JOIN customers c
	ON c.customer_id = o.customer_id
	INNER JOIN products p
	ON p.product_id = o.product_id;

END;

--execute stored procedure:
EXEC GetCustomerOrders;

--create view:
CREATE VIEW customer_orders
AS
SELECT c.name, p.product_name, o.quantity
FROM orders o
INNER JOIN customers c
ON c.customer_id = o.customer_id
INNER JOIN products p
ON p.product_id = o.product_id;

--view the created view:
SELECT * FROM customer_orders;