-- 1 Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select sakila.film.title, count(*) as num_of_copies
from sakila.film
inner join sakila.inventory
on sakila.film.film_id = sakila.inventory.film_id
where sakila.film.title = "Hunchback Impossible"
group by title;

-- anem a utilitzar a subqueary

select film_id, count(*) as num_copies
from sakila.inventory
where film_id = (select film_id from sakila.film where sakila.film.title = "Hunchback Impossible")
group by film_id;

-- 2 List all films whose length is longer than the average length of all the films in the Sakila database.
select title, length
from sakila.film
having length > (select avg(length) from sakila.film);

-- 3 Use a subquery to display all actors who appear in the film "Alone Trip".
select title, group_concat(first_name, ' ', last_name)
from sakila.film
inner join sakila.film_actor
on sakila.film.film_id = sakila.film_actor.film_id
inner join sakila.actor
on sakila.film_actor.actor_id = sakila.actor.actor_id
where title = "Alone Trip"
group by title;

-- anem a fer-ho amb subquearis
select film_id, group_concat(first_name, ' ', last_name) as actor
from sakila.film_actor
inner join sakila.actor
on sakila.film_actor.actor_id = sakila.actor.actor_id
where film_id = (select film_id from sakila.film
where title = "Alone Trip")
group by film_id;


-- 4 Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
select sakila.category.name, group_concat(title)
from sakila.film
inner join sakila.film_category
on sakila.film.film_id = sakila.film_category.film_id
inner join sakila.category
on sakila.film_category.category_id = sakila.category.category_id
where sakila.category.name = 'Family'
group by name;

-- anem a fer-ho amb les subquearis
select category_id, group_concat(title)
from sakila.film_category
inner join sakila.film
on sakila.film.film_id = sakila.film_category.film_id
where category_id = (select category_id from sakila.category where name = 'Family')
group by category_id;

-- 5 Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
select sakila.customer.first_name, sakila.customer.last_name, sakila.customer.email
from sakila.customer
inner join sakila.address
on sakila.customer.address_id = sakila.address.address_id
inner join sakila.city
on sakila.address.city_id = sakila.city.city_id
where country_id = ( select country_id from sakila.country where country = 'Canada');

select sakila.customer.first_name, sakila.customer.last_name, sakila.customer.email
from sakila.customer
inner join sakila.address
on sakila.customer.address_id = sakila.address.address_id
where city_id = ( select city_id from sakila.city inner join sakila.country on sakila.city.country_id = sakila.country.country_id where country = 'Canada');

-- 6 Determine which films were starred by the most prolific actor in the Sakila database.
select group_concat(title, ' ') as movie, actor_id, COUNT(sakila.film_actor.film_id) as film_count
from sakila.film
inner join sakila.film_actor
on sakila.film.film_id = sakila.film_actor.film_id
GROUP BY sakila.film_actor.actor_id
HAVING COUNT(sakila.film_actor.film_id) = (SELECT MAX(film_count) FROM (SELECT COUNT(sakila.film_actor.film_id) AS film_count FROM sakila.film_actor GROUP BY actor_id) AS counts);

/*
SELECT actor_id, COUNT(film_id) AS film_count
FROM sakila.film_actor
GROUP BY actor_id
HAVING COUNT(film_id) = (SELECT MAX(film_count) FROM (SELECT COUNT(film_id) AS film_count FROM sakila.film_actor GROUP BY actor_id) AS counts);
*/

-- 7 Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.

SELECT sakila.film.title
FROM sakila.film
inner JOIN sakila.inventory 
ON sakila.film.film_id = sakila.inventory.film_id
inner JOIN sakila.rental 
ON sakila.inventory.inventory_id = sakila.rental.inventory_id
WHERE sakila.rental.customer_id = (
    SELECT sakila.payment.customer_id
    FROM sakila.payment
    GROUP BY sakila.payment.customer_id
    ORDER BY SUM(sakila.payment.amount) DESC
    LIMIT 1
);

-- 8 Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. You can use subqueries to accomplish this.

select customer_id, sum(amount) as total_amount
from sakila.payment
group by customer_id
having total_amount > (select sum(amount)/count(*) as average from sakila.payment)
order by sum(amount) desc;








