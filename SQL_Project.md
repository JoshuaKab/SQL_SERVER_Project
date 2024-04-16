Joshua Project
```python
1. what's the age disrbution per region and total number of children

SELECT region,
	AVG(age) AS Age_average,
    Sum(children) as number_children
FROM insurance
group by region
```
Output

![image](https://github.com/JoshuaKab/SQL-Queries/assets/135429439/9a634951-d159-4f93-9328-877d95546588)




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

