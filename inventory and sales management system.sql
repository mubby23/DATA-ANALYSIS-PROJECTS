CREATE DATABASE Inventory_and_sales_Database;
USE inventory_and_sales_database;

CREATE TABLE product(
products_id INT(3),
product_name VARCHAR (30),
category VARCHAR (30),
quantity_in_stock INT(20),
reorder_level INT(20),
price_per_unit INT(20),
supplier_id INT(3)
);

INSERT INTO products()
VALUES
(101,'laptop','electronic',50,10,800,1),
(102,'T-shirt','clothig',200,20,15,2),
(103,'smart phone','electronics',70,10,300,1),
(104,'shoes','clothing',80,15,600,1),
(105,'headphones','electronic',120,25,100,1)
;

ALTER TABLE products
MODIFY products_id INT PRIMARY KEY;


-- Suppliers Table
-- Supplier ID (unique identifier)
-- Supplier Name
-- Contact Name
-- Contact Phone
-- Email Address
-- Address

CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(50) NOT NULL,
    contact_name VARCHAR(50),
    contact_phone VARCHAR(15),
    email_address VARCHAR(50),
    home_address VARCHAR(50)
);

INSERT INTO Suppliers (supplier_id, supplier_name, contact_name, contact_phone, email_address, home_address)
VALUES
(1, 'Tech World', 'Wale Martins', '08092080256', 'waletech@gmail.com', '123 Victoria Island, Lagos'),
(2, 'Apparel Inc.', 'Jimoh Mubarak', '08078367363', 'jimoh@apparelinc.com', '456 Ikeja, Lagos'),
(3, 'Gadgets World', 'Wale Ajayi', '09089835678', 'wale@gadgetsworld.com', 'Computer Village, Ikeja, Lagos'),
(4, 'Home Essentials', 'Lawal Basit', '07090893567', 'lawal@homeessentials.com', '1st Avenue, Festac, Lagos'),
(5, 'Fashion Hub', 'Ayo Ridwan', '09037539373', 'aya@fashionhub.com', 'Opp UBA, VI, Lagos');

-- Customers Table
-- Customer ID (unique identifier)
-- Customer Name
-- Contact Number
-- Email Address
-- Shipping Address


CREATE TABLE Customers(
Customer_id INT PRIMARY KEY,
Customer_name VARCHAR(50),
contact_number VARCHAR(20),
email_address VARCHAR(50),
Shipping_address VARCHAR(50)
);

INSERT INTO customers
VALUES
(1,'jide james','0709567877','jidejames@gmail.com','adewale street,ikotun lagos'),
(2,'muid ayman','0912354678','muidayman22@gmail.com','1st avenue, victoia island lagos'),
(3,'alade joel','0912378490','aladejoel@gmail.com','kwara street oshodi lagos'),
(4,'saleem fatimah','09083789728','saleemfati@gmail.com','johnjones crescent ikoyi lagos'),
(5,'abdullah AIsha','08096735783','Aaisha@gmail.com','block abdulaziz estate,lekki phase 1 lagos')
;

CREATE TABLE sales(
sales_id INT PRIMARY KEY,
customer_id INT,
product_id INT,
quantity_sold INT(20),
sale_date DATE,
total_price DECIMAL(10, 2)
);

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity_sold INT,
    sale_date DATE,
    total_price DECIMAL(10, 2)
);

INSERT INTO Sales()
VALUES
(301, 2, 101, 2, '2024-01-10', 800.00),
(302, 4, 102, 5, '2024-12-12', 75.00),
(303, 5, 103, 1, '2024-11-17', 300.00),
(304, 1, 104, 7, '2024-12-18', 4200.00),
(305, 5, 101, 4, '2024-09-19', 1200.00),
(306, 3, 105, 4, '2024-10-19', 400.00),
(307, 2, 104, 4, '2024-02-19', 400.00)
;

CREATE TABLE orders(
order_id INT PRIMARY KEY,
customer_id INT,
product_id INT,
order_date DATE,
order_quantity INT (11),
order_status VARCHAR(20),
total_price DECIMAL(10, 2),
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
FOREIGN KEY (product_id) REFERENCES Products(products_id)
);

INSERT INTO Orders (order_id, customer_id, product_id, order_date,order_quantity, order_status, total_price)
VALUES
(401, 1, 101, '2024-11-01', 2, 'Shipped', 1600.00),
(402, 2, 102, '2024-12-02', 5, 'Pending', 75.00),
(403, 3, 103, '2024-11-03', 1, 'Delivered', 600.00),
(404, 4, 101, '2024-5-04', 3, 'Cancelled', 150.00),
(405, 5, 102, '2024-01-05', 4, 'Shipped', 400.00)
;

CREATE TABLE Inventory_Transactions (
    transaction_id INT PRIMARY KEY,
    products_id INT,
    transaction_date DATE,
    transaction_type VARCHAR(20),
    quantity INT,
    remarks VARCHAR(100),
    FOREIGN KEY (products_id) REFERENCES Products(products_id)
);

INSERT INTO Inventory_Transactions (transaction_id, products_id, transaction_date, transaction_type, quantity, remarks)
VALUES
(1001, 101, '2024-10-01', 'Purchase', 20, 'Restocked from supplier'),
(1002, 102, '2024-10-02', 'Sale', -5, 'Customer purchase'),
(1003, 103, '2024-10-03', 'Sale', -1, 'Customer purchase'),
(1004, 104, '2024-10-04', 'Purchase', 10, 'Restocked from supplier'),
(1005, 105, '2024-10-05', 'Return', 3, 'Customer return');


USE inventory_and_sales_database;

SELECT*
FROM CUSTOMERS
RIGHT OUTER JOIN sales
ON customers.customer_id = sales.customer_id;


-- JOINING THREE TABLES 

USE inventory_and_sales_database
SELECT order_id,customer_name,contact_number,email_address,shipping_address,quantity_sold,order_date,order_status
FROM customers 
INNER JOIN sales
ON customers.customer_id = sales.customer_id
INNER JOIN orders
ON customers.customer_id = orders.customer_id
;

-- JOINING FOUR TABLES 

SELECT*
FROM customers 
RIGHT JOIN sales
ON customers.customer_id = sales.customer_id
INNER JOIN orders
ON customers.customer_id = orders.customer_id 
INNER JOIN suppliers
ON customers.supplier_id=products.supplier_id
;

CREATE VIEW customer_order_tracking AS
SELECT order_id,customer_name,contact_number,email_address,shipping_address,quantity_sold,order_date,order_status
FROM customers 
INNER JOIN sales
ON customers.customer_id = sales.customer_id
INNER JOIN orders
ON customers.customer_id = orders.customer_id
;


