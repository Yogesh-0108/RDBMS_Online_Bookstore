-- Database Creation
create database online_bookstore;

-- Use the database
use online_bookstore;

-- Table Creation
-- 1.Author table
create table author(author_id int primary key,author_name varchar(30) NOT NULL);

-- 2.Book Category table
create table book_category(category_id int primary key,category_name varchar(20) Not Null unique);

-- 3.Book table
create table book(book_id int primary key,book_title varchar(50) Not Null,author_id int,category_id int,book_price decimal(10,2),stock_quantity int Not Null,created_at DATETIME Not Null, updated_at DATETIME Not Null,constraint fk_author_id foreign key(author_id) references author(author_id), constraint fk_category_id foreign key(category_id) references book_category(category_id));

-- 4.customer table
create table customer(customer_id int primary key,customer_name varchar(30) Not Null,customer_phone varchar(10) Not Null unique,customer_email varchar(30) Not Null unique, registered_at DATETIME Not Null,updated_at DATETIME Not Null);

-- 5.orders table
create table orders(order_id int primary key auto_increment,customer_id int not null, order_date DATETIME Not Null DEFAULT CURRENT_TIMESTAMP,order_status ENUM('Placed','Paid','Shipped','Completed','Cancelled') DEFAULT 'Placed',order_total decimal(10,2),constraint fk_customer_id foreign key(customer_id) references customer(customer_id));


-- 6.order items table
create table order_item(order_item_id int primary key auto_increment,order_id int not null,book_id int not null,quantity int not null,unit_price decimal(10,2) not null,subtotal decimal(10,2) not null,CONSTRAINT fk_item_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
CONSTRAINT fk_item_book FOREIGN KEY (book_id) REFERENCES book(book_id));

-- 7.Payment table
create table payment(payment_id int primary key auto_increment,order_id int not null,payment_date DATETIME,payment_status ENUM('Pending','Completed','Failed') DEFAULT 'Pending',amount_paid decimal(10,2) Not Null,payment_method varchar(30),CONSTRAINT fk_payment_order FOREIGN KEY (order_id) REFERENCES orders(order_id));

-- 8.Delivery table
create table delivery(delivery_id int primary key auto_increment,order_id int not null,delivery_status ENUM('In Progress','Shipped','Delivered') DEFAULT 'In Progress',expected_delivery_date DATE,shipped_date DATE,constraint fk_delivery_order foreign key(order_id) references orders(order_id));

-- 9.Review table
create table review(review_id int primary key auto_increment, customer_id int not null, book_id int not null,rating INT CHECK (rating BETWEEN 1 AND 10),review_text text,review_date DATETIME DEFAULT CURRENT_TIMESTAMP, constraint fk_review_customer foreign key(customer_id) references customer(customer_id),constraint fk_review_book foreign key(book_id) references book(book_id));

-- 10.price change log table
create table price_change_log(log_id int primary key auto_increment, book_id int not null,old_price decimal(10,2) Not Null,new_price decimal(10,2) Not Null,price_change_date DATETIME DEFAULT CURRENT_TIMESTAMP, changed_by varchar(30),constraint fk_price_log_book foreign key(book_id) references book(book_id));

-- Values Insertion
-- Authors table
INSERT INTO author VALUES (1, 'Matt Haig'),(2, 'George Orwell'),(3, 'Yuval Noah Harari'),(4, 'Stephen Hawking'),(5, 'J.K. Rowling');

-- Book Category
INSERT INTO book_category VALUES (1, 'Fiction'), (2, 'Science & Technology'), (3, 'History'), (4, 'Fantasy');

-- Books
INSERT INTO book VALUES (101, 'The Midnight Library', 1, 1, 399.00, 3, NOW(), NOW()),(102, '1984', 2, 1, 299.00, 50, NOW(), NOW()),(103, 'Sapiens', 3, 3, 499.00, 100, NOW(), NOW()),(104, 'Brief History of Time', 4, 2, 599.00, 4, NOW(), NOW()),(105, 'Harry Potter', 5, 4, 699.00, 20, NOW(), NOW()),(106, 'Unused Book', 5, 1, 199.00, 15, NOW(), NOW());

-- Customers
INSERT INTO customer VALUES (1, 'Ravi Kumar', '9876543210', 'ravi@gmail.com', NOW(), NOW()), (2, 'Anita Sharma', '9876543211', 'anita@gmail.com', NOW(), NOW()), (3, 'Rahul Verma', '9876543212', 'rahul@gmail.com', NOW(), NOW()),(4, 'Sneha Iyer', '9876543213', 'sneha@gmail.com', NOW(), NOW());

-- Orders
INSERT INTO orders(customer_id, order_date, order_status, order_total) VALUES
(1, '2024-01-10', 'Completed', 5000),
(1, '2024-03-15', 'Completed', 4000),
(1, '2024-04-10', 'Completed', 3000),
(2, '2024-02-12', 'Paid', 1500),
(3, '2024-04-01', 'Placed', 800),
(4, NOW() - INTERVAL 2 DAY, 'Placed', 1200);

-- Order Items
INSERT INTO order_item(order_id, book_id, quantity, unit_price, subtotal) VALUES
(1, 101, 2, 399, 798),
(1, 102, 5, 299, 1495),
(2, 103, 3, 499, 1497),
(2, 104, 2, 599, 1198),
(3, 105, 4, 699, 2796),
(4, 104, 2, 599, 1198),
(5, 101, 1, 399, 399),
(6, 104, 1, 599, 599);

-- Payments
INSERT INTO payment(order_id, payment_date, payment_status, amount_paid, payment_method) VALUES
(1, '2024-01-10', 'Completed', 5000, 'Card'),
(2, '2024-03-15', 'Completed', 4000, 'UPI'),
(3, '2024-04-10', 'Completed', 3000, 'UPI'),
(4, '2024-02-12', 'Completed', 1500, 'Card'),
(5, NULL, 'Pending', 800, 'UPI'),
(6, NULL, 'Pending', 1200, 'Card');

-- Delivery
INSERT INTO delivery(order_id, expected_delivery_date, delivery_status) VALUES
(1, '2024-01-15', 'Delivered'),
(2, '2024-03-20', 'Delivered'),
(3, '2024-04-15', 'Delivered'),
(4, '2024-02-17', 'Shipped'),
(5, '2024-04-05', 'In Progress'),
(6, '2024-04-07', 'In Progress');

-- REVIEWS
INSERT INTO review(customer_id, book_id, rating, review_text) VALUES
(1,101,9,'Excellent'),
(2,101,8,'Good'),
(3,101,9,'Loved it'),
(4,101,10,'Amazing'),
(1,101,9,'Great'),
(2,101,8,'Nice'),
(3,101,9,'Worth reading'),
(4,101,10,'Fantastic'),
(1,101,9,'Recommended'),
(2,101,8,'Very good');

-- Price Change Log
INSERT INTO price_change_log(book_id, old_price, new_price, changed_by)
VALUES
(101, 349, 399, 'admin'),
(104, 549, 599, 'admin');

-- Retieving all the records
select * from author;
select * from book_category;
select * from book;
select * from orders;
select * from order_item;
select * from customer;
select * from payment;
select * from delivery;
select * from review;
select * from price_change_log;

-- QUESTIONS AND QUERY SOLUTIONS
-- 1. Retrieve a list of all books from the "Fiction" category that are currently in stock
SELECT b.book_title
FROM book b
JOIN book_category c
    ON b.category_id = c.category_id
WHERE c.category_name = 'Fiction'
  AND b.stock_quantity > 0;
  
  -- 2.List the details of all customers who have purchased at least five books in the last three months.
  SELECT 
    c.customer_id,
    c.customer_name,
    c.customer_email,
    c.customer_phone
FROM customer c
JOIN orders o 
    ON c.customer_id = o.customer_id
JOIN order_item oi 
    ON o.order_id = oi.order_id
WHERE o.order_date BETWEEN DATE_SUB(NOW(), INTERVAL 3 MONTH) AND NOW()
GROUP BY 
    c.customer_id, 
    c.customer_name, 
    c.customer_email, 
    c.customer_phone
HAVING SUM(oi.quantity) >= 5;

-- 3.Find all orders placed in 'January 2024', including customer details, book titles, and total order value.
SELECT 
    o.order_id,
    c.customer_id,
    c.customer_name,
    c.customer_phone,
    c.customer_email,
    b.book_title,
    o.order_total
FROM customer c
JOIN orders o 
    ON c.customer_id = o.customer_id
JOIN order_item oi 
    ON o.order_id = oi.order_id
JOIN book b 
    ON oi.book_id = b.book_id
WHERE o.order_date BETWEEN '2024-01-01' AND '2024-01-31' limit 1;

-- 4.Identify books with fewer than five copies left in stock and generate an alert for restocking.
SELECT 
    book_id,
    book_title,
    stock_quantity,
    'ALERT: Restock required' AS alert_message
FROM book
WHERE stock_quantity < 5;

-- 5.List the top five best-selling books of the year based on total sales revenue.
SELECT 
    b.book_id,
    b.book_title,
    SUM(oi.quantity * b.book_price) AS total_sales_revenue
FROM orders o
JOIN order_item oi 
    ON o.order_id = oi.order_id
JOIN book b 
    ON oi.book_id = b.book_id
WHERE YEAR(o.order_date) = YEAR(CURDATE())
GROUP BY 
    b.book_id,
    b.book_title
ORDER BY total_sales_revenue DESC
LIMIT 5;

-- 6.Retrieve all reviews and ratings for the book titled "The Midnight Library" along with the names of customers who posted them
select r.review_text,r.rating,c.customer_name from customer c join review r on c.customer_id=r.customer_id join book b on r.book_id=b.book_id where b.book_title="The Midnight Library";

-- 7.Identify the authors whose books have sold more than 1,000 copies in the last six months.
SELECT 
    a.author_id,
    a.author_name,
    SUM(oi.quantity) AS total_copies_sold
FROM author a
JOIN book b 
    ON a.author_id = b.author_id
JOIN order_item oi 
    ON oi.book_id = b.book_id
JOIN orders o 
    ON o.order_id = oi.order_id
WHERE o.order_date BETWEEN DATE_SUB(NOW(), INTERVAL 6 MONTH) AND NOW()
GROUP BY 
    a.author_id,
    a.author_name
HAVING SUM(oi.quantity) > 1000;

-- 8.Find all orders that include at least one book from the "Science & Technology" category.
SELECT o.order_id
FROM orders o
JOIN order_item oi ON o.order_id = oi.order_id
JOIN book b ON b.book_id = oi.book_id
JOIN book_category bc ON b.category_id = bc.category_id
WHERE bc.category_name = "Science & Technology"
GROUP BY o.order_id
HAVING SUM(oi.quantity) >= 1;

-- 9.Generate a report showing the name, price, category, and stock level of each book.
SELECT 
    b.book_title,
    b.book_price,
    bc.category_name,
    b.stock_quantity
FROM book b
LEFT JOIN book_category bc
    ON b.category_id = bc.category_id;
    
-- 10.Retrieve details of all pending orders, including the estimated delivery date and customer contact details.
SELECT 
    o.order_id,
    o.order_date,
    o.order_total,
    c.customer_name,
    c.customer_phone,
    c.customer_email,
    d.expected_delivery_date
FROM orders o
JOIN customer c 
    ON o.customer_id = c.customer_id
JOIN delivery d 
    ON o.order_id = d.order_id
WHERE o.order_status = 'Pending';

-- 11.Identify customers who have spent more than ₹10,000 in the bookstore in the past year.
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(o.order_total) AS total_spent
FROM customer c
JOIN orders o 
    ON c.customer_id = o.customer_id
WHERE o.order_date BETWEEN DATE_SUB(NOW(), INTERVAL 1 YEAR) AND NOW()
GROUP BY 
    c.customer_id,
    c.customer_name
HAVING SUM(o.order_total) > 10000;

-- 12.Find the total revenue generated from each book category, sorted from highest to lowest revenue.
SELECT 
    bc.category_name,
    SUM(oi.quantity * b.book_price) AS total_amount_per_category
FROM book_category bc
JOIN book b 
    ON bc.category_id = b.category_id
JOIN order_item oi 
    ON oi.book_id = b.book_id
GROUP BY 
    bc.category_name
ORDER BY 
    total_amount_per_category DESC;
    
-- 13.List the details of books that have never been purchased since being added to the inventory.
SELECT 
    b.book_id,
    b.book_title,
    b.book_price,
    b.stock_quantity,
    b.created_at
FROM book b
LEFT JOIN order_item oi 
    ON b.book_id = oi.book_id
WHERE oi.book_id IS NULL;

-- 14.Find the average rating of each book, considering only books with at least 10 reviews.
SELECT 
    b.book_id,
    b.book_title,
    AVG(r.rating) AS average_rating,
    COUNT(r.review_id) AS total_reviews
FROM review r
JOIN book b 
    ON r.book_id = b.book_id
GROUP BY b.book_id, b.book_title
HAVING COUNT(r.review_id) >= 10;

-- 15.Retrieve the total number of books sold each month for the past 12 months.
SELECT 
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    SUM(oi.quantity) AS total_books_sold
FROM orders o
JOIN order_item oi 
    ON o.order_id = oi.order_id
WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
GROUP BY YEAR(o.order_date), MONTH(o.order_date)
ORDER BY order_year, order_month;

-- 16.Identify the customers who have placed more than three orders and have given at least one book review.
SELECT 
    c.customer_id,
    c.customer_name
FROM customer c
JOIN orders o 
    ON c.customer_id = o.customer_id
JOIN review r 
    ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(DISTINCT o.order_id) > 3
   AND COUNT(DISTINCT r.review_id) >= 1;

-- 17.Create a process to update stock levels automatically when an order is placed, ensuring real-time inventory management.
DELIMITER $$
CREATE TRIGGER auto_stock_update
AFTER INSERT ON order_item
FOR EACH ROW
BEGIN
    UPDATE book
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE book_id = NEW.book_id;
END$$
DELIMITER ;

-- 18.Generate a sales report showing the total number of books sold and total revenue for each author.
select author_name,sum(oi.quantity) as total_books, sum(oi.quantity * oi.unit_price) as total_revenue from author a join book b on a.author_id=b.author_id join order_item oi on b.book_id=oi.book_id group by a.author_id;

-- 19. Implement a rule that prevents customers from placing orders if their previous payment is pending for more than 30 days.
DELIMITER $$

CREATE PROCEDURE check_prev_order (
    IN inp_customer_id INT,
    IN inp_order_total DECIMAL(10,2)
)
BEGIN
    DECLARE v_payment_status VARCHAR(20);
    DECLARE v_payment_date DATETIME;

    -- Get latest payment status and date for this customer
    SELECT p.payment_status, p.payment_date
    INTO v_payment_status, v_payment_date
    FROM payment p
    JOIN orders o ON p.order_id = o.order_id
    WHERE o.customer_id = inp_customer_id
    ORDER BY p.payment_date DESC
    LIMIT 1;

    -- If no previous payment exists, allow order
    IF v_payment_status IS NULL THEN
        INSERT INTO orders (customer_id, order_status, order_total)
        VALUES (inp_customer_id, 'Placed', inp_order_total);

    -- If payment is pending for more than 30 days, block order
    ELSEIF v_payment_status = 'Pending'
       AND DATEDIFF(NOW(), v_payment_date) > 30 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Order blocked: Previous payment pending for more than 30 days';

    -- Otherwise allow order
    ELSE
        INSERT INTO orders (customer_id, order_status, order_total)
        VALUES (inp_customer_id, 'Placed', inp_order_total);
    END IF;

END $$

DELIMITER ;

-- 20.Develop a process to bulk-update book prices, ensuring all changes within a batch are either successful or none are.
DELIMITER $$

CREATE PROCEDURE bulk_price_update (
    IN inp_book_id_1 INT,
    IN inp_new_price_1 DECIMAL(10,2),
    IN inp_book_id_2 INT,
    IN inp_new_price_2 DECIMAL(10,2),
    IN inp_changed_by VARCHAR(30)
)
BEGIN
    DECLARE v_old_price_1 DECIMAL(10,2);
    DECLARE v_old_price_2 DECIMAL(10,2);

    -- Error handler: rollback on any failure
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Bulk price update failed. Transaction rolled back.';
    END;

    START TRANSACTION;

    -- Fetch old prices
    SELECT book_price INTO v_old_price_1
    FROM book WHERE book_id = inp_book_id_1 FOR UPDATE;

    SELECT book_price INTO v_old_price_2
    FROM book WHERE book_id = inp_book_id_2 FOR UPDATE;

    -- Update prices
    UPDATE book
    SET book_price = inp_new_price_1
    WHERE book_id = inp_book_id_1;

    UPDATE book
    SET book_price = inp_new_price_2
    WHERE book_id = inp_book_id_2;

    -- Log price changes
    INSERT INTO price_change_log (book_id, old_price, new_price, changed_by)
    VALUES
    (inp_book_id_1, v_old_price_1, inp_new_price_1, inp_changed_by),
    (inp_book_id_2, v_old_price_2, inp_new_price_2, inp_changed_by);

    COMMIT;
END $$

DELIMITER ;

-- 21.Create a view that displays each customer's name, order count and total spending.
CREATE VIEW vw_customer_order_summary AS
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS order_count,
    COALESCE(SUM(o.order_total), 0) AS total_spending
FROM customer c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name;
    
select * from vw_customer_order_summary;
    
-- 22.Create a view that shows the total revenue generated per book category
CREATE VIEW vw_total_revenue_per_category AS
SELECT
    bc.category_id,
    bc.category_name,
    COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS total_revenue
FROM book_category bc
LEFT JOIN book b
    ON bc.category_id = b.category_id
LEFT JOIN order_item oi
    ON b.book_id = oi.book_id
GROUP BY
    bc.category_id,
    bc.category_name;
    
select * from vw_total_revenue_per_category;

-- 23.Automate a daily process at midnight to generate a list of low-stock books and email it to the inventory manager.
-- STEP 1: Create a table to store daily low-stock report
CREATE TABLE low_stock_report (
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    book_title VARCHAR(50),
    current_stock INT,
    report_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_low_stock_book
        FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- STEP 2: Enable Event Scheduler
SET GLOBAL event_scheduler = ON;

-- STEP 3: Create the Scheduled Event (Runs Daily at Midnight)
DELIMITER $$

CREATE EVENT ev_daily_low_stock_report
ON SCHEDULE
    EVERY 1 DAY
    STARTS TIMESTAMP(CURRENT_DATE, '00:00:00')
DO
BEGIN
    -- Clear previous day's report
    DELETE FROM low_stock_report;

    -- Insert low-stock books (stock < 5)
    INSERT INTO low_stock_report (book_id, book_title, current_stock)
    SELECT
        book_id,
        book_title,
        stock_quantity
    FROM book
    WHERE stock_quantity < 5;
END $$

DELIMITER ;

-- STEP 5: View Generated Low-Stock Report (Email Content)
SELECT * FROM low_stock_report;

-- 24.Automate a monthly process to calculate the bookstore's total sales revenue and generate an executive summary report.
-- STEP 1: Create Executive Summary Table
CREATE TABLE monthly_sales_summary (
    summary_id INT AUTO_INCREMENT PRIMARY KEY,
    report_month VARCHAR(20),        -- e.g., 'January 2024'
    total_orders INT,
    total_books_sold INT,
    total_revenue DECIMAL(12,2),
    generated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- STEP 2: Create Monthly Scheduled Event
DELIMITER $$

CREATE EVENT ev_monthly_sales_summary
ON SCHEDULE
    EVERY 1 MONTH
    STARTS TIMESTAMP(DATE_FORMAT(CURRENT_DATE, '%Y-%m-01'), '00:00:00')
DO
BEGIN
    DECLARE v_total_orders INT;
    DECLARE v_total_books INT;
    DECLARE v_total_revenue DECIMAL(12,2);
    DECLARE v_report_month VARCHAR(20);

    -- Calculate report month (previous month)
    SET v_report_month = DATE_FORMAT(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH), '%M %Y');

    -- Total orders in last month
    SELECT COUNT(*)
    INTO v_total_orders
    FROM orders
    WHERE order_date >= DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)
      AND order_status IN ('Paid', 'Shipped', 'Completed');

    -- Total books sold in last month
    SELECT SUM(oi.quantity)
    INTO v_total_books
    FROM order_item oi
    JOIN orders o ON oi.order_id = o.order_id
    WHERE o.order_date >= DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)
      AND o.order_status IN ('Paid', 'Shipped', 'Completed');

    -- Total revenue in last month
    SELECT SUM(oi.quantity * oi.unit_price)
    INTO v_total_revenue
    FROM order_item oi
    JOIN orders o ON oi.order_id = o.order_id
    WHERE o.order_date >= DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)
      AND o.order_status IN ('Paid', 'Shipped', 'Completed');

    -- Insert executive summary
    INSERT INTO monthly_sales_summary
    (report_month, total_orders, total_books_sold, total_revenue)
    VALUES
    (v_report_month, v_total_orders, v_total_books, v_total_revenue);

END $$

DELIMITER ;

SELECT * FROM monthly_sales_summary;

-- 25.Ensure that a customer's total order value is updated correctly when they add or remove items from their cart before making a payment.
DELIMITER $$

-- Trigger for updating after insert
CREATE TRIGGER trg_update_order_total_after_insert
AFTER INSERT ON order_item
FOR EACH ROW
BEGIN
    UPDATE orders
    SET order_total = (
        SELECT SUM(subtotal)
        FROM order_item
        WHERE order_id = NEW.order_id
    )
    WHERE order_id = NEW.order_id;
END $$

DELIMITER ;

-- Trigger for updating after update

DELIMITER $$

CREATE TRIGGER trg_update_order_total_after_update
AFTER UPDATE ON order_item
FOR EACH ROW
BEGIN
    UPDATE orders
    SET order_total = (
        SELECT SUM(subtotal)
        FROM order_item
        WHERE order_id = NEW.order_id
    )
    WHERE order_id = NEW.order_id;
END $$

DELIMITER ;

-- Trigger for updating after delete

DELIMITER $$

CREATE TRIGGER trg_update_order_total_after_delete
AFTER DELETE ON order_item
FOR EACH ROW
BEGIN
    UPDATE orders
    SET order_total = (
        SELECT IFNULL(SUM(subtotal), 0)
        FROM order_item
        WHERE order_id = OLD.order_id
    )
    WHERE order_id = OLD.order_id;
END $$

DELIMITER ;

-- sample insert
INSERT INTO order_item(order_id, book_id, quantity, unit_price, subtotal)
VALUES (1, 101, 2, 400, 800);

-- sample update
UPDATE order_item
SET quantity = 3, subtotal = 1200
WHERE order_id = 1 AND book_id = 101;

-- sample delete
DELETE FROM order_item
WHERE order_id = 1 AND book_id = 101;

-- verification
SELECT order_total FROM orders WHERE order_id = 1;

-- 26. Prevent book inventory from becoming negative when multiple customers place orders simultaneously for the same book.

-- STEP 1: Trigger to Prevent Negative Stock
DELIMITER $$

CREATE TRIGGER trg_prevent_negative_stock
BEFORE INSERT ON order_item
FOR EACH ROW
BEGIN
    DECLARE current_stock INT;

    -- Lock the book row
    SELECT stock_quantity
    INTO current_stock
    FROM book
    WHERE book_id = NEW.book_id
    FOR UPDATE;

    -- Check stock availability
    IF current_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient stock. Order cannot be placed.';
    END IF;
END $$

DELIMITER ;

-- STEP 2: Reduce Stock After Order Placement
DELIMITER $$

CREATE TRIGGER trg_reduce_stock_after_order
AFTER INSERT ON order_item
FOR EACH ROW
BEGIN
    UPDATE book
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE book_id = NEW.book_id;
END $$

DELIMITER ;

-- Handle Cart Updates
DELIMITER $$

CREATE TRIGGER trg_adjust_stock_after_update
AFTER UPDATE ON order_item
FOR EACH ROW
BEGIN
    UPDATE book
    SET stock_quantity = stock_quantity + OLD.quantity - NEW.quantity
    WHERE book_id = NEW.book_id;
END $$

DELIMITER ;

-- STEP 4: Restore Stock if Item Removed
DELIMITER $$

CREATE TRIGGER trg_restore_stock_after_delete
AFTER DELETE ON order_item
FOR EACH ROW
BEGIN
    UPDATE book
    SET stock_quantity = stock_quantity + OLD.quantity
    WHERE book_id = OLD.book_id;
END $$

DELIMITER ;

-- Sample insert
INSERT INTO order_item(order_id, book_id, quantity, unit_price, subtotal)
VALUES (1, 101, 1, 400, 2400);

-- 27.Ensure that payment details are recorded correctly before marking an order as "Shipped" to avoid incomplete or unpaid orders being processed.
DELIMITER $$

CREATE TRIGGER trg_check_payment_before_shipping
BEFORE UPDATE ON orders
FOR EACH ROW
BEGIN
    DECLARE payment_status_val VARCHAR(20);

    -- Run check ONLY when status is changing to 'Shipped'
    IF NEW.order_status = 'Shipped' AND OLD.order_status <> 'Shipped' THEN

        -- Fetch payment status
        SELECT payment_status
        INTO payment_status_val
        FROM payment
        WHERE order_id = NEW.order_id
        ORDER BY payment_date DESC
        LIMIT 1;

        -- If no payment or payment not completed
        IF payment_status_val IS NULL OR payment_status_val <> 'Completed' THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Order cannot be shipped. Payment is incomplete or pending.';
        END IF;

    END IF;
END $$

DELIMITER ;

-- 28.Maintain a log of all changes made to book prices, including the old price, new price, the date of change, and the admin responsible for the update.
create table price_change_log(log_id int primary key auto_increment, book_id int not null,old_price decimal(10,2) Not Null,new_price decimal(10,2) Not Null,price_change_date DATETIME DEFAULT CURRENT_TIMESTAMP, changed_by varchar(30),constraint fk_price_log_book foreign key(book_id) references book(book_id));

select * from price_change_log;

-- 29. Automatically notify the bookstore manager if an order remains in "Pending" status for more than 48 hours.
CREATE TABLE order_notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    message VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_sent BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_notification_order
        FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

DELIMITER $$

CREATE EVENT ev_pending_order_alert
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
    INSERT INTO order_notifications (order_id, message)
    SELECT 
        o.order_id,
        CONCAT(
            'Order ', o.order_id, 
            ' has been pending for more than 48 hours.'
        )
    FROM orders o
    WHERE o.order_status = 'Placed'
      AND o.order_date <= NOW() - INTERVAL 48 HOUR
      AND NOT EXISTS (
          SELECT 1
          FROM order_notifications n
          WHERE n.order_id = o.order_id
      );
END $$

DELIMITER ;