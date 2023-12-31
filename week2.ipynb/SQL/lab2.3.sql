-- 1 List the number of films per category.
select count(sakila.film.title) as num_films, (sakila.category.name) as cat
from sakila.film
inner join sakila.film_category
on sakila.film.film_id = sakila.film_category.film_id
inner join sakila.category
on sakila.film_category.category_id = sakila.category.category_id
group by (sakila.category.name);

-- 2 Retrieve the store ID, city, and country for each store.
select sakila.store.store_id, sakila.city.city, sakila.country.country
from sakila.store
inner join sakila.address
on sakila.store.address_id = sakila.address.address_id
inner join sakila.city
on sakila.address.city_id = sakila.city.city_id
inner join sakila.country
on sakila.city.country_id = sakila.country.country_id
group by sakila.store.store_id;

-- 3 Calculate the total revenue generated by each store in dollars
select sakila.store.store_id, concat('$ ', sum(sakila.payment.amount)) as total_revenue
from sakila.store
inner join sakila.staff
on sakila.store.store_id = sakila.staff.store_id
inner join sakila.payment
on sakila.staff.staff_id = sakila.payment.staff_id
group by sakila.store.store_id;

-- 4 Determine the average running time of films for each category.
select round(avg(sakila.film.length), 2) as avg_duration, (sakila.category.name) as Cat
from sakila.film
inner join sakila.film_category
on sakila.film.film_id = sakila.film_category.film_id
inner join sakila.category
on sakila.film_category.category_id = sakila.category.category_id
group by (sakila.category.name);

-- 5 Identify the film categories with the longest average running time.
select round(avg(sakila.film.length), 2) as avg_duration, (sakila.category.name) as Cat
from sakila.film
inner join sakila.film_category
on sakila.film.film_id = sakila.film_category.film_id
inner join sakila.category
on sakila.film_category.category_id = sakila.category.category_id
group by (sakila.category.name)
order by avg_duration desc limit 5;

-- 6 Display the top 10 most frequently rented movies in descending order.
select sakila.film.film_id, sakila.film.title, count(*) as rented_movies
from sakila.film
inner join sakila.inventory
on sakila.film.film_id = sakila.inventory.film_id
inner join sakila.rental
on sakila.inventory.inventory_id = sakila.rental.inventory_id
group by sakila.film.film_id
order by rented_movies desc limit 10;

-- 7 Determine if "Academy Dinosaur" can be rented from Store 1.
select "Academy Dinosaur" as movie,
case
   when count(*) > 0 then 'Available'
   else 'Not available'
end as availableOrNotInStore1
from sakila.film
inner join sakila.inventory
on sakila.film.film_id = sakila.inventory.film_id
where sakila.inventory.store_id = 1 and sakila.film.title = 'Academy Dinosaur';






