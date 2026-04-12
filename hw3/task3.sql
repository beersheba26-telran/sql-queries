-- All genres having 3 most sale values
with genre_sales as (
    select genre.name,
           sum(invoice_line.unit_price * invoice_line.quantity) as revenue
    from invoice_line
             join track on invoice_line.track_id = track.track_id
             join genre on track.genre_id = genre.genre_id
    group by genre.name
),
     ranked as (
         select *,
                dense_rank() over (order by revenue desc) as rnk
         from genre_sales
     )
select name, revenue
from ranked
where rnk <= 3;