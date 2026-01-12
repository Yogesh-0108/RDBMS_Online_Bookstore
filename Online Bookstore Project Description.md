## **Project: Online Bookstore Database**

### **Purpose**

Design and implement a **database system** for an **Online Bookstore**
to efficiently manage books, customer orders, payments, inventory, and
related operations. This system will replace **manual or outdated
tracking methods**, ensuring accurate order processing, stock
management, and customer engagement through data-driven insights.

### **Description**

An **Online Bookstore** sells a variety of books across different
genres, authors, and publishers. The bookstore wants a **centralized
database** to manage its operations effectively, including **book
inventory, customer orders, order fulfillment, payments, reviews, author
details, and promotional events**.

Currently, the store faces challenges such as **stock shortages, order
delays, and difficulty in tracking sales trends**. The new system will
**streamline order processing, manage customer interactions, track
inventory levels, and provide analytical reports** to improve business
decisions.

The system should enable:

- Customers to browse and purchase books online.

- Admins to manage books, categories, authors, and stock levels.

- Order tracking from placement to delivery.

- Automatic notifications for **low stock alerts** and **order status
  updates**.

- Reporting and analytics to help store managers understand sales
  performance, popular books, and customer behavior.

- Secure payment processing and order fulfillment management.

- Discounts, promotions, and loyalty programs to improve customer
  engagement.

The system must handle large-scale transactions **efficiently**,
especially during peak sales periods like holiday seasons and book
launches.

### **Specific Tasks**

1.  **Retrieve a list of all books** from the \"Fiction\" category that
    are currently in stock.

2.  **List the details of all customers** who have purchased at least
    five books in the last three months.

3.  **Find all orders placed in \'January 2024\'**, including customer
    details, book titles, and total order value.

4.  **Identify books with fewer than five copies left in stock** and
    generate an alert for restocking.

5.  **List the top five best-selling books** of the year based on total
    sales revenue.

6.  **Retrieve all reviews and ratings** for the book titled \"The
    Midnight Library\" along with the names of customers who posted
    them.

7.  **Identify the authors whose books have sold more than 1,000
    copies** in the last six months.

8.  **Find all orders that include at least one book from the \"Science
    & Technology\" category.**

9.  **Generate a report showing the name, price, category, and stock
    level of each book.**

10. **Retrieve details of all pending orders**, including the estimated
    delivery date and customer contact details.

11. **Identify customers who have spent more than ₹10,000** in the
    bookstore in the past year.

12. **Find the total revenue generated from each book category**, sorted
    from highest to lowest revenue.

13. **List the details of books that have never been purchased** since
    being added to the inventory.

14. **Find the average rating of each book**, considering only books
    with at least 10 reviews.

15. **Retrieve the total number of books sold each month** for the past
    12 months.

16. **Identify the customers who have placed more than three orders**
    and have given at least one book review.

17. **Create a process to update stock levels automatically** when an
    order is placed, ensuring real-time inventory management.

18. **Generate a sales report** showing the total number of books sold
    and total revenue for each author.

19. **Implement a rule that prevents customers from placing orders** if
    their previous payment is pending for more than 30 days.

20. **Develop a process to bulk-update book prices**, ensuring all
    changes within a batch are either **successful or none are.**

21. **Create a view that displays each customer\'s name, order count,
    and total spending.**

22. **Create a view that shows the total revenue generated per book
    category.**

23. **Automate a daily process at midnight to generate a list of
    low-stock books** and email it to the inventory manager.

24. **Automate a monthly process to calculate the bookstore's total
    sales revenue** and generate an executive summary report.

25. **Ensure that a customer\'s total order value is updated correctly**
    when they add or remove items from their cart before making a
    payment.

26. **Prevent book inventory from becoming negative** when multiple
    customers place orders simultaneously for the same book.

27. **Ensure that payment details are recorded correctly** before
    marking an order as \"Shipped\" to avoid incomplete or unpaid orders
    being processed.

28. **Maintain a log of all changes made to book prices**, including the
    old price, new price, the date of change, and the admin responsible
    for the update.

29. **Automatically notify the bookstore manager** if an order remains
    in \"Pending\" status for more than 48 hours.
