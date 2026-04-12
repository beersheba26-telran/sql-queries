with customers_clv as (
  select c.customer_id, coalesce(sum(total), 0) as clv from customer c left join invoice inv on c.customer_id=inv.customer_id 
  group by c.customer_id
), median_value as (
  select percentile_cont(0.5) within group (order by clv desc) as median_clv from customers_clv
)
--top 5 most valued customers
-- select customers_clv.*, median_clv from customers_clv cross join median_value  order by clv desc limit 5;
--
-- All customer taking top 5 places
, ranked as 
(select customers_clv.*, median_clv, rank() over(order by clv desc) as place from customers_clv cross join median_value  order by clv desc)
-- select * from ranked where place <=5
-- 
-- All customers having top 5 CLV values
, dense_ranked as (select customers_clv.*, median_clv, dense_rank() over(order by clv desc) as dense_rank from customers_clv cross join median_value  order by clv desc)
-- select * from dense_ranked where dense_rank <= 5
, quintiled as (select customers_clv.*, median_clv, ntile(5) over(order by clv desc) as quintile from customers_clv cross join median_value  order by clv desc)
-- 20% most valued customers
-- select * from quintiled where quintile=1;
, numbered as (
  select customers_clv.*, median_clv, row_number() over(order by clv desc) as row, dense_rank() over(order by clv desc) as dense_rank  from customers_clv cross join median_value  order by clv desc
)
-- select * from numbered