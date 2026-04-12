-- All genres taking 3 top positions by revenue
-- based on hw2/tasl2.sql
SELECT genre_name, revenue FROM
(SELECT
    SUM(invoice_line.unit_price * invoice_line.quantity) as revenue,
    genre.name as genre_name,
    dense_rank() over (order by SUM(invoice_line.unit_price * invoice_line.quantity) DESC) as rnk
FROM track
JOIN genre ON track.genre_id = genre.genre_id
JOIN invoice_line ON track.track_id = invoice_line.track_id
GROUP BY genre.name
ORDER BY rnk) t
WHERE rnk <= 3