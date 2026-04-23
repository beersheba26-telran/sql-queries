SELECT extract(year from invoice_date) as year,
       extract(month from invoice_date) as month,
       count(*) FROM invoice
GROUP BY year, month
order by year, month