-- Top 3 genres bringing most revenue
-- based on hw2/tasl2.sql
SELECT SUM(invoice_line.unit_price * invoice_line.quantity) as revenue, genre.name as genre_name
FROM track
JOIN genre ON track.genre_id = genre.genre_id
JOIN invoice_line ON track.track_id = invoice_line.track_id
GROUP BY genre.name
ORDER BY revenue DESC LIMIT 3
