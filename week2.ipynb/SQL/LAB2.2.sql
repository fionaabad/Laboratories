-- 1
select max(length) as max_duration, min(length) as min_duration, round(avg(length)) as min_avg_duration , round(avg(length)/60) as hour_avg_duration 
from sakila.film;

-- 2
select DATEDIFF(max(rental_date), min(rental_date)) as operating_days
from sakila.rental;

SELECT *, monthname(rental_date) as month, dayname(rental_date) as day
from sakila.rental;

select *,
case
	when weekday(rental_date) < 5 then 'Workday'
    else 'Weekday'
end as DAY_TYPE
from sakila.rental;

-- 3 

select title, rental_duration,
case
	when date_duration = NULL then 'Not Available'
    else date_duration
end as rental_duration2
from sakila.film;

/*
select *, 
case
	when DATEDIFF(return_date, rental_date) = NULL then 'Not Available'
    else DATEDIFF(return_date, rental_date)
end as rental_duration
from sakila.rental
*/

-- 4 
select concat(last_name, ' ', first_name,' email: ', left(email, 3)) as full_name -- substring(email, 1, 3)
from sakila.customer
order by full_name;

-- CHALLENGE 2:
-- 1
select rating, count(title)
from sakila.film
group by rating
order by count(title) desc;

-- 2
select concat(first_name,' ', last_name) as name, count(sakila.rental.staff_id)
from sakila.rental
inner join sakila.staff
on sakila.rental.staff_id = sakila.staff.staff_id
group by sakila.staff.staff_id;

-- 3
select round(avg(length),2) as average, rating
from sakila.film
group by rating
having  average > 120 -- where passa abans d fer les operacions i aqui ens interesa un having perque ja hem calculat el average
order by avg(length) desc;

-- 4
select last_name, count(last_name) as count
from sakila.actor
group by last_name
having count = 1; -- aqui tmb utilitzem el having perque primer mes el count

-- una altre manera de ferho creant una temporary table
drop table if exists sakila.temp;
create temporary table sakila.temp
select last_name, count(*) as nb_of_occ from sakila.actor
group by last_name;
select * from sakila.temp where nb_of_occ = 1;












