-- The dateset below was downloaded from bigquery 
-- chicago_taxi_trips.taxi_trips


SELECT
count(taxi_id) as number_of_taxis
FROM
  `bigquery-public-data.chicago_taxi_trips.taxi_trips`
where taxi_id IS NOT NULL
  
-----
SELECT
count(company) as number_of_taxis
FROM
  `bigquery-public-data.chicago_taxi_trips.taxi_trips`
where taxi_id IS NOT NULL
---------------


SELECT
company,
  count(taxi_id) number_of_taxis,
  sum(trip_seconds / 60)/24 as Trip_duration
FROM
  `bigquery-public-data.chicago_taxi_trips.taxi_trips`

  WHERE company IS NOT NULL 
  GROUP BY company
  order by number_of_taxis desc, trip_duration desc

  ----
  SELECT
payment_type,
  count(taxi_id) number_of_taxis,
  sum(trip_seconds / 60) as Trip_duration
FROM
  `bigquery-public-data.chicago_taxi_trips.taxi_trips`

  WHERE payment_type IS NOT NULL 
  GROUP BY payment_type
  order by number_of_taxis desc, trip_duration desc