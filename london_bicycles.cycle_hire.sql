
---SQL QUERIES--
---LONDON BICYCLE CYCLE BIKE

---Over view of the dataset

SELECT * FROM `bigquery-public-data.london_bicycles.cycle_hire` 

---Q1 number of trips with bike model and trips durations

SELECT  bike_model,
COUNT(bike_id) AS total_bike,
SUM(duration) AS duration

FROM `bigquery-public-data.london_bicycles.cycle_hire` 
WHERE bike_model IS NOT NULL
GROUP BY bike_model

---Q2 station with more trips and trip duration

SELECT
 start_station_name,
  COUNT(bike_id) AS total_bike,
 SUM(duration) AS duration

FROM `bigquery-public-data.london_bicycles.cycle_hire` 
WHERE duration IS NOT NULL
GROUP BY rental_id, start_station_name
ORDER BY duration desc, total_bike desc

--- Q3 Number of trips trips taken between start station and end station

SELECT bike_model,
CONCAT(start_station_name, 'TO', end_station_name) as roads,
COUNT(*) AS num_trips,
ROUND(AVG(CAST(duration as int64)/60),2) AS duration
FROM `bigquery-public-data.london_bicycles.cycle_hire` 
WHERE bike_model IS NOT NULL
GROUP BY bike_model, start_station_name, end_station_name
ORDER BY num_trips DESC, bike_model DESC

---Q4 Which year has the  most trips AND AVG DURATION
SELECT
EXTRACT(Year from start_date) AS Year,
COUNT(bike_id) AS num_bike, 
AVG(duration/60) AS avg_duration
FROM `bigquery-public-data.london_bicycles.cycle_hire` 
GROUP BY Year
ORDER BY num_bike DESC

---Q5 Which year has the  most trips AND Highest trip duration

SELECT
EXTRACT(Month from start_date) AS month,
COUNT(bike_id) AS num_bike, 
Max(duration/60) AS max_duration
FROM `bigquery-public-data.london_bicycles.cycle_hire` 
GROUP BY month
ORDER BY max_duration DESC

---Q6 Which year has the  most trips AND AVG DURATION

SELECT
EXTRACT(Hour  from start_date) AS hour,
COUNT(bike_id) AS num_bike, 
AVG(duration/60) AS avg_duration
FROM `bigquery-public-data.london_bicycles.cycle_hire` 
GROUP BY hour
ORDER BY num_bike DESC

