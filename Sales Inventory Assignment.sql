/* Answers */
set search_path = assignment;
show search_path;

-- 1. Write a query to select all data from the `Customers` table.
select * from products;
select * from customers;
select * from sales;
select * from inventory;

-- 2. Write a query to select the total number of products from the `Products` table.
select count(product_id) as total_no_of_products from products;

-- 3. Write a query to select the product name and its price from the `Products` table where the price is greater than 500.
select product_name, price from products where price > 500;

-- 4. Write a query to find the average price of all products from the `Products` table.
select avg(price) as Average_Price from products;

-- 5. Write a query to find the total sales amount across all records from the `Sales` table.
select sum(total_amount) from sales;

-- 6. Write a query to select distinct membership statuses from the `Customers` table.
select distinct membership_status from customers;
--select count(distinct membership_status) from customers;

-- 7. Write a query to concatenate first and last names of all customers and show the result as `full_name`.
select concat(first_name, ' ',last_name) as full_name from customers;

-- 8. Write a query to find all products in the `Products` table where the category is 'Electronics'.
select * from products where category='Electronics';

-- 9. Write a query to find the highest price from the `Products` table.
select max(price) from products;
select product_name, price, category from products where price = (select max(price) from products);

-- 10. Write a query to count the number of sales for each product from the `Sales` table.
select product_id, count(sale_id) from sales 
group by product_id;

-- 11. Write a query to find the total quantity sold for each product from the `Sales` table.
select product_id, quantity_sold from sales;

-- 12. Write a query to find the lowest price of products in the `Products` table.
select min(price) as lowest_price from products;

-- 13. Write a query to find customers who have purchased products with a price greater than 1000.
select concat(first_name,' ', last_name), price from customers
join sales on customers.customer_id = sales.customer_id
join products on sales.product_id  = products.product_id 
where price > 1000;

-- 14. Write a query to join the `Sales` and `Products` tables on product_id, and Show product name and total sales amount per product
select product_name, sum(total_amount) as total_sales from products 
inner join sales on products.product_id = sales.product_id
group by product_name;

-- 15. Write a query to join the `Customers` and `Sales` tables and find the total amount spent by each customer.
select concat(c.first_name,' ', c.last_name) as full_name, sum(total_amount) as total_amount_by_cust from sales s
inner join customers c on s.customer_id = c.customer_id
group by c.customer_id;

-- 16. Write a query to join the `Customers`, `Sales`, and `Products` tables, and show each customer's first and last name, product name, and quantity sold.
select first_name, last_name, product_name, quantity_sold from customers
join sales on customers.customer_id = sales.customer_id
join products on sales.product_id  = products.product_id ;


-- 17. Write a query to perform a self-join on the `Customers` table and find all pairs of customers who have the same membership status.
SELECT A.CustomerName AS CustomerName1, B.CustomerName AS CustomerName2, A.City
FROM Customers A, Customers B
WHERE A.CustomerID <> B.CustomerID
AND A.City = B.City
ORDER BY A.City;

select concat(a.first_name, ' ', a.last_name) as customer_A_Full_Name, concat(b.first_name, ' ', b.last_name) as customer_B_Full_Name 
from customers a join customers b on a.membership_status = b.membership_status;

SELECT A.column1,B.column2
FROM table_name A
JOIN table_name B
ON A.common_column = B.common_column;

select a.first_name, b.first_name
from customers a
join customers b
on a.membership_status = b.membership_status;


-- 18. Write a query to join the `Sales` and `Products` tables, and calculate the total number of sales for each product.
select product_name, count(sale_id) from sales
inner join products on sales.product_id = products.product_id
group by product_name;

-- 19. Write a query to find the products in the `Products` table where the stock quantity is less than 10.
select * from products where stock_quantity < 100;

-- 20. Write a query to join the `Sales` table and the `Products` table, and find products with total sales quantity greater than 5/ greater than or equal = 2.
select product_name, quantity_sold from sales
inner join products on sales.product_id = products.product_id
where quantity_sold >= 2 ;

-- 21. Write a query to select customers who have purchased products that are either in the 'Electronics' or 'Appliances' category.
select first_name, last_name, products.category from customers
join sales on customers.customer_id = sales.customer_id
join products on sales.product_id  = products.product_id  where category in ('Electronics','Appliances');


-- 22. Write a query to calculate the total sales amount per product and group the result by product name.
select product_name, sum(total_amount) as total_sales_amount from sales
inner join products on sales.product_id = products.product_id
group by product_name;


-- 23. Write a query to join the `Sales` table with the `Customers` table and select customers who made a purchase in the year 2023.
select first_name, last_name, to_char(sale_date, 'YYYY') as year_date from customers
join sales on customers.customer_id = sales.customer_id
join products on sales.product_id  = products.product_id  where to_char(sale_date, 'YYYY') = '2023';

-- 24. Write a query to find the customers with the highest total sales in 2023.
select concat(customers.first_name,' ', customers.last_name), to_char(sale_date, 'YYYY') as year_date from customers
join sales on customers.customer_id = sales.customer_id
join products on sales.product_id  = products.product_id  
where to_char(sale_date, 'YYYY') = '2023'
group by customers.first_name, customers.last_name, sales.sale_date;

-- 25. Write a query to join the `Products` and `Sales` tables and select the most expensive product sold.
select product_name, price from products
inner join sales on products.product_id = sales.product_id 
where price = (select max(price) from products);

-- 26. Write a query to find the total number of customers who have purchased products worth more than 500.
select count(customer_id) as total_customers from sales where total_amount > 500;

-- 27. Write a query to join the `Products`, `Sales`, and `Customers` tables and find the total number of sales made by customers who are in the 'Gold' membership tier.
select membership_status,count(*) from customers c
inner join sales s on c.customer_id = s.customer_id
inner join products p on s.product_id = p.product_id
group by membership_status;


-- 28. Write a query to join the `Products` and `Inventory` tables and find all products that have low stock (less than 10).
select p.product_name, inv.stock_quantity from products p
join inventory inv on p.product_id = inv.product_id
where inv.stock_quantity < 10
group by product_name, inv.stock_quantity
order by stock_quantity desc;

-- 29. Write a query to find customers who have purchased more than 5 products and show the total quantity of products they have bought.
select  count(products.product_id), sales.quantity_sold from sales 
inner join customers on sales.customer_id = customers.customer_id
inner join products on sales.product_id = products.product_id
group by last_name;


-- 30. Write a query to find the average quantity sold per product.
select product_name, avg(quantity_sold) from sales 
inner join products on sales.product_id = products.product_id
group by product_name;

-- 31. Write a query to find the number of sales made in the month of December 2023.
select count(sale_id) as dec_sales from sales
where sale_date between '2023-12-01' and '2023-12-31';


-- 32. Write a query to find the total amount spent by each customer in 2023 and list the customers in descending order.
select concat(first_name,' ', last_name) as full_name, total_amount from sales
inner join customers on sales.customer_id = customers.customer_id
where to_char(sale_date,'YYYY') = '2023'
order by full_name desc;

-- 33. Write a query to find all products that have been sold but have less than 5 units left in stock.
select product_name, stock_quantity, (stock_quantity - quantity_sold) as stock_remaining from sales
inner join products on sales.product_id = products.product_id
where (stock_quantity - quantity_sold) < 50;

-- 34. Write a query to find the total sales for each product and order the result by the highest sales.
select product_name, sum(total_amount) as total_sales from sales 
inner join products on sales.product_id = products.product_id
group by product_name
order by total_sales desc;

-- 35. Write a query to find all customers who bought products within 7 days of their registration date.
select 
s.sale_date - c.registration_date as days_diff ,
s.sale_date,
c.registration_date,
s.customer_id, concat(first_name, ' ', last_name) as full_name
from customers c
join sales s on c.customer_id = s.customer_id
order by days_diff;

-- 36. Write a query to join the `Sales` table with the `Products` table and filter the results by products priced between 100 and 500.
select product_name, price from products
where price between 100 and 500;

-- 37. Write a query to find the most frequent customer who made purchases from the `Sales` table.
select count(sale_id), concat(first_name,' ', last_name) as full_name from sales
inner join customers on sales.customer_id = customers.customer_id
group by full_name
having count(sale_id) <=1
limit 1;

-- 38. Write a query to find the total quantity of products sold per customer.
select concat(c.first_name,' ', c.last_name) as full_name, sum(s.quantity_sold) from sales s
join customers c on s.customer_id = c.customer_id
group by concat(c.first_name,' ', c.last_name)
order by s.quantity_sold desc;

-- 39. Write a query to find the products with the highest stock and lowest stock, and display them together in a single result set.
--select max(stock_quantity) as Highest_stock, min(stock_quantity) as Lowest_stock from products;
--select max(stock_quantity) as Highest_stock, min(stock_quantity) as Lowest_stock from inventory;
select 
      (select product_name from products order by stock_quantity desc limit 1) as highest_product,
      (select max(stock_quantity) from products) highest_stock,
      (select product_name from products order by stock_quantity asc limit 1) as lowest_product,
      (select min(stock_quantity) from products) highest_stock;

-- 40. Write a query to find products whose names contain the word 'Phone' and their total sales.
select products.product_id, products.product_name, total_amount as total_sales from sales
join products on sales.product_id = products.product_id
where product_name like '%phone%';

-- WILL REFER
-- 41. Write a query to perform an `INNER JOIN` between `Customers` and `Sales`, then display the total sales amount and the product names for customers in the 'Gold' membership status.
select total_amount, concat(first_name, ' ', last_name) as full_name from sales s
inner join customers c on s.customer_id = c.customer_id
group by membership_status;



-- 42. Write a query to find the total sales of products by category.
select category, sum(total_amount) as total_sales_per_category from sales s 
join products p on s.product_id = p.product_id
group by category;

-- Will Refer
-- 43. Write a query to join the `Products` table with the `Sales` table, and calculate the total sales for each product, grouped by month and year.
select p.product_name, to_char(sale_date,'Month') as Month, to_char(sale_date,'YYYY') as year, sum(total_amount) as total_sales from sales s 
inner join products p on s.product_id = p.product_id 
group by product_name, to_char(sale_date,'Month'),to_char(sale_date,'YYYY')
order by month, year ;

-- 44. Write a query to join the `Sales` and `Inventory` tables and find products that have been sold but still have stock remaining.
select product_name, s.quantity_sold, p.stock_quantity from sales s
inner join inventory inv on s.product_id = inv.product_id
inner join products p on inv.product_id = p.product_id
where (p.stock_quantity - s.quantity_sold) >= 1;


-- 45. Write a query to find the top 5 customers who have made the highest purchases.
select concat(c.first_name,' ',c.last_name) as full_name, total_amount  from customers c
join sales s on c.customer_id = s.customer_id
group by concat(c.first_name,' ',c.last_name), total_amount
limit 5;

-- 46. Write a query to calculate the total number of unique products sold in 2023
select count(distinct product_id) as total_number_unique_products from sales where to_char(sale_date, 'YYYY') = '2023';

-- 47. Write a query to find the products that have not been sold in the last 6 months.
select p.product_name from products p
where p.product_id not in 
(select distinct product_id from sales
where sale_date >= CURRENT_DATE - INTERVAL '6 months');

-- 48. Write a query to select the products with a price range between $200 and $800, and find the total quantity sold for each.
select p.product_name, p.price, s.total_amount from products p
inner join sales s on p.product_id = s.product_id
where price between 200 and 800;

-- 49. Write a query to find the customers who spent the most money in the year 2023.
select concat(first_name, ' ', last_name) as full_name, total_amount from sales s 
inner join customers c on s.customer_id = c.customer_id
where to_char(sale_date,'YYYY') = '2023'
order by total_amount desc
limit 5;

-- 50. Write a query to select the products that have been sold more than 100 times and have a price greater than 200.
select p.product_name, count(*) as counts, p.price from products p 
inner join sales s on p.product_id = s.product_id
where  p.price > 200
group by p.product_name,p.price
having count(quantity_sold) > 100;


-- SUBQUERY QUESTIONS

-- 51. Which customers have spent more than the average spending of all customers?
select customer_id,total_amount from sales where total_amount >  
(select avg(total_amount) from sales);

-- 52. Which products are priced higher than the average price of all products?
select product_id,product_name from products where price >  
(select avg(total_amount) from sales);

-- 53. Which customers have never made a purchase?
select first_name, last_name from customers where customer_id not in 
(select customer_id from sales);

-- 54. Which products have never been sold?
select product_name from products where product_id not in 
(select product_id from sales);

-- 55. Which customer made the single most expensive purchase (total amount)?



-- 56. Which products have total sales greater than the average total sales across all products?

-- 57. Which customers registered earlier than the average registration date?
-- Average of a date column can be calculated using; SELECT TO_TIMESTAMP(AVG(EXTRACT(EPOCH FROM registration_date)))::DATE FROM assignment.customers

-- 58. Which products have a price higher than the average price within their own category?

-- 59. Which customers have spent more than the customer with ID = 10?

-- 60. Which products have total quantity sold greater than the overall average quantity sold?

-- COMMON TABLE EXPRESSIONS (CTEs)

-- 61. Create an intermediate result that calculates the total amount spent by each customer,
--     then determine which customers are the top 5 highest spenders.

-- 62. Create an intermediate result that calculates total quantity sold per product,
--     then determine which products are the top 3 most sold.

-- 63. Create an intermediate result showing total sales per product category,
--     then determine which category generates the highest revenue.

-- 64. Create an intermediate result that calculates the number of purchases per customer,
--     then identify customers who purchased more than twice.
with no_of_purchase_per_customer as (
        select customer_id, count(customer_id) as no_of_purchases
         from sales 
       group by customer_id)
select concat(first_name, ' ',last_name) as full_name,
       no_of_purchases from customers c
       inner join no_of_purchase_per_customer npc on c.customer_id = npc.customer_id
       where no_of_purchases <=1;      
       
       
       
-- 65. Create an intermediate result that calculates the total quantity sold per product,
--     then determine which products sold more than the average quantity sold.

-- 66. Create an intermediate result that calculates total spending per customer,
--     then determine which customers spent more than the average spending.

-- 67. Create an intermediate result that calculates total revenue per product,
--     then list the products ordered from highest revenue to lowest.

-- 68. Create an intermediate result showing monthly sales totals,
--     then determine which month had the highest revenue.

-- 69. Create an intermediate result that calculates the number of sales per product,
--     then determine which products were purchased by more than three customers.

-- 70. Create an intermediate result showing total quantity sold per product,
--     then identify products that sold less than the average quantity sold.

-- WINDOW FUNCTION QUESTIONS

-- 71. Rank customers based on the total amount they have spent.

-- 72. Rank products based on total quantity sold.

-- 73. Identify the 3rd highest spending customer.

-- 74. Identify the 2nd most expensive product.

-- 75. Show the ranking of products within each category based on price.

-- 76. Show the ranking of customers based on the number of purchases they made.

-- 77. Show the running total of sales amounts ordered by sale_date.

-- 78. Show the previous sale amount for each sale ordered by sale_date.

-- 79. Show the next sale amount for each sale ordered by sale_date.

-- 80. Divide customers into 4 groups based on total spending.


-- =====================================================
-- ADVANCED ANALYTICAL QUESTIONS
-- =====================================================

-- 81. Which customers bought products in more than one category?

-- 82. Which customers purchased products within 7 days of registering?

-- 83. Which products have lower stock remaining than the average stock quantity?

-- 84. Which customers purchased the same product more than once?

-- 85. Which product categories generated the highest total revenue?

-- 86. Which products are among the top 3 most sold products?

-- 87. Which customers purchased the most expensive product?

-- 88. Which products were purchased by the highest number of unique customers?

-- 89. Which customers made purchases above the average sale amount?

-- 90. Which customers purchased more products than the average quantity purchased per customer?

-- ADVANCED WINDOW + ANALYTICAL PROBLEMS

-- 91. Which customers rank in the top 10% of spending?

-- 92. Which products contribute to the top 50% of total revenue?

-- 93. Which customers made purchases in consecutive months?

-- 94. Which products experienced the largest difference between stock quantity and total quantity sold?

-- 95. Which customers have spending above the average spending of their membership tier?

-- 96. Which products have higher sales than the average sales within their category?

-- 97. Which customer made the largest single purchase relative to their total spending?

-- 98. Which products rank among the top 3 most sold products within each category?

-- 99. Which customers are tied for the highest total spending?

-- 100. Which products generated sales every year present in the dataset?

-- 101. Update the products table to assign a price_category as Expensive (price > 1000), Moderate (price between 500 and 1000), or Affordable (price < 500) using CASE WHEN

-- 102. Update the customers table to assign a customer_level based on total spending as VIP (>20000), Regular (10000–20000), or New (<10000) using CASE WHEN

-- 103. Update the products table to assign a stock_status as Low Stock or Sufficient Stock based on stock_quantity using CASE WHEN

-- 104. Display each customer’s registration year from the registration_date

-- 105. Count how many customers registered in each year

-- 106. Find the total sales amount for each month

-- 107. Show all sales made in the year 2023

-- 108. Find the total sales amount for each year

-- 109. Calculate the number of days each customer has been registered (from registration_date to current date)

-- 110. Display each sale and extract the year and month from the sale date

-- 111. Display each customer’s email and replace null values with 'No Email Provided' using COALESCE

-- 112. Find customers who do not have an email address

-- 113. Find products that have never been sold using a subquery

-- 114. Find customers who have not made any purchases using a subquery

-- 115. Update the products table to assign a price_category (Premium, Standard, Budget) based on price using CASE WHEN

-- 116. Create a PostgreSQL function/procedure that takes a minimum revenue as input and returns all products whose total sales exceed that value

-- 117. Create a PostgreSQL function/procedure that takes a customer_id as input and returns the total amount spent by that customer

-- 118. Create a PostgreSQL function/procedure that takes a start_date and end_date as input and returns the number of orders made within that date range

-- 119. Create a PostgreSQL stored procedure that inserts a new record into the sales table 

-- 120. Create an index on the product_id column in the sales table to improve join performance

-- 121. Create an index on the registration_date column in the customers table to improve filtering by date

-- 122. Write a transaction that inserts a new sale using sale_id, customer_id, product_id, quantity_sold, sale_date, and total_amount, then updates the corresponding product stock_quantity, ensuring both operations succeed or fail together

-- 123. Write a transaction that updates a customer’s email and rolls back the change if the email is invalid

-- 124. Create a view that shows total revenue per product

-- 125. Create a view that shows each customer and their total spending

-- 126. Use UNION to combine a list of all customer first names and product names into a single column

-- 127. Use INTERSECT to find values that appear in both a list of customer IDs and a list of customer IDs who made purchases

-- 128. Perform an anti-join to find products that have never been sold using LEFT JOIN

-- 129. Use NOT EXISTS to find customers who have not made any purchases

-- 130. Cast the price column to an integer and display it alongside the original price

-- 131. Convert registration_date to text format and display it in 'YYYY-MM' format

-- 132. The following query returns an error due to improper GROUP BY usage. Identify and fix the issue
-- SELECT product_id, product_name, SUM(total_amount) FROM sales GROUP BY product_id;

-- 133. The following query incorrectly filters aggregated results using WHERE. Identify and correct it
-- SELECT product_id, SUM(total_amount) FROM sales WHERE SUM(total_amount) > 1000 GROUP BY product_id;

-- 134. The following query returns incorrect results because it uses the wrong join condition. Identify and fix it
-- SELECT *
-- FROM assignment.sales s
-- JOIN assignment.products p
--   ON s.customer_id = p.product_id;

-- 135. Replace NULL email values with 'No Email Provided' using COALESCE if any

-- 136. Trim any leading or trailing spaces from customer first names if any

-- 137. Convert all customer emails to lowercase if any

-- 138. Replace empty strings in phone numbers with NULL if any

-- 139. Extract the year from registration_date and handle any NULL dates gracefully if any



