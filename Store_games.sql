
---console_date
--Retrieve all the data from console date table to examine it
SELECT *
FROM portfolio.console_dates


--- Console_games
---retrieve all the data from console game table to examine it
SELECT *
FROM portfolio.console_games

---- Calculate what % of Global Sales were made in North America
with cte as
(SELECT Name,
	ROUND(SUM(NA_Sales),2) AS TNA_sale,
    ROUND(SUM(EU_Sales),2)AS TEU_sale,
    ROUND(SUM(JP_Sales),2) AS TJP_sale,
    ROUND(SUM(Other_Sales),2) AS TO_sale
FROM portfolio.console_games
group by Name)
select Name,
	round(sum(TNA_sale + TEU_sale + TJP_sale + TO_sale),2) as total_sale
from cte
group by Name
SELECT
AVG(p.NA_Sale / c.total_sale)*100 as NA_sales
FROM portfolio.console_games as p
join cte as on p.Name = Name.c

----Extract a view of the console gmae title orderer by platform name in
---ASsceding order and year of release in descending order

SELECT *
FROM portfolio.console_games
Order by Year DESC, platform ASC








