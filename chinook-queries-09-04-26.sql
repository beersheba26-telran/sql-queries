-- getting data about youngest employees
-- select first_name, last_name, title from employee where birth_date = (select max(birth_date) from employee);
-- 
-- countries where youngest employees supprted customers
-- select distinct country from customer where support_rep_id in (select employee_id from employee where birth_date = (select max(birth_date) from employee));
-- total sales
-- select sum(total) as "total sales" from invoice;
-- 
-- CLV (Customer Life Value) for each customer
-- select customer_id, sum(total) as "CLV" from invoice group by customer_id order by sum(total) desc
-- 
-- CLV for customers whose CLV greater than average CLV for all customers
with avg_clv as (select round(avg(clv), 2) as avg from (select  sum(total) as clv from invoice group by customer_id))
select clv_customer.*, avg from (select customer_id, sum(total) as "CLV" from invoice group by customer_id having sum(total) > (select avg from avg_clv) order by sum(total) desc) clv_customer cross join avg_clv


