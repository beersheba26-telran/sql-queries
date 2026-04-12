-- 20% genres bringing most revenue
with genre_sales as (select genre.name,
                              sum(invoice_line.unit_price * invoice_line.quantity) as sale_value
                       from invoice_line
                                join track ON invoice_line.track_id = track.track_id
                                join genre ON track.genre_id = genre.genre_id
                       GROUP BY genre.name
                       ORDER BY sale_value DESC),
     cnt as (
         select count(*) as total_genres
         from genre_sales
     )
select genre_sales.name, genre_sales.sale_value
from genre_sales
order by genre_sales.sale_value desc
limit (select ceil(total_genres * 0.2) from cnt);