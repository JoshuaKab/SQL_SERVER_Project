-- The dateset below was downloaded from bigquery 
-- new_york_citibike.citibike_trips


SELECT
  usertype,
  CONCAT(start_station_name, "To", end_station_name) AS route,
  count(*) as num_trips,
  ROUND(AVG(Cast(tripduration as int64)/60),2) AS duration
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`

  group by start_station_name, end_station_name, usertype
  ORDER BY num_trips desc
  limit 10

  ------
SELECT
  usertype,
  EXTRACT(year from starttime) as year,
  count(*) as num_trips
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`

where starttime is not null
group by usertype, year
order by num_trips desc



------- the number of route during the pass years
SELECT
  CONCAT(start_station_name, "to", end_station_name) As num_route,
  EXTRACT(year from starttime) as year,
  count(*) as num_trips
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`

where starttime is not null
group by num_route, year
order by num_trips desc


------ the longest trip duration from the usertype

SELECT
usertype,
ROUND(AVG(Cast(tripduration as int64)/60),2) as duration

FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`
  WHERE tripduration IS NOT NULL
  group by usertype
  order by duration
 
 