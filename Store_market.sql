used portfolio.sales

SELECT * FROM portfolio.sales;
----

SELECT 
gender,
count(cust_id) num_customer
FROM portfolio.sales
group by gender
---

SELECT 
gender, age,
count(cust_id) num_customer
FROM portfolio.sales
group by gender, age

----

SELECT
	Region,
	count(order_id) as purchase_count,
	round(sum(total),2) as sum_purchases
FROM portfolio.sales
GROUP BY  Region
Order by sum_purchases desc

---the most purchage in categories

SELECT
	category,
    count(order_id) as purchase_count,
	round(sum(total),2) as sum_purchases
FROM portfolio.sales
GROUP BY  category
Order by sum_purchases desc

--- parcentage purchase per region
SELECT  Region,category, SUM(price) /(select sum(total) FROM portfolio.sales)*100
FROM portfolio.sales
group by Region,category


--- Gender parcentage purchase per year
SELECT  gender, SUM(price) /(select sum(total) FROM portfolio.sales)*100
FROM portfolio.sales
group by gender
order by SUM(price) /(select sum(total) FROM portfolio.sales)*100 desc

---
SELECT
 category, gender,
 Count(order_id) as purchages_count,
 Round(Sum(total),2) as total_sale
FROM portfolio.sales
where status ="complete"
GROUP BY category, gender


-- purchage category per avg age

SELECT 
status,
SUM(price) /(select sum(total) FROM portfolio.sales)*100
FROM portfolio.sales
group by  status
order by SUM(price) /(select sum(total) FROM portfolio.sales)*100 desc

--- the highest sale per category in the year

SELECT extract(Year from order_date) as Year,
	category,
    Max(total) as highest_sales
FROM portfolio.sales
Group by order_date, category
order by highest_sales desc
--- the older=st customer 
-- stdv on price, 
SELECT Region,
STDEV(total) as total_stdv
FROM portfolio.sales
group by Region
