-- All genres having 3 most sale values
-- not finished, the task unclear
select genre.name,
sum(invoice_line.unit_price * invoice_line.quantity) as sale_value
from invoice_line
join track ON invoice_line.track_id = track.track_id
join genre ON track.genre_id = genre.genre_id
GROUP BY genre.name