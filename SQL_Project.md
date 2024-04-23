Project name: Data analyst for US Health Insurance 

About Dataset

Context

The venerable insurance industry is no stranger to data driven decision making. Yet in today's rapidly transforming digital landscape, Insurance is struggling to adapt and benefit from new technologies compared to other industries, even within the BFSI sphere (compared to the Banking sector for example.) Extremely complex underwriting rule-sets that are radically different in different product lines, many non-KYC environments with a lack of centralized customer information base, complex relationship with consumers in traditional risk underwriting where sometimes customer centricity runs reverse to business profit, inertia of regulatory compliance - are some of the unique challenges faced by Insurance Business.

Content

This dataset contains 1338 rows of insured data, where the Insurance charges are given against the following attributes of the insured: Age, Sex, BMI, Number of Children, Smoker and Region. There are no missing or undefined values in the dataset.

Overview with excel sheet


![image](https://github.com/JoshuaKab/SQL-Queries/assets/135429439/a5e46920-0792-4ed0-a948-a229d5a0ce71)


```python
1. What is the age distribution of customers

SELECT age,
COUNT(age) AS distribution
FROM insurance
group By age
HAVING COUNT(age) > 25


```
Output
![image](https://github.com/JoshuaKab/SQL-Queries/assets/135429439/c26cf0d5-a881-4a3f-b665-abf2e5c1f88a)

The age distribution shows that most of the customers are between the ages of 18 and 40. 
The youngest is 18, and the oldest is 64.
Output

```python
2. Write a query to obtain the top 4 customers highly charge per region and arrange by descending order. 

with CTE_1 AS (SELECT
region, 
sex,
smoker,
charges,
DENSE_RANK() OVER (PARTITION BY region ORDER BY charges DESC) as ranking
FROM insurance)

SELECT region, 
sex,
smoker,
charges,
ranking
FROM CTE_1
WHERE ranking <=4
  

```
Output

![image](https://github.com/JoshuaKab/SQL-Queries/assets/135429439/0c379fcc-e1b3-408c-8fc0-da6a3891d3fc)


```python
3. What 's the body mass index distribution per gender

WITH Weight_Category AS (SELECT region, smoker, sex,
  CASE 
  WHEN bmi BETWEEN 0 and 18.5 THEN 'underweight'
  WHEN bmi BETWEEN 18.6 and 24.9 then 'Healthy Weight'
  WHEN bmi BETWEEN 25.0 and 29.9 then 'Over Weight'
  WHEN bmi BETWEEN 30 and 34.9 then 'Obese'
  ELSE 'Extremely obese' END as Weight_group
FROM insurance)

SELECT Weight_group, sex,
  COUNT(Weight_group) as total_count
FROM  Weight_Category
GROUP by Weight_group,sex

```

Output


![image](https://github.com/JoshuaKab/SQL-Queries/assets/135429439/0026ce39-be11-4c8e-b170-f21d27902dbb)


The weight distribution query showed that most people are obese, followed by overweight, and the fewest people in the weight group column are mostly women who are underweight.

```python
4. What's the total distribution of fees charges per gender distribution

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

Females who smoke pay more than non-smokers, with a difference of 12.7% from the total charge.

Males are the opposite; males who are smoking are charged less than non-smokers.

In total, males are paying 6.28% more than females. 

Most customers don't have children; follow those with only one child.


```python
5. What's children distribution per customers
 SELECT children,
 count(children) as total,
    (count(smoker) / (SELECT COUNT(smoker) FROM insurance) * 100) AS percentage
FROM insurance
GROUP by children
    

```
Output

![image](https://github.com/JoshuaKab/SQL-Queries/assets/135429439/d75d0d18-5529-4d5b-ab84-3828f843ca60)

  Most customers don't have children; follow those with only one child.

```python

6. What's the distribution per customers in smoking column
SELECT smoker,
count(smoker) as total,
    (count(smoker) / (SELECT COUNT(smoker) FROM insurance) * 100) AS percentage
FROM insurance
GROUP by smoker

```
Outpu

![image](https://github.com/JoshuaKab/SQL-Queries/assets/135429439/3c627f9c-0124-4285-87ce-b023fed0e1a5)

20.5% of customers smoke. 
 
79.5% of customers don't smork.

```python
7. Show the breakdown of payment charges per gender,  group by  region and round 2 decimal  in percentage 
  then add a column to show % difference between the two genders

with cte as (
 SELECT
 region, 
    sum(case when sex = 'male' THEN charges else 0 end) AS male_charge,
	sum(case when sex = 'female' THEN charges else 0 end) AS female_charge,
	SUM(charges) as total_charge
  FROM insurance
  GROUP by region),
  
 percentage as( SELECT
  region,
   round((male_charge / total_charge) * 100 , 2 ) as male_perc,
   round((female_charge / total_charge) * 100 , 2 ) as female_perc
  FROM cte)
  
  SELECT *,
  male_perc - female_perc as diff_perc
  FROM percentage
  

```
Output

![image](https://github.com/JoshuaKab/SQL-Queries/assets/135429439/6563b40c-9d01-4996-8148-2d8e1e462096)

The brakdown on the margin of genders in the southeast region shows a gap of 11.90%. 

followed by the southeast region with 8.96%. while nothwest -1.42% shows female total peyment is higher by 1.42%.

2.1 Data transformation

```python
2.1 create new Weight_group column in table
ALTER TABLE insurance
ADD bmi_group varchar(50);

2.2 update in weight group column
UPDATE insurance
SET bmi_group =  CASE 
  WHEN bmi BETWEEN 0 and 18.5 THEN 'underweight'
  WHEN bmi BETWEEN 18.6 and 24.9 then 'Healthy Weight'
  WHEN bmi BETWEEN 25.0 and 29.9 then 'Over Weight'
  WHEN bmi BETWEEN 30 and 34.9 then 'Obese'
  ELSE 'Extremely obese' END

2.3 rename column sex to gender 
ALTER TABLE insurance 
RENAME COLUMN sex TO gender;


```

2.4 Save the artwork for further analysis in Tableau dashboard

Tableasu Dashboard [link](https://public.tableau.com/app/profile/joshua.k.1176/viz/USinsurance_17134503455500/Dashboard1)

![Dashboard 1 (1)](https://github.com/JoshuaKab/SQL-Queries/assets/135429439/cf76470f-c285-424a-a434-c1ca956bd6ca)


CONCLUSION
--

