SELECT *
FROM
  `bigquery-public-data.google_trends.top_terms`
LIMIT 10
 
  ----
SELECT 
     RANK () OVER ( ORDER BY term) as rank_no,
    dma_name,
    SUM(score) as total_score
FROM
    `bigquery-public-data.google_trends.top_terms`
GROUP BY dma_name
order by total_score desc
 
 ---let's find the dma_name that is high than the average score
 
SELECT 
    dma_name,
    sum(score)
FROM
    `bigquery-public-data.google_trends.top_terms`
GROUP BY dma_name 
having  sum(score)  > ( select avg(score)
                from `bigquery-public-data.google_trends.top_terms` )

---- Match with hign score 

SELECT 
  term,
  sum(score) as total_score,
  RANK () OVER ( ORDER BY sum(score)) as rank_no,
From 
  `bigquery-public-data.google_trends.top_terms`
  where score IS NOT NULL
  group by term
  order by total_score desc

____ Hign ranking

SELECT
 avg(score) as avg_score,
 extract(month from week) as month
 
FROM
  `bigquery-public-data.google_trends.top_terms`






  