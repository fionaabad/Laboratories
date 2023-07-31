-- Creating a Customer Summary Report

-- Step 1: Create a View

DROP view IF EXISTS sakila.j;
create view sakila.j as
select sakila.customer.customer_id, concat(first_name,' ', last_name) as Name, email, count(*) as rental_count
from sakila.customer
inner join sakila.rental
on sakila.customer.customer_id = sakila.rental.customer_id
group by sakila.customer.customer_id;

select * from sakila.j;

-- Step 2: Create a Temporary Table

DROP temporary table IF EXISTS sakila.tempt_table;
create temporary table sakila.tempt_table
select sakila.payment.customer_id, sum(amount) as total_paid, Name 
from sakila.j
inner join sakila.payment
on sakila.j.customer_id = sakila.payment.customer_id
group by sakila.payment.customer_id;

select *
from sakila.tempt_table;

-- Step 3: Create a CTE and the Customer Summary Report

WITH cte_customer_rental_payment AS (
    SELECT sakila.j.Name, sakila.j.email, sakila.j.rental_count, sakila.tempt_table.total_paid, total_paid/ rental_count as average_payment_per_rental
    FROM sakila.j
    JOIN sakila.tempt_table
    ON sakila.j.customer_id = sakila.tempt_table.customer_id
)
SELECT *
FROM cte_customer_rental_payment;


