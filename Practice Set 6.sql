create database ecommerce;
use ecommerce;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50),
    created_ad DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10 , 2 ),
    in_stock BOOLEAN
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id),
    FOREIGN KEY (product_id)
        REFERENCES products (product_id)
);

CREATE TABLE reviews (
    reviews_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    customer_id INT,
    rating INT,
    comment VARCHAR(255),
    created_date DATE,
    FOREIGN KEY (product_id)
        REFERENCES products (product_id),
    FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id)
);


insert into customers(customer_name,email,city,created_date) values
('Raj Patel','raj@gmail.com','Ahmedabad','2024-10-01'),
('Priya Mehta','priya@gmail.com','Surat','2024-10-03'),
('Aman Shah','aman@gmail.com','Vadodara','2024-10-05'),
('Neha Desai','neha@gmail.com','Ahmedabad','2024-10-07'),
('Vikas Jain','vikas@gmail.com','Rajkot','2024-10-09');

INSERT INTO products (product_name, category, price, in_stock) VALUES
('Running Shoes','Footwear',1200.00,TRUE),
('Formal Shoes','Footwear',1800.00,TRUE),
('Sports Watch','Accessories',2500.00,TRUE),
('T-Shirt','Clothing',800.00,TRUE),
('Jeans','Clothing',1500.00,TRUE);

INSERT INTO orders (customer_id, product_id, quantity, order_date, status) VALUES
(1,1,2,'2024-10-05','Delivered'),
(2,2,1,'2024-10-06','Delivered'),
(3,3,1,'2024-10-06','Pending'),
(1,4,3,'2024-10-07','Delivered'),
(4,5,1,'2024-10-08','Delivered'),
(5,1,1,'2024-10-09','Delivered'),
(2,3,2,'2024-10-10','Delivered');



INSERT INTO reviews (product_id, customer_id, rating, comment, created_date) VALUES
(1, 1, 5, 'Excellent quality', '2024-10-10'),
(2, 2, 4, 'Very good', '2024-10-11'),
(3, 3, 3, 'Average product', '2024-10-12'),
(1, 5, 4, 'Nice shoes', '2024-10-13'),
(5, 4, 5, 'Perfect fit', '2024-10-14'),
(4, 1, 4, 'Comfortable', '2024-10-15'),
(2, 3, 5, 'Great!', '2024-10-16');


-- 1. Customer, Orders ane Products tables join kari customer name, product name ane order date show karo.
SELECT 
    c.customer_name, p.product_name, o.order_date
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id
        JOIN
    products p ON p.product_id = o.product_id;


-- 2. Products ane Reviews tables join kari product-wise average rating ane total review count show karo.
SELECT 
    p.product_name,
    AVG(r.rating) AS avg_rating,
    COUNT(r.reviews_id) AS total_review
FROM
    products p
        JOIN
    reviews r ON p.product_id = r.product_id
GROUP BY p.product_name;



-- 3. Orders table ma thi Top 3 cities find karo jya thi maximum orders aavya hoy.
SELECT 
    c.city, COUNT(c.customer_id) AS total_order
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_order DESC
LIMIT 3
;

-- 4. Customers find karo jene Footwear category na products mate rating ≥ 4 aapi che.
SELECT 
    c.customer_name
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id
        JOIN
    products p ON p.product_id = o.product_id
        JOIN
    reviews r ON c.customer_id = r.customer_id
WHERE
    p.category = 'Footwear'
        AND r.rating >= 4
GROUP BY c.customer_id;



-- 5. Orders fetch karo jene products ni average rating ≥ 4 hoy. (First avg rating per product → then filter orders)
SELECT 
    o.order_id, AVG(r.rating) AS avg_rating
FROM
    orders o
        JOIN
    products p ON p.product_id = o.product_id
        JOIN
    reviews r ON p.product_id = r.product_id
WHERE
    4 <= (SELECT 
            AVG(rating)
        FROM
            reviews)
GROUP BY o.order_id
HAVING avg_rating >= 4
;



-- 6. Customers + Orders + Products join kari ek view banao → customer_order_details. (Columns: customer name, email, product name, price, quantity, order date)
CREATE VIEW customer_order_details AS
    SELECT 
        c.customer_name,
        c.email,
        p.product_name,
        p.price,
        o.quantity,
        o.order_date
    FROM
        customers c
            JOIN
        orders o ON c.customer_id = o.customer_id
            JOIN
        products p ON p.product_id = o.product_id
select * from customer_order_details;


-- 7. customer_order_details view ma thi Ahmedabad city na customers ni orders fetch karo.

SELECT 
    v.*
FROM
    customer_order_details v
        LEFT JOIN
    customers c ON c.customer_name = v.customer_name
WHERE
    c.city = 'Ahmedabad';




-- 8. Products table ma price par index banao ane price range par fast query perform karo.
create  index price on products(price);
SELECT 
    *
FROM
    products
WHERE
    price BETWEEN 500 AND 1500;




-- 9. Products table ma (category, price) par compound index banao ane Footwear category na products ne price descending ma fetch karo.

create index  compound on products (category, price);
SELECT 
    *
FROM
    products
WHERE
    category = 'Footwear'
ORDER BY prce DESC;

-- 10. Orders table ma order_date par index banao ane recent delivered orders fetch karo.
create index order_date on orders(order_date);
SELECT 
    *
FROM
    orders
ORDER BY order_date DESC
LIMIT 1;



