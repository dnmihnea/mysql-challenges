USE movielens;

-- 1. List the titles and release dates of movies released between 1983-1993 in reverse chronological order.
SELECT * FROM movies
WHERE release_date >= '1983-01-01'
AND release_date < '1994-01-01'
ORDER BY release_date DESC;

-- 2. Without using LIMIT, list the titles of the movies with the lowest average rating.
SELECT m.title, AVG(r.rating) FROM movies AS m
JOIN ratings AS r ON r.movie_id = m.id
GROUP BY m.title
ORDER BY AVG(r.rating);

-- 3. List the unique records for Sci-Fi movies where male 24-year-old students have given 5-star ratings.
SELECT DISTINCT m.title, r.rating, u.age, u.gender, o.`name`, g.`name` FROM movies AS m
JOIN ratings AS r ON r.movie_id = m.id
JOIN users AS u ON u.id = r.user_id
JOIN occupations AS o ON o.id = u.occupation_id
JOIN genres_movies AS gm ON gm.movie_id = m.id
JOIN genres AS g ON g.id = gm.genre_id
WHERE u.age = 24
AND u.gender = 'M'
AND o.`name` = 'Student'
AND g.`name` = 'Sci-Fi'
AND r.rating = 5
ORDER BY m.title;

-- 4. List the unique titles of each of the movies released on the most popular release day.
SELECT title FROM movies
WHERE release_date=(
	SELECT release_date FROM movies
	GROUP BY release_date
	ORDER BY COUNT(id) DESC LIMIT 1
);




-- 5. Find the total number of movies in each genre; list the results in ascending numeric order.
SELECT g.`name`, COUNT(m.title) FROM movies AS m
JOIN genres_movies AS gm ON gm.movie_id = m.id
JOIN genres AS g ON g.id = gm.genre_id
GROUP BY g.`name`
ORDER BY COUNT(m.title) ASC;