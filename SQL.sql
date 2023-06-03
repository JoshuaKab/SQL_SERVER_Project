select *
FROM Dept.Employee

--- comment
select
  id,
  order_id,
  product,
  quantity,
  price,
  case when product like '%Bread%'
  then (quantity + 1) * price
  when product like '%Cheese%'
  then (quantity + 1) * price
  else quantity * price
  end as Bread_and_Cheese_Upselling
from
  {{raw.e_commerce_sample.webshop_order_line}}


--- From the biig query sales dataset---

SELECT
Product_ID, Product_Name, Profit, Sales

FROM
  `gold-gearbox-373811.Storeshop.store`

WHERE Sales > 1000 AND
       Profit > 100

--- aggregation function 
 
select 
	count(id) as orders_received, 
    extract(
    year 
from 
      (
        parse_date('%d / %m / %Y', received_at)
      )
  ) as recived_at_year 
from 
  {{raw.e_commerce_sample.webshop_order}} 
group by 
  recived_at_year