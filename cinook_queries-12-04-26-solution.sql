with genre_sales as (select g.name, sum(il.unit_price * il.quantity) as sales from genre g 
 join track tr on tr.genre_id = g.genre_id join invoice_line il on il.track_id = tr.track_id 
group by g.name order by sales desc),
ranked as (select genre_sales.*, rank() over(order by sales desc) as position from genre_sales),
dense_ranked as (select genre_sales.*, dense_rank() over(order by sales desc) as dense_rank from genre_sales),
numbered as (select genre_sales.*, row_number() over(order by sales desc) as row_number from genre_sales),
quintiled as (select genre_sales.*, ntile(5) over(order by sales desc) as quintile from genre_sales)
-- Top 3 genres bringing most revenue
select * from numbered where row_number <= 3; 
-- 
-- All genres taking 3 top positions by revenue
select * from ranked where position <= 3;
-- 
select * from dense_ranked where dense_rank <= 3;
-- 
-- 20% genres bringing most revenue
select * from quintiled where quintile=1;