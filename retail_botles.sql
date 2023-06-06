  SELECT
  *
  FROM
  `bigquery-public-data.iowa_liquor_sales.sales`
  LIMIT 5

  --- THE CITY WITH MORE SALES

  SELECT
  city,
  SUM(state_bottle_retail * bottles_sold) as total_sale,
  Count(invoice_and_item_number) as Qty_sale
  FROM
  `bigquery-public-data.iowa_liquor_sales.sales`
  Group by city 
  order by total_sale desc
  LIMIT 10

  ---- THE LESS SALE BRAND
  
  SELECT
  city, vendor_name,
  SUM(state_bottle_retail * bottles_sold) as total_sale,
  Count(invoice_and_item_number) as Qty_sale
  FROM
  `bigquery-public-data.iowa_liquor_sales.sales`
  Group by city, vendor_name
  order by total_sale ASC
  LIMIT 10


---- THE MOST SALE BRAND
  SELECT
  vendor_name,
  MAX(state_bottle_retail * bottles_sold) as Highest_sale,
  Count(invoice_and_item_number) as Qty_sale
  FROM
  `bigquery-public-data.iowa_liquor_sales.sales`
  Group by vendor_name
  order by Qty_sale desc
  LIMIT 10

--- avg SALE

WITH avg_per_store AS
  (SELECT vendor_name, AVG(state_bottle_cost * bottles_sold) AS average_order
   FROM
   `bigquery-public-data.iowa_liquor_sales.sales`
   GROUP BY vendor_name)
SELECT s.city, s.state_bottle, s.bottle_sold, avg.average_order AS avg_for_store
FROM 
`bigquery-public-data.iowa_liquor_sales.sales` as s
JOIN avg_per_store avg
ON s.vendor_name = avg.vendor_name;

