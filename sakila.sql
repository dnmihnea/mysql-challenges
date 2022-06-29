USE sakila;

-- 1. List all actors.
SELECT * FROM actor;

-- 2. Find the surname of the actor with the forename 'John'.
SELECT last_name FROM actor WHERE first_name = 'John';

-- 3. Find all actors with surname 'Neeson'.
SELECT * FROM actor WHERE last_name = 'Neeson';

-- 4. Find all actors with ID numbers divisible by 10.
SELECT * FROM actor WHERE actor_id LIKE '%0';

-- 5. What is the description of the movie with an ID of 100?
SELECT `description` FROM film WHERE film_id = 100;

-- 6. Find every R-rated movie.
SELECT * FROM film WHERE rating = 'R';

-- 7. Find every non-R-rated movie.
SELECT * FROM film WHERE rating != 'R';

-- 8. Find the ten shortest movies.
SELECT * FROM film ORDER BY length ASC LIMIT 10;

-- 9. Find the movies with the longest runtime, without using LIMIT.
SELECT * FROM film WHERE length = (
SELECT MAX(length) FROM film
);

-- 10. Find all movies that have deleted scenes.
SELECT * FROM film WHERE special_features LIKE '%Deleted Scenes%';

-- 11. Using HAVING, reverse-alphabetically list the last names that are not repeated.
SELECT DISTINCT last_name FROM actor
HAVING last_name IS NOT NULL
ORDER BY last_name DESC;

-- 12. Using HAVING, list the last names that appear more than once, from highest to lowest frequency.
SELECT last_name, COUNT(last_name) AS occ
FROM actor
GROUP BY last_name
HAVING occ > 1
ORDER BY occ DESC;

-- 13. Which actor has appeared in the most films?
SELECT film_actor.actor_id, COUNT(film_actor.film_id) AS films, actor.first_name, actor.last_name
FROM film_actor
INNER JOIN actor ON film_actor.actor_id = actor.actor_id
GROUP BY actor_id
ORDER BY films DESC LIMIT 1;

-- 14. When is 'Academy Dinosaur' due?
SELECT i.inventory_id,f.title,r.rental_date, DATE_ADD(rental_date,INTERVAL rental_duration DAY) AS ReturnDate
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE f.title = 'ACADEMY DINOSAUR'
AND return_date IS NULL;

-- 15. What is the average runtime of all films?
SELECT AVG(length) AS `Average Runtime` FROM film;

-- 16. List the average runtime for every film category. 
SELECT c.name, AVG(f.length) FROM film_category AS fc
JOIN film AS f ON f.film_id = fc.film_id
JOIN category AS c ON c.category_id = fc.category_id
GROUP BY c.name;

-- 17. List all movies featuring a robot.
SELECT * FROM film WHERE description LIKE '%Robot%';

-- 18. How many movies were released in 2010?
SELECT COUNT(film_id) AS `2010 Movies` FROM film WHERE release_year = 2010;

-- 19. Find the titles of all the horror movies.
SELECT film.title FROM film_category
JOIN film ON film.film_id = film_category.film_id
JOIN category ON category.category_id = film_category.category_id
WHERE category.name = 'Horror';

-- 20. List the full name of the staff member with the ID of 2.
SELECT first_name, last_name FROM staff where staff_id = 2;

-- 21. List all the movies that Fred Costner has appeared in.
SELECT f.title FROM film_actor AS fa
JOIN film AS f ON f.film_id = fa.film_id
JOIN actor AS a ON a.actor_id = fa.actor_id
WHERE a.first_name = 'Fred' AND a.last_name = 'Costner';

-- 22. How many distinct countries are there?
SELECT DISTINCT COUNT(country_id) AS `Number of Countries` FROM country;

-- 23. List the name of every language in reverse-alphabetical order.
SELECT country FROM country
ORDER BY country DESC;

-- 24. List the full names of every actor whose surname ends with '-son' in alphabetical order by their forename.
SELECT first_name, last_name FROM actor
WHERE last_name LIKE '%son'
ORDER BY first_name ASC;

-- 25. Which category contains the most films?
SELECT c.name, COUNT(fc.film_id) AS count FROM film_category AS fc
JOIN category AS c ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY count DESC LIMIT 1;