USE sakila;

-- ==================================================================================================================================
-- CHALLENGE 1
-- =======================================================================
-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
--     1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

SELECT MIN(length) AS min_duration, MAX(length) AS max_duration FROM sakila.film;

--     1.2. Express the average movie duration in hours and minutes. Don't use decimals.

SELECT 
FLOOR(avg(length)) AS hours, 
FLOOR((avg(length) - FLOOR(avg(length)))*60) AS minutes 
FROM sakila.film;

-- =======================================================================
-- 2. You need to gain insights related to rental dates:
--    2.1 Calculate the number of days that the company has been operating.

SELECT rental_date FROM sakila.rental
ORDER BY rental_date;

SELECT DATEDIFF('2006/02/14', '2005/05/24') AS 'Operating_Company (Days)';  -- 266 days

--    2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

SELECT *, 
DATE_FORMAT(CONVERT(rental_date, DATE), '%M') AS 'Month', 
DATE_FORMAT(CONVERT(rental_date, date), '%W') AS 'Weekday' 
FROM sakila.rental
LIMIT 20;

--    2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.

SELECT *, 
DATE_FORMAT(CONVERT(rental_date, date), '%W') AS 'Weekday',
CASE
WHEN (DATE_FORMAT(CONVERT(rental_date, date), '%W')) = 'Saturday' THEN 'Weekend'
WHEN (DATE_FORMAT(CONVERT(rental_date, date), '%W')) = 'Sunday' THEN 'Weekend'
ELSE 'Workday'
END AS 'DAY_TYPE'
FROM sakila.rental;

-- =======================================================================
/*
3. You need to ensure that customers can easily access information about the movie collection. 
To achieve this, retrieve the film titles and their rental duration. 
If any rental duration value is NULL, replace it with the string 'Not Available'. 
Sort the results of the film title in ascending order.

Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
Hint: Look for the IFNULL() function.
*/
SELECT title, IFNULL(rental_duration, 'Not Available') AS 'Rental duration' FROM sakila.film;

-- =============================================================================================================================================================
-- CHALLANGE 2
-- =======================================================================

-- 1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
--    1.1 The total number of films that have been released.

SELECT COUNT(DISTINCT title) AS 'Total number of films' FROM sakila.film;  -- 1000

--    1.2 The number of films for each rating.

SELECT rating, COUNT(title) FROM sakila.film
GROUP BY rating;

--    1.3 The number of films for each rating, sorting the results in descending order of the number of films. 

SELECT rating, COUNT(title) FROM sakila.film
GROUP BY rating
ORDER BY COUNT(title) DESC;

-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
--      Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.

SELECT rating, ROUND(AVG(length), 2) AS 'Mean film duration' FROM sakila.film
GROUP BY rating
ORDER BY ROUND(AVG(length), 2) DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

SELECT rating, ROUND(AVG(length), 2) AS 'Mean film duration' FROM sakila.film
GROUP BY rating
HAVING ROUND(AVG(length), 2) > 120
ORDER BY ROUND(AVG(length), 2) DESC;

-- Bonus: determine which last names are not repeated in the table actor.

SELECT last_name FROM sakila.actor
GROUP BY last_name
HAVING COUNT(*) = 1;




