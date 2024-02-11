
--select superstore database

use superstore_analysis
---overview customer
SELECT *
FROM customers
---overvieu sales dataset
SELECT *
FROM sales

 ---Overview of the total aggretion in the dashboard

SELECT
COUNT(Distinct cu.City) as Num_cities,
COUNT(Distinct cu.County) as Num_County,
COUNT(Distinct cu.cust_id) as Num_customers,
COUNT(Distinct sa.item_id) as Total_item,
SUM(CAST(sa.qty_ordered AS INT)) as Num_order,
ROUND(SUM(sa.qty_ordered * sa.price - sa.discount_amount),2) as total_sale,
ROUND(AVG(cu.Discount_Percent),2) as discount,
ROUND(AVG(sa.price),2) as average_price
FROM sales as sa
JOIN customers cu 
ON cu.order_id = sa.order_id
WHERE cu.Region IS NOT NULL
--


---Overview of the customer dataset
SELECT
COUNT(DISTINCT order_id) as total_order_id,
COUNT(DISTINCT category) as total_category_products,
COUNT(DISTINCT payment_method) as total_payment_method,
COUNT(DISTINCT bi_st) as total_bi,
SUM(CAST(qty_ordered AS INT)) as total_qty_ordered,
SUM(qty_ordered * price- discount_amount) as total_sale,
AVG(discount_amount) as avg_discount
FROM sales

----custmer data transformation
--- DROP Unnecessary columns
ALTER TABLE customers
DROP COLUMN ref_num, E_Mail,SSN, 

UPDATE customers
SET Gender =
 CASE WHEN Gender = 'F' THEN 'Female'
		ELSE 'Male' END 
---data exploratory and analysis
--- number of customers per region
SELECT Region, 
	COUNT(distinct cust_id) as total_customers,
	COUNT(distinct cust_id)*100 /(SELECT COUNT(Distinct cust_id) from customers) as customer_ratio
FROM customers
Group by Region

UPDATE customers SET month = CONVERT(datetime, month)
--- number of customers per Gender
SELECT co.Gender, 
	COUNT(DISTINCT cust_id) as total_customers,
	COUNT(DISTINCT cust_id)*100 /(SELECT COUNT(DISTINCT cust_id) from customers) as customer_rate,
	AVG(sa.price) as Avg_price,
	SUM(CAST(sa.total AS INT)) as total_sale
FROM customers as co
JOIN sales as sa ON co.order_id = sa.order_id
GROUP BY co.Gender

--- number of customers per Region
SELECT sa.category, 
	COUNT(DISTINCT cust_id) as total_customers,
	COUNT(DISTINCT cust_id)*100 /(SELECT COUNT(DISTINCT cust_id) from customers) as customer_rate,
	AVG(sa.price) as Avg_price,
	SUM(CAST(sa.total AS INT)) as total_sale
FROM customers as co
JOIN sales as sa ON co.order_id = sa.order_id
GROUP BY sa.category

---average price on the category products

SELECT sa.category, AVG(sa.price) as Average_price
FROM customers as cu
JOIN sales as sa ON cu.order_id = sa.order_id
GROUP BY sa.category
ORDER BY Average_price DESC
/* with query about women's Fashion are 58% high of the price average compare to Man's Fashion this has answer the above 
why Man's Fashion total sales are below than Woman's Fasion despite the fact that man cust id are more than female */


---  what's customers ratio per sale product Category
SELECT sa.category, 
	COUNT(DISTINCT cust_id) as total_customers,
	AVG(sa.total) as avg_sale,
	COUNT(cust_id)*100 /(SELECT COUNT(cust_id) from customers) as customer_ratio,
	ROUND(SUM(sa.qty_ordered * sa.price - sa.discount_amount),2) AS sales_ratio
FROM customers as co
JOIN sales as sa ON co.order_id = sa.order_id
GROUP BY sa.category
ORDER BY customer_ratio DESC

---season sale ratio
select*
from customers

--- Age group ratio 
SELECT 
  CASE
	  WHEN age BETWEEN 18 AND 25 THEN '18-25'
	  WHEN age BETWEEN 26 AND 30 THEN '26-30'
	  WHEN age BETWEEN 31 AND 35 THEN '31-35'
	  WHEN age BETWEEN 36 AND 40 THEN '36-40'
	  WHEN age BETWEEN 41 AND 45 THEN '41-45'
	  WHEN age BETWEEN 46 AND 50 THEN '18-50'
	  WHEN age BETWEEN 51 AND 55 THEN '51-55'
	  WHEN age BETWEEN 56 AND 60 THEN '56-60'
	  WHEN age BETWEEN 61 AND 65 THEN '61-65'
	  WHEN age BETWEEN 66 AND 70 THEN '66-70'	
	              ELSE '75+' END AS Age_group,
	count(*) as Total_Count
FROM customers 
GROUP BY CASE 
          WHEN age BETWEEN 18 AND 25 THEN '18-25'
	  WHEN age BETWEEN 26 AND 30 THEN '26-30'
	  WHEN age BETWEEN 31 AND 35 THEN '31-35'
	  WHEN age BETWEEN 36 AND 40 THEN '36-40'
	  WHEN age BETWEEN 41 AND 45 THEN '41-45'
	  WHEN age BETWEEN 46 AND 50 THEN '18-50'
	  WHEN age BETWEEN 51 AND 55 THEN '51-55'
	  WHEN age BETWEEN 56 AND 60 THEN '56-60'
	  WHEN age BETWEEN 61 AND 65 THEN '61-65'
	  WHEN age BETWEEN 66 AND 70 THEN '66-70'	
	              ELSE '75+' END
ORDER BY Total_Count DESC

---10 Most active customer
SELECT top 10 cu.full_name,cu.Gender,
   AVG(cu.Discount_Percent * 100) AS Avg_discount,
   SUM(sa.total) as total_sales
FROM customers as cu
JOIN sales as sa
ON cu.order_id =sa.order_id
GROUP BY cu.full_name,cu.Gender
ORDER BY total_sales DESC

---Top 10 oldest customers, counts by how many month

WITH CTE_1 AS (SELECT 
	cu.full_name as name,
	cu.Gender as gender,
	sa.category as products,
	count(*) as frequance,
    MIN(CAST(cu.Customer_Since AS DATE)) AS customer_since,
	MAX(CAST(cu.Customer_Since AS DATE)) AS last_date_update,
    AVG(cu.Discount_Percent) as Avg_discount,
    ROUND(SUM(sa.total),2) as total_spends
FROM customers as cu
JOIN sales as sa
ON cu.order_id =sa.order_id
GROUP BY cu.full_name, cu.Gender,sa.category)
SELECT Top 10 name, total_spends,frequance,
	DATEDIFF(Year,customer_since, last_date_update) as num_years
FROM CTE_1
ORDER BY num_years DESC


--- The Top 10. find out which customers is more active 

SELECT full_name,
count(*) as customers
FROM customers
GROUP BY full_name
HAVING count(full_name) > 100
ORDER BY customers DESC

/*Gonzalez, Joel customers has more than 2524 activities in this project 
  let's find out more about this customer */

SELECT
 cu.Gender, sa.category,
 COUNT(*) AS freq,
 MIN(cu.Customer_Since) as start_date,
 MAX(cu.Customer_Since) as latest_update,
 AVG(sa.discount_amount) as AVG_discount,
 ROUND(SUM(sa.total),2) as total_spend
FROM customers as cu
LEFT JOIN sales as sa ON sa.order_id = cu.order_id
WHERE cu.full_name = 'Gonzalez, Joel'
GROUP BY cu.Gender, sa.category


SELECT Customer_Since,full_name, City, Region
FROM customers
WHERE full_name ='Carrara, Wm'



				--MySQL DATEDIFF FUNCTION

--Q1. -- Top 10 oldest customers

WITH CTE_1 AS (SELECT cu.full_name as name,
		cu.Gender as gender,
		MIN(CAST(cu.Customer_Since AS DATE)) as Customer_since,
		MAX(CAST(cu.Customer_Since AS DATE)) as last_date_update,
		SUM(sa.total) as total_spend
FROM customers as cu
JOIN sales as sa
ON cu.order_id = sa.order_id
GROUP BY cu.full_name,cu.Gender)
SELECT Top 10 name, gender,
		DATEDIFF(Year, Customer_since, last_date_update) as num_days
FROM CTE_1
ORDER BY num_days DESC

--Q2. filter the first top customer on the list

SELECT *
FROM customers
WHERE full_name = 'Behrends, Mariam'
----------
SELECT DISTINCT Customer_Since
FROM customers
ORDER BY Customer_Since ASC


				--MySQL Most profitable product

SELECT 
category,
Count(*) as count_product,
ROUND(AVG(price),2) as Avg_Price,
ROUND(SUM(discount_amount),2) as total_discount,
ROUND(SUM(total),2) as total_sale
FROM sales
Group by category
ORDER BY total_sale DESC

--- Total sale per  payment method

SELECT 
sa.payment_method,
Count(*) as count_product,
ROUND(AVG(sa.price),2) as Avg_Price,
ROUND(SUM(sa.discount_amount),2) as total_discount,
ROUND(SUM(sa.total - sa.discount_amount),2) as total_sale
FROM sales as sa
JOIN customers as cu ON sa.order_id = cu.order_id
Group by sa.payment_method
ORDER BY total_sale DESC

--- Most active gender per category sale

SELECT 
cu. Gender,
Count(*) as count_product,
ROUND(AVG(sa.price),2) as Avg_Price,
ROUND(SUM(sa.discount_amount),2) as total_discount,
ROUND(SUM(sa.total),2) as total_sale
FROM sales as sa
JOIN customers as cu ON sa.order_id = cu.order_id
Group by cu. Gender
ORDER BY total_sale DESC

--customer trend in 2020
SELECT
	cust.cust_id, 
	cust.full_name,
	sa.category,
	sa.qty_ordered *
		sa.price - sa.discount_amount as sales
	FROM customers AS cust
JOIN sales AS sa ON cust.order_id = sa.order_id 
WHERE cust.year = '2020'
ORDER BY sales DESC

 
---- average sale per customer vs categories
SELECT
	cust.cust_id, 
	cust.full_name,
	sa.category,
	COUNT(cust.cust_id) AS Customer_activities,
	ROUND(AVG(sa.qty_ordered * sa.price - sa.discount_amount),2) AS avg_sales
	FROM customers AS cust
JOIN sales AS sa ON cust.order_id = sa.order_id 
GROUP BY cust.cust_id, 
	     cust.full_name,
	     sa.category
HAVING COUNT(cust.cust_id) > 500
ORDER BY Customer_activities DESC

--Q what's total sale per month

SELECT Month(cu.month) as month_sale,
Count(cu.cust_id) as total_customers,
ROUND(SUM(sa.qty_ordered * sa.price - sa.discount_amount),2) AS sales
FROM customers AS cu
JOIN sales AS sa ON cu.order_id = sa.order_id 
GROUP BY month
ORDER BY month_sale asc