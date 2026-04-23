SELECT SUM(invoice_line.unit_price * invoice_line.quantity ), artist.name
FROM album
JOIN track ON album.album_id = track.album_id
JOIN artist ON album.artist_id = artist.artist_id
JOIN invoice_line ON track.track_id = invoice_line.track_id
GROUP BY artist.name

