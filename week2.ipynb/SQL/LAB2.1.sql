SHOW TABLES from sakila;

select * from sakila.actor;
select * from sakila.film;
select * from sakila.customer;

-- 3
select title, name as language_used_in_films, first_name 
from sakila.film
inner join sakila.language 
on sakila.film.language_id = sakila.language.language_id
inner join sakila.inventory
on sakila.film.film_id = sakila.inventory.film_id
inner join sakila.staff
on sakila.inventory.store_id = sakila.staff.store_id;

-- 4 
select distinct release_year
from sakila.film;

-- 5
select count(distinct sakila.staff.store_id) as num_stores, count(distinct sakila.staff.staff_id) as num_of_employees, count(distinct sakila.rental.rental_id) as n_films_rented, count(distinct sakila.inventory.inventory_id) as n_films_available, count(distinct sakila.actor.last_name)
from sakila.store
inner join sakila.staff
on sakila.store.store_id = sakila.staff.store_id
inner join sakila.rental
on sakila.staff.staff_id = sakila.rental.staff_id
inner join sakila.inventory
on sakila.rental.inventory_id = sakila.inventory.inventory_id
inner join sakila.film_actor
on sakila.inventory.film_id = sakila.film_actor.film_id
inner join sakila.actor
on sakila.film_actor.actor_id = sakila.actor.actor_id;

-- 6: Retrieve the 10 longest films
select title from sakila.film order by length desc limit 10;

-- 7 
select concat(first_name,' ', last_name) as Scarlett
from sakila.actor
where first_name = 'SCARLETT';

select title
from sakila.film
where length > 100 and title like '%ARMAGEDDON%';

select * from sakila.film where title regexp 'ARMAGEDDON' and film.length > 100;

select count(title) as films_withs_behind_the_scenes
from sakila.film
where special_features = 'Behind the Scenes'
















