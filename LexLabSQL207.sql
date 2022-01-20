USE sakila;

-- Q1 How many films are there for each of the categories in the category table. Use appropriate join to write this query.
SELECT c.category_id, c.name, COUNT(f.film_id) AS "number_films"
FROM sakila.category c
JOIN sakila.film_category f
USING (category_id)
GROUP BY c.category_id
ORDER BY "number_films" DESC;

-- Q2 Display the total amount rung up by each staff member in August of 2005.
SELECT staff_id, SUM(amount) AS total_amount
FROM sakila.payment
WHERE payment_date BETWEEN 20050801 AND 20050831
GROUP BY staff_id;

-- Q3 Which actor has appeared in the most films?
SELECT a.actor_id, a.first_name, a.last_name, COUNT(f.actor_id) AS count_films
FROM sakila.film_actor f 
LEFT JOIN sakila.actor a
USING (actor_id)
GROUP BY a.actor_id, a.first_name, a.last_name 
ORDER BY count_films DESC
LIMIT 1;

-- Q4 Most active customer (the customer that has rented the most number of films)
-- Since the rental_id is unique and contains an inventory_id I assume a rental_id is for each movie rented
SELECT * from sakila.rental;
SELECT COUNT(DISTINCT rental_id) from sakila.rental; -- checing rental_id is unique

SELECT r.customer_id, c.first_name, c.last_name, COUNT(r.customer_id) AS count_rentals
FROM sakila.rental r 
LEFT JOIN sakila.customer c
USING (customer_id)
GROUP BY r.customer_id, c.first_name, c.last_name 
ORDER BY count_rentals DESC
LIMIT 1;

-- Q5 Display the first and last names, as well as the address, of each staff member.
SELECT s.first_name, s.last_name, a.address, a.address2, a.district, c.city, a.postal_code
FROM sakila.staff s
LEFT JOIN sakila.address a
using (address_id)
LEFT JOIN sakila.city c
using (city_id);

-- Q6 List each film and the number of actors who are listed for that film.
SELECT f.title, COUNT(fa.actor_id) AS count_actors
FROM sakila.film f
JOIN sakila.film_actor fa
USING (film_id)
GROUP BY f.title
ORDER BY f.title ASC;

-- Q7 Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
SELECT c.last_name, SUM(p.amount) AS total_paid
FROM sakila.payment p
JOIN sakila.customer c
USING (customer_id)
GROUP BY c.last_name
ORDER BY c.last_name ASC;

-- I was suprised that there were only 599 rows so double checked number of unique customer_id in payment and got same figure, so all good. 
SELECT COUNT(DISTINCT customer_id) FROM sakila.payment;

-- Q8 List number of films per category.
SELECT c.name, COUNT(f.film_id) AS film_per_cat
FROM sakila.film_category f
JOIN sakila.category c
USING (category_id)
GROUP BY c.category_id
ORDER BY c.name ASC;


