	----- The world population and life expectation--- 
SELECT co.Region, co.Name, co.GovernmentForm,
AVG(c.Population) As Population,
Max(co.LifeExpectancy) As Life_expectancy
FROM world.country AS co  
Join world.city AS c
 ON co.Code = c.CountryCode
 Group by co.Region, co.GovernmentForm,co.Name
 Order by Life_expectancy DESC
 
--- continent with more population

SELECT Continent,
sum(Population) as total_population
FROM world.country
Group by Continent
Order by Total_population desc

---- continent with highest life expectancy
SELECT Continent,
Max(LifeExpectancy) AS LifeExpectancy
FROM world.country
WHERE LifeExpectancy IS NOT NULL
Group by Continent
Order by LifeExpectancy DESC

---- life expectancy per county

SELECT 
	co.Region,
	co.Population,
	co.GovernmentForm,
    co.LifeExpectancy,
CASE
	WHEN co.LifeExpectancy  > 80 Then 'Very long life'
    WHEN co.LifeExpectancy between 60 AND 80 Then 'long life'
    WHEN co.LifeExpectancy between 50 AND 59.9 Then 'Average life duration'
    ELSE 'Short life' 
    END AS Life_duration
FROM world.country as co
JOIN world.city as c
ON co.Code = c.CountryCode
WHERE co.LifeExpectancy IS NOT NULL


SELECT
	Name, LifeExpectancy
FROM world.country
WHERE LifeExpectancy > 80


Select *
From world.country
Where Name = "South Africa" 

SELECT Name, IndepYear
FROM world.country
Where IndepYear >= 1960
