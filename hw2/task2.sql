SELECT SUM(invoice_line.unit_price * invoice_line.quantity), genre.name
FROM track
JOIN genre ON track.genre_id = genre.genre_id
JOIN invoice_line ON track.track_id = invoice_line.track_id
GROUP BY genre.name

