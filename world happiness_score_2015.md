This project was complited in SQLite and Python

Python notebook [Click here](https://github.com/JoshuaKab/Python-and-R/blob/main/world%20happiness%20score.ipynb)


```python
-- Overview of the entire dataset
SELECT * FROM world_happiness_2015

```
![image](https://github.com/JoshuaKab/SQL-Queries/assets/135429439/eeeb7673-c371-4018-85a6-6d81fb8f5d3b)


```python
--what is the best countries to raise a family

with family_rate as (SELECT region, Country,
 family,
RANK() OVER (ORDER BY family desc) as ranking
from world_happiness_2015)

SELECT Region, country, ranking
FROM family_rate
WHERE ranking = 1

```
![image](https://github.com/JoshuaKab/SQL-Queries/assets/135429439/4e601af8-d9b4-4882-9f3d-5734314bcd4c)

```python
with family_rate as (SELECT region, Country,
 family,
DENSE_RANK() OVER (PARTITION BY region ORDER BY family desc) as ranking
from world_happiness_2015)

SELECT Region, country, ranking
FROM family_rate
WHERE ranking <= 3
```
![image](https://github.com/JoshuaKab/SQL-Queries/assets/135429439/4dfdeb33-5f6d-4cc1-8823-24084a6960d2)

```python
-- Generosity per region and country with NTILE function will help to divide quantile
SELECT 
  Region, 
  Country, 
 Generosity, 
  NTILE(4) OVER (ORDER BY Happiness_Score DESC) AS Quartile
FROM world_happiness_2015
```
![image](https://github.com/JoshuaKab/SQL-Queries/assets/135429439/44734ef9-ee61-489a-87da-495b3d247a64)


```python
```
