/* Adidas Data analytics project */

-- will begin by viewing the table
SELECT *
FROM adidas_store
-- The Quiry below will help us to find if there's any miss values in the dataset
SELECT *
FROM adidas_store
Where Retailer_ID IS NULL
/* Seeing the table does not hate missing values*/

-- Now i will go ahead and use count and sum for overview information about the table
SELECT  count(DISTINCT Retailer_ID) as num_retailers,
		    count(DISTINCT Region) as num_regions, 
        count(DISTINCT State) as num_states, 
        count(DISTINCT City) as num_cities, 
        count(DISTINCT Product) as num_Product, 
        Count(DISTINCT Sales_Method) as num_sale_method,
        SUM(CAST(Units_Sold AS INT)) as total_unitsold,
        SUM(CAST(Total_Sales AS INT)) as total_sale,
        SUM(CAST(Operating_Profit AS FLOAT)) as total_profit
FROM adidas_store

-- what is the total sale per salses methods
SELECT Sales_Method, 
	SUM(CAST(Total_sales AS INT)) as total_sales,
    SUM(Operating_Profit)*100 /(SELECT SUM(Operating_Profit) from adidas_store) as profit_ratio
FROM adidas_store
GROUP BY Sales_Method

--- Calculate the total sales, and profit ratio per gender
with cte as(
SELECT *,
	case WHEN Product LIKE 'men%' THEN 'Male'
     WHEN Product LIKE 'wo%' THEN 'Female'
    else 'null' END AS Gender
FROM adidas_store)

SELECT Gender,
 COUNT(1) as total_gender,
  SUM(CAST(Total_sales AS INT)) as total_sales,
  SUM(Operating_Profit)*100 /(SELECT SUM(Operating_Profit) from adidas_store) as profit_ratio
FROM cte
GROUP BY Gender

-- what is the total sale per salses methods
SELECT Year(Invoice_Date) as Year, 
	SUM(Total_sales) as total_sales
FROM adidas_store
GROUP BY  year(Invoice_Date)

-- what is the total sale per Region
SELECT Region, 
	SUM(Total_sales) as total_sales,
    SUM(Operating_Profit)*100 /(SELECT SUM(Operating_Profit) from adidas_store) as profit_ratio
FROM adidas_store
GROUP BY Region

-- what is the total sale per month
SELECT month(Invoice_Date) as Month, 
	SUM(Total_sales) as total_sales,
    SUM(Operating_Profit) as total_profit,
    SUM(Operating_Profit)*100 /(SELECT SUM(Operating_Profit) from adidas_store) as profit_ratio
FROM adidas_store
GROUP BY  month(Invoice_Date)
order by Month asc

-- what is the total sale per retailer
SELECT Retailer,
	SUM(Total_sales) as total_sales,
    SUM(Operating_Profit) as total_profit
FROM adidas_store
GROUP BY  Retailer

SELECT Sales_Method, year(Invoice_Date) as year, 
count(*) as total
FROM adidas_store
WHERE year(Invoice_Date) = 2021
Group by year(Invoice_Date),Sales_Method

/*--- write a query to identify the top 2 product sale each retailer 
the result should return the retailer column, product column and total spend*/

WITH cte as(
SELECT 
  Retailer,
  Product,
  SUM(Total_Sales) as total_spend
 FROM adidas_store
 GROUP BY 
  Retailer,
  Product
),
total_spend as(
  SELECT 
 	 Retailer,
  	 Product,
  	 total_spend,
     dense_rank() over(PARTITION BY Retailer ORDER BY total_spend DESC) AS product_rank
  FROM cte
)
SELECT 
 Retailer,
 Product,
 total_spend
FROM total_spend
WHERE product_rank <= 2

-- calculate YOY sales 

WITH monthly_metrics AS (
 SELECT 
   year(Invoice_Date) as year,
   Month(Invoice_Date) as month,
   SUM(Total_Sales) as revenue
 FROM adidas_store 
 GROUP BY year(Invoice_Date),Month(Invoice_Date) 
)
SELECT 
  year, month, revenue,
  LAG(revenue) OVER (ORDER BY year, month) as Revenue_previous_month,
  revenue - LAG(revenue) OVER (ORDER BY year, month) as Month_to_month_difference
FROM monthly_metrics
ORDER BY 1,2;
