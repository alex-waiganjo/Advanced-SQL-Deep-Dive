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
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT p.category) AS num_categories
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
JOIN assignment.products p ON s.product_id = p.product_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT p.category) > 1
ORDER BY num_categories DESC;

-- 82. Which customers purchased products within 7 days of registering?
SELECT DISTINCT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.registration_date,
    MIN(s.sale_date) AS first_purchase_date
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
WHERE s.sale_date <= c.registration_date + INTERVAL '7 days'
GROUP BY c.customer_id, c.first_name, c.last_name, c.registration_date;

-- 83. Which products have lower stock remaining than the average stock quantity?
WITH avg_stock AS (
    SELECT AVG(stock_quantity) AS avg_stock
    FROM assignment.products
)
SELECT 
    product_id,
    product_name,
    stock_quantity,
    (SELECT avg_stock FROM avg_stock) AS avg_stock_qty
FROM assignment.products
WHERE stock_quantity < (SELECT avg_stock FROM avg_stock)
ORDER BY stock_quantity ASC;

-- 84. Which customers purchased the same product more than once?
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    s.product_id,
    p.product_name,
    COUNT(*) AS purchase_count
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
JOIN assignment.products p ON s.product_id = p.product_id
GROUP BY c.customer_id, c.first_name, c.last_name, s.product_id, p.product_name
HAVING COUNT(*) > 1
ORDER BY purchase_count DESC;

-- 85. Which product categories generated the highest total revenue?
SELECT 
    p.category,
    SUM(s.total_amount) AS total_revenue
FROM assignment.sales s
JOIN assignment.products p ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- 86. Which products are among the top 3 most sold products?
WITH ranked_products AS (
    SELECT 
        p.product_id,
        p.product_name,
        SUM(s.quantity_sold) AS total_sold,
        RANK() OVER (ORDER BY SUM(s.quantity_sold) DESC) AS rank
    FROM assignment.sales s
    JOIN assignment.products p ON s.product_id = p.product_id
    GROUP BY p.product_id, p.product_name
)
SELECT product_id, product_name, total_sold
FROM ranked_products
WHERE rank <= 3;

-- 87. Which customers purchased the most expensive product?
WITH max_price AS (
    SELECT MAX(price) AS max_p FROM assignment.products
)
SELECT DISTINCT 
    c.customer_id,
    c.first_name,
    c.last_name
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
JOIN assignment.products p ON s.product_id = p.product_id
WHERE p.price = (SELECT max_p FROM max_price);

-- 88. Which products were purchased by the highest number of unique customers?
SELECT 
    p.product_id,
    p.product_name,
    COUNT(DISTINCT s.customer_id) AS unique_customers
FROM assignment.sales s
JOIN assignment.products p ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY unique_customers DESC
LIMIT 10; 

-- 89. Which customers made purchases above the average sale amount?
WITH avg_sale AS (
    SELECT AVG(total_amount) AS avg_amount FROM assignment.sales
)
SELECT DISTINCT 
    c.customer_id,
    c.first_name,
    c.last_name
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
WHERE s.total_amount > (SELECT avg_amount FROM avg_sale);

-- 90. Which customers purchased more products than the average quantity purchased per customer?
WITH customer_totals AS (
    SELECT 
        customer_id,
        SUM(quantity_sold) AS total_qty
    FROM assignment.sales
    GROUP BY customer_id
),
avg_qty AS (
    SELECT AVG(total_qty) AS avg_quantity 
    FROM customer_totals
)
SELECT 
    c.cust_id,
    c.first_name,
    c.last_name,
    ct.total_qty
FROM customer_totals ct
JOIN assignment.customers c ON ct.customer_id = c.cust_id
WHERE ct.total_qty > (SELECT avg_quantity FROM avg_qty)
ORDER BY ct.total_qty DESC;

-- ADVANCED WINDOW + ANALYTICAL PROBLEMS

-- 91. Which customers rank in the top 10% of spending?
WITH customer_spending AS (
    SELECT 
        customer_id,
        SUM(total_amount) AS total_spent,
        NTILE(10) OVER (ORDER BY SUM(total_amount) DESC) AS percentile
    FROM assignment.sales
    GROUP BY customer_id
)
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    cs.total_spent
FROM customer_spending cs
JOIN assignment.customers c ON cs.customer_id = c.customer_id
WHERE cs.percentile = 1  -- top 10%
ORDER BY cs.total_spent DESC;

-- 92. Which products contribute to the top 50% of total revenue?
WITH product_revenue AS (
    SELECT 
        p.product_id,
        p.product_name,
        SUM(s.total_amount) AS revenue,
        SUM(SUM(s.total_amount)) OVER () AS grand_total,
        SUM(SUM(s.total_amount)) OVER (ORDER BY SUM(s.total_amount) DESC) AS running_total
    FROM assignment.sales s
    JOIN assignment.products p ON s.product_id = p.product_id
    GROUP BY p.product_id, p.product_name
)
SELECT 
    product_id,
    product_name,
    revenue,
    (running_total / grand_total * 100) AS cumulative_percent
FROM product_revenue
WHERE running_total / grand_total <= 0.5
ORDER BY revenue DESC;

-- 93. Which customers made purchases in consecutive months?
WITH monthly_purchases AS (
    SELECT 
        customer_id,
        DATE_TRUNC('month', sale_date) AS purchase_month,
        LAG(DATE_TRUNC('month', sale_date)) OVER (PARTITION BY customer_id ORDER BY DATE_TRUNC('month', sale_date)) AS prev_month
    FROM assignment.sales
    GROUP BY customer_id, DATE_TRUNC('month', sale_date)
)
SELECT DISTINCT 
    c.customer_id,
    c.first_name,
    c.last_name
FROM monthly_purchases mp
JOIN assignment.customers c ON mp.customer_id = c.customer_id
WHERE mp.purchase_month = mp.prev_month + INTERVAL '1 month';

-- 94. Which products experienced the largest difference between stock quantity and total quantity sold?
SELECT 
    p.product_id,
    p.product_name,
    p.stock_quantity,
    COALESCE(SUM(s.quantity_sold), 0) AS total_sold,
    p.stock_quantity - COALESCE(SUM(s.quantity_sold), 0) AS stock_diff
FROM assignment.products p
LEFT JOIN assignment.sales s ON p.product_id = s.product_id
GROUP BY p.product_id, p.product_name, p.stock_quantity
ORDER BY ABS(stock_quantity) DESC
LIMIT 10;

-- 95. Which customers have spending above the average spending of their membership tier?
WITH tier_avg AS (
    SELECT 
        c.membership_status,
        AVG(total_spent) AS avg_tier_spend
    FROM (
        SELECT 
            customer_id,
            SUM(total_amount) AS total_spent
        FROM assignment.sales
        GROUP BY customer_id
    ) sp
    JOIN assignment.customers c ON sp.customer_id = c.customer_id
    GROUP BY c.membership_status
)
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.membership_status,
    sp.total_spent,
    ta.avg_tier_spend
FROM (
    SELECT customer_id, SUM(total_amount) AS total_spent
    FROM assignment.sales
    GROUP BY customer_id
) sp
JOIN assignment.customers c ON sp.customer_id = c.customer_id
JOIN tier_avg ta ON c.membership_status = ta.membership_status
WHERE sp.total_spent > ta.avg_tier_spend;

-- 96. Which products have higher sales than the average sales within their category?
WITH category_avg AS (
    SELECT 
        p.category,
        AVG(total_sold) AS avg_category_sales
    FROM (
        SELECT 
            product_id,
            SUM(quantity_sold) AS total_sold
        FROM assignment.sales
        GROUP BY product_id
    ) sold
    JOIN assignment.products p ON sold.product_id = p.product_id
    GROUP BY p.category
)
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    COALESCE(SUM(s.quantity_sold), 0) AS product_sales,
    ca.avg_category_sales
FROM assignment.products p
LEFT JOIN assignment.sales s ON p.product_id = s.product_id
JOIN category_avg ca ON p.category = ca.category
GROUP BY p.product_id, p.product_name, p.category, ca.avg_category_sales
HAVING COALESCE(SUM(s.quantity_sold), 0) > ca.avg_category_sales;

-- 97. Which customer made the largest single purchase relative to their total spending?
WITH customer_stats AS (
    SELECT 
        customer_id,
        SUM(total_amount) AS total_spent,
        MAX(total_amount) AS largest_single
    FROM assignment.sales
    GROUP BY customer_id
)
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    cs.largest_single,
    cs.total_spent,
    (cs.largest_single::float / cs.total_spent) AS ratio
FROM customer_stats cs
JOIN assignment.customers c ON cs.customer_id = c.customer_id
ORDER BY ratio DESC
LIMIT 5;

-- 98. Which products rank among the top 3 most sold products within each category?
WITH ranked AS (
    SELECT 
        p.category,
        p.product_id,
        p.product_name,
        SUM(s.quantity_sold) AS total_sold,
        RANK() OVER (PARTITION BY p.category ORDER BY SUM(s.quantity_sold) DESC) AS rank
    FROM assignment.sales s
    JOIN assignment.products p ON s.product_id = p.product_id
    GROUP BY p.category, p.product_id, p.product_name
)
SELECT category, product_id, product_name, total_sold, rank
FROM ranked
WHERE rank <= 3
ORDER BY category, rank;

-- 99. Which customers are tied for the highest total spending?
WITH spending AS (
    SELECT 
        customer_id,
        SUM(total_amount) AS total_spent,
        RANK() OVER (ORDER BY SUM(total_amount) DESC) AS rnk
    FROM assignment.sales
    GROUP BY customer_id
)
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    s.total_spent
FROM spending s
JOIN assignment.customers c ON s.customer_id = c.customer_id
WHERE s.rnk = 1;

-- 100. Which products generated sales every year present in the dataset?
WITH years AS (
    SELECT DISTINCT EXTRACT(YEAR FROM sale_date) AS sale_year
    FROM assignment.sales
),
product_years AS (
    SELECT 
        p.product_id,
        p.product_name,
        COUNT(DISTINCT EXTRACT(YEAR FROM s.sale_date)) AS years_with_sales
    FROM assignment.products p
    JOIN assignment.sales s ON p.product_id = s.product_id
    GROUP BY p.product_id, p.product_name
)
SELECT py.product_id, py.product_name
FROM product_years py
JOIN (SELECT COUNT(*) AS total_years FROM years) y ON py.years_with_sales = y.total_years;

-- 101. Update the products table to assign a price_category as Expensive (price > 1000), Moderate (price between 500 and 1000), or Affordable (price < 500) using CASE WHEN
ALTER TABLE assignment.products ADD COLUMN IF NOT EXISTS price_category VARCHAR(20);

UPDATE assignment.products
SET price_category = 
    CASE 
        WHEN price > 1000 THEN 'Expensive'
        WHEN price BETWEEN 500 AND 1000 THEN 'Moderate'
        WHEN price < 500 THEN 'Affordable'
        ELSE 'Unknown'
    END;

-- 102. Update the customers table to assign a customer_level based on total spending as VIP (>20000), Regular (10000–20000), or New (<10000) using CASE WHEN
-- First, create a temporary table or use a CTE; here we assume we add the column
ALTER TABLE assignment.customers ADD COLUMN IF NOT EXISTS customer_level VARCHAR(20);

WITH customer_spend AS (
    SELECT 
        customer_id,
        SUM(total_amount) AS total_spent
    FROM assignment.sales
    GROUP BY customer_id
)
UPDATE assignment.customers c
SET customer_level = 
    CASE 
        WHEN cs.total_spent > 20000 THEN 'VIP'
        WHEN cs.total_spent BETWEEN 10000 AND 20000 THEN 'Regular'
        ELSE 'New'
    END
FROM customer_spend cs
WHERE c.customer_id = cs.customer_id;

-- 103. Update the products table to assign a stock_status as Low Stock or Sufficient Stock based on stock_quantity using CASE WHEN
ALTER TABLE assignment.products ADD COLUMN IF NOT EXISTS stock_status VARCHAR(20);

UPDATE assignment.products
SET stock_status = 
    CASE 
        WHEN stock_quantity < 10 THEN 'Low Stock'   -- adjust threshold as needed
        ELSE 'Sufficient Stock'
    END;

-- 104. Display each customer’s registration year from the registration_date
SELECT 
    customer_id,
    first_name,
    last_name,
    EXTRACT(YEAR FROM registration_date) AS registration_year
FROM assignment.customers;

-- 105. Count how many customers registered in each year
SELECT 
    EXTRACT(YEAR FROM registration_date) AS registration_year,
    COUNT(*) AS customer_count
FROM assignment.customers
GROUP BY registration_year
ORDER BY registration_year;

-- 106. Find the total sales amount for each month
SELECT 
    DATE_TRUNC('month', sale_date) AS sale_month,
    SUM(total_amount) AS monthly_revenue
FROM assignment.sales
GROUP BY sale_month
ORDER BY sale_month;

-- 107. Show all sales made in the year 2023
SELECT *
FROM assignment.sales
WHERE EXTRACT(YEAR FROM sale_date) = 2023
ORDER BY sale_date;

-- 108. Find the total sales amount for each year
SELECT 
    EXTRACT(YEAR FROM sale_date) AS sale_year,
    SUM(total_amount) AS yearly_revenue
FROM assignment.sales
GROUP BY sale_year
ORDER BY sale_year;

-- 109. Calculate the number of days each customer has been registered (from registration_date to current date)
SELECT 
    customer_id,
    first_name,
    last_name,
    registration_date,
    CURRENT_DATE - registration_date AS days_registered
FROM assignment.customers;

-- 110. Display each sale and extract the year and month from the sale date
SELECT 
    sale_id,
    customer_id,
    product_id,
    sale_date,
    EXTRACT(YEAR FROM sale_date) AS sale_year,
    TO_CHAR(sale_date, 'Month') AS sale_month
FROM assignment.sales;

-- 111. Display each customer’s email and replace null values with 'No Email Provided' using COALESCE
SELECT 
    customer_id,
    first_name,
    last_name,
    COALESCE(email, 'No Email Provided') AS email
FROM assignment.customers;

-- 112. Find customers who do not have an email address
SELECT *
FROM assignment.customers
WHERE email IS NULL OR email = '';

-- 113. Find products that have never been sold using a subquery
SELECT *
FROM assignment.products p
WHERE p.product_id NOT IN (SELECT DISTINCT product_id FROM assignment.sales);

-- 114. Find customers who have not made any purchases using a subquery
SELECT *
FROM assignment.customers c
WHERE c.customer_id NOT IN (SELECT DISTINCT customer_id FROM assignment.sales);

-- 115. Update the products table to assign a price_category (Premium, Standard, Budget) based on price using CASE WHEN
ALTER TABLE assignment.products ADD COLUMN IF NOT EXISTS price_category VARCHAR(20);

UPDATE assignment.products
SET price_category = 
    CASE 
        WHEN price > 1000 THEN 'Premium'
        WHEN price BETWEEN 300 AND 1000 THEN 'Standard'
        ELSE 'Budget'
    END;

-- 116. Create a PostgreSQL function/procedure that takes a minimum revenue as input and returns all products whose total sales exceed that value
CREATE OR REPLACE FUNCTION get_high_revenue_products(min_revenue NUMERIC)
RETURNS TABLE (
    product_id INT,
    product_name VARCHAR,
    total_sales NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.product_id,
        p.product_name,
        SUM(s.total_amount) AS total_sales
    FROM assignment.sales s
    JOIN assignment.products p ON s.product_id = p.product_id
    GROUP BY p.product_id, p.product_name
    HAVING SUM(s.total_amount) > min_revenue
    ORDER BY total_sales DESC;
END;
$$ LANGUAGE plpgsql;

-- 117. Create a PostgreSQL function/procedure that takes a customer_id as input and returns the total amount spent by that customer
CREATE OR REPLACE FUNCTION get_customer_total_spent(cust_id_input INT)
RETURNS NUMERIC AS $$
DECLARE
    total NUMERIC;
BEGIN
    SELECT COALESCE(SUM(total_amount), 0)
    INTO total
    FROM assignment.sales
    WHERE customer_id = cust_id_input;
    
    RETURN total;
END;
$$ LANGUAGE plpgsql;

-- 118. Create a PostgreSQL function/procedure that takes a start_date and end_date as input and returns the number of orders made within that date range
CREATE OR REPLACE FUNCTION count_orders_in_period(start_date DATE, end_date DATE)
RETURNS INT AS $$
DECLARE
    order_count INT;
BEGIN
    SELECT COUNT(*)
    INTO order_count
    FROM assignment.sales
    WHERE sale_date BETWEEN start_date AND end_date;
    
    RETURN order_count;
END;
$$ LANGUAGE plpgsql;

-- 119. Create a PostgreSQL stored procedure that inserts a new record into the sales table 
CREATE OR REPLACE PROCEDURE insert_new_sale(
    p_sale_id INT,
    p_customer_id INT,
    p_product_id INT,
    p_quantity_sold INT,
    p_sale_date DATE,
    p_total_amount NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO assignment.sales (sale_id, customer_id, product_id, quantity_sold, sale_date, total_amount)
    VALUES (p_sale_id, p_customer_id, p_product_id, p_quantity_sold, p_sale_date, p_total_amount);
    
    COMMIT;
END;
$$;

-- 120. Create an index on the product_id column in the sales table to improve join performance
CREATE INDEX IF NOT EXISTS idx_sales_product_id ON assignment.sales(product_id);

-- 121. Create an index on the registration_date column in the customers table to improve filtering by date
CREATE INDEX IF NOT EXISTS idx_customers_registration_date ON assignment.customers(registration_date);

-- 122. Write a transaction that inserts a new sale using sale_id, customer_id, product_id, quantity_sold, sale_date, and total_amount, then updates the corresponding product stock_quantity, ensuring both operations succeed or fail together
BEGIN;

INSERT INTO assignment.sales (sale_id, customer_id, product_id, quantity_sold, sale_date, total_amount)
VALUES (1001, 42, 15, 3, CURRENT_DATE, 299.97);

UPDATE assignment.products 
SET stock_quantity = stock_quantity - 3
WHERE product_id = 15;

COMMIT;  -- or ROLLBACK on error


-- 123. Write a transaction that updates a customer’s email and rolls back the change if the email is invalid
BEGIN;

UPDATE assignment.customers 
SET email = 'newemail@example.com'
WHERE customer_id = 5;


-- 124. Create a view that shows total revenue per product
CREATE OR REPLACE VIEW product_revenue AS
SELECT 
    p.product_id,
    p.product_name,
    COALESCE(SUM(s.total_amount), 0) AS total_revenue
FROM assignment.products p
LEFT JOIN assignment.sales s ON p.product_id = s.product_id
GROUP BY p.product_id, p.product_name;

-- 125. Create a view that shows each customer and their total spending
CREATE OR REPLACE VIEW customer_spending AS
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COALESCE(SUM(s.total_amount), 0) AS total_spent
FROM assignment.customers c
LEFT JOIN assignment.sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;


-- 126. Use UNION to combine a list of all customer first names and product names into a single column
SELECT first_name AS name FROM assignment.customers
UNION
SELECT product_name AS name FROM assignment.products
ORDER BY name;

-- 127. Use INTERSECT to find values that appear in both a list of customer IDs and a list of customer IDs who made purchases
SELECT customer_id FROM assignment.customers
INTERSECT
SELECT DISTINCT customer_id FROM assignment.sales;

-- 128. Perform an anti-join to find products that have never been sold using LEFT JOIN
SELECT p.*
FROM assignment.products p
LEFT JOIN assignment.sales s ON p.product_id = s.product_id
WHERE s.product_id IS NULL;

-- 129. Use NOT EXISTS to find customers who have not made any purchases
SELECT c.*
FROM assignment.customers c
WHERE NOT EXISTS (
    SELECT 1 
    FROM assignment.sales s 
    WHERE s.customer_id = c.customer_id
);

-- 130. Cast the price column to an integer and display it alongside the original price
SELECT 
    price,
    price::INTEGER AS price_int
FROM assignment.products;

-- 131. Convert registration_date to text format and display it in 'YYYY-MM' format
SELECT 
    customer_id,
    TO_CHAR(registration_date, 'YYYY-MM') AS registration_month
FROM assignment.customers;

-- 132. The following query returns an error due to improper GROUP BY usage. Identify and fix the issue
-- SELECT product_id, product_name, SUM(total_amount) FROM sales GROUP BY product_id;
SELECT 
    s.product_id,
    p.product_name,
    SUM(s.total_amount) AS total_revenue
FROM assignment.sales s
JOIN assignment.products p ON s.product_id = p.product_id
GROUP BY s.product_id, p.product_name;

-- 133. The following query incorrectly filters aggregated results using WHERE. Identify and correct it
-- SELECT product_id, SUM(total_amount) FROM sales WHERE SUM(total_amount) > 1000 GROUP BY product_id;
SELECT 
    product_id,
    SUM(total_amount) AS total_revenue
FROM assignment.sales
GROUP BY product_id
HAVING SUM(total_amount) > 1000;

-- 134. The following query returns incorrect results because it uses the wrong join condition. Identify and fix it
-- SELECT *
-- FROM assignment.sales s
-- JOIN assignment.products p
--   ON s.customer_id = p.product_id;
SELECT *
FROM assignment.sales s
JOIN assignment.products p ON s.product_id = p.product_id;

-- 135. Replace NULL email values with 'No Email Provided' using COALESCE if any
SELECT 
    customer_id,
    first_name,
    last_name,
    COALESCE(email, 'No Email Provided') AS email
FROM assignment.customers;

-- 136. Trim any leading or trailing spaces from customer first names if any
UPDATE assignment.customers
SET first_name = TRIM(first_name);

-- 137. Convert all customer emails to lowercase if any
UPDATE assignment.customers
SET email = LOWER(email)
WHERE email IS NOT NULL;

-- 138. Replace empty strings in phone numbers with NULL if any
UPDATE assignment.customers
SET phone_number = NULL
WHERE phone_number = '';

-- 139. Extract the year from registration_date and handle any NULL dates gracefully if any
SELECT 
    customer_id,
    COALESCE(EXTRACT(YEAR FROM registration_date)::TEXT, 'No Date') AS registration_year
FROM assignment.customers;
