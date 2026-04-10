-- distibution of sales by years and months
select extract(year from invoice_date) as year, extract (month from invoice_date) as month, sum(total) as sales 
from invoice group by year, month order by year desc, month desc;
-- distribution of sales by genres
select g.name, coalesce(sum(il.unit_price * il.quantity), 0) as sales from genre g 
left join track tr on tr.genre_id = g.genre_id left join invoice_line il on il.track_id = tr.track_id 
group by g.name order by sales desc;
-- distibution of sales by artists
select ar.name, coalesce(sum(il.unit_price * il.quantity), 0) as sales
from artist ar
left join album al on al.artist_id = ar.artist_id
left join track tr on tr.album_id = al.album_id
left join invoice_line il on il.track_id = tr.track_id
group by ar.name
order by sales desc;
