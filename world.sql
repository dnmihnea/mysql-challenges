USE world;

-- 1. Using COUNT, get the number of cities in the USA.
SELECT COUNT(ID) AS `Cities in the USA` FROM city WHERE CountryCode LIKE 'USA';

-- 2. Find out the population and life expectancy for people in Argentina.
SELECT Population, LifeExpectancy FROM country WHERE `Name` = 'Argentina';

-- 3. Using IS NOT NULL, ORDER BY, and LIMIT, which country has the highest life expectancy?
SELECT `Name` FROM country
WHERE LifeExpectancy iS NOT NULL
ORDER BY LifeExpectancy DESC LIMIT 1;

-- 4. Using JOIN ... ON, find the capital city of Spain.
SELECT co.`Name` AS `Country`, ci.`Name` AS `Capital` FROM country AS co
JOIN city AS ci ON ci.ID = co.Capital
WHERE co.`Name` = 'Spain';

-- 5. Using JOIN ... ON, list all the languages spoken in the Southeast Asia region.
SELECT l.`Language` FROM country AS c
JOIN countrylanguage AS l ON l.CountryCode = c.`Code`
WHERE c.Region = 'Southeast Asia'
GROUP BY l.`Language`;

-- 6. Using a single query, list 25 cities around the world that start with the letter F.
SELECT `Name` FROM city 
WHERE `Name` LIKE 'F%'
LIMIT 25;

-- 7. Using COUNT and JOIN ... ON, get the number of cities in China.
SELECT COUNT(ci.`Name`) AS cities FROM country AS co
JOIN city AS ci ON ci.CountryCode = co.`Code`
WHERE co.`Name` = 'China';

-- 8. Using IS NOT NULL, ORDER BY, and LIMIT, which country has the lowest population? Discard non-zero populations.
SELECT `Name` FROM country
WHERE Population IS NOT NULL AND Population > 0
ORDER BY Population LIMIT 1;

-- 9. Using aggregate functions, return the number of countries the database contains.
SELECT DISTINCT COUNT(`Name`) AS `Number of Countries` FROM country;

-- 10. What are the top ten largest countries by area?
SELECT `Name` FROM country
ORDER BY SurfaceArea DESC LIMIT 10;

-- 11. List the five largest cities by population in Japan.
SELECT `Name`, Population FROM city
WHERE CountryCode = 'JPN'
ORDER BY Population DESC LIMIT 5;

-- 12. List the names and country codes of every country with Elizabeth II as its Head of State. You will need to fix the mistake first!
UPDATE country
SET HeadOfState = 'Elizabeth II'
WHERE HeadOfState = 'Elisabeth II';

SELECT `Name` FROM country
WHERE HeadOfState = 'Elizabeth II';

-- 13. List the top ten countries with the smallest population-to-area ratio. Discard any countries with a ratio of 0.
CREATE VIEW country_ratios
AS
	SELECT `Name`, Population/SurfaceArea AS PopSA_Ratio
    FROM country
;
SELECT `Name`, PopSA_Ratio
FROM country_ratios
WHERE PopSA_Ratio != 0
GROUP BY `Name`
ORDER BY PopSA_Ratio ASC;

-- 14. List every unique world language.
SELECT DISTINCT `Language` FROM countrylanguage
GROUP BY `Language`
ORDER BY `Language`;

-- 15. List the names and GNP of the world's top 10 richest countries.
SELECT `Name`, GNP FROM country
ORDER BY GNP DESC LIMIT 10;

-- 16. List the names of, and number of languages spoken by, the top ten most multilingual countries.
SELECT c.`Name`, COUNT(l.`Language`) FROM country AS c
JOIN  countrylanguage AS l ON l.CountryCode = c.`Code`
GROUP BY c.`Name`
ORDER BY COUNT(l.`Language`) DESC LIMIT 10;

-- 17. List every country where over 50% of its population can speak German.

SELECT c.`Name` FROM country AS c
JOIN countrylanguage AS l ON c.`Code` = l.CountryCode
WHERE l.`Language` = 'German' AND l.Percentage > 50;

-- 18. Which country has the worst life expectancy? Discard zero or null values.
SELECT `Name`, LifeExpectancy FROM country
WHERE LifeExpectancy IS NOT NULL 
AND LifeExpectancy > 0
ORDER BY  LifeExpectancy LIMIT 1;

-- 19. List the top three most common government forms.
SELECT GovernmentForm, COUNT(GovernmentForm) FROM country
GROUP BY GovernmentForm
ORDER BY COUNT(GovernmentForm) DESC LIMIT 3;

-- 20. How many countries have gained independence since records began?
SELECT `Name`, IndepYear FROM country
WHERE IndepYear IS NOT NULL;


SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM countrylanguage;