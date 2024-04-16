Joshua Project
```python
1. what's the age disrbution per region and total number of children

SELECT region,
	AVG(age) AS Age_average,
    Sum(children) as number_children
FROM insurance
GROUP BY region
```
Output

![image](https://github.com/JoshuaKab/SQL-Queries/assets/135429439/7de5e066-1f08-40c3-a40a-0eb2988d0250)





```python
2. What 's the body mass distribution per region

WITH Weight_Category AS (SELECT region, smoker, sex,
  CASE 
  WHEN bmi BETWEEN 0 and 18.5 THEN 'underweight'
  WHEN bmi BETWEEN 18.6 and 24.9 then 'Healthy Weight'
  WHEN bmi BETWEEN 25.0 and 29.9 then 'Over Weight'
  WHEN bmi BETWEEN 30 and 34.9 then 'Obese'
  ELSE 'Extremely obese' END as Weight_group
FROM insurance)

SELECT Weight_group,
  COUNT(Weight_group) as total_count
FROM  Weight_Category
GROUP by Weight_group

```

Output


![image](https://github.com/JoshuaKab/SQL-Queries/assets/135429439/ed001522-7ea6-4b83-9365-efb3d385d3f2)

3. What's the total distribution charges per gender distribution

```python

 SELECT
 sex, smoker,
 SUM(Charges) AS total_qty, 
 COUNT(*) as Total_count,
 round((SUM(Charges) / (SELECT SUM(Charges) FROM insurance) * 100),2) AS percentage
 from insurance
 GROUP by sex, smoker

```

Output


![image](https://github.com/JoshuaKab/SQL-Queries/assets/135429439/4acdea6a-165c-4382-895c-881b1a7edcc9)

Female that smorks pay more than the none smokers with different of 12.7% from total charge

Males are the opposite, males that are smoking are less charge than the none smokers

In total males are paying 6.28% high the famales 


