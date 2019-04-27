-- Shayan Beizaee

USE sakila;

SELECT first_name, last_name FROM actor;

SELECT CONCAT(first_name, " ", last_name) AS "Actor Name" FROM actor;

SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = "JOE";

SELECT first_name, last_name
FROM actor
WHERE last_name LIKE "%GEN%";

SELECT first_name, last_name
FROM actor
WHERE last_name LIKE "%LI%"
ORDER BY last_name, first_name ASC;

SELECT country_id, country
FROM country
WHERE COUNTRY IN ('Afghanistan', 'Bangladesh', 'China');

ALTER TABLE actor
ADD COLUMN description BLOB AFTER last_update;

ALTER TABLE actor
DROP description;

SELECT last_name, COUNT(last_name) AS 'count'
FROM actor
GROUP BY last_name;

SELECT last_name, COUNT(last_name) AS 'count'
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1;

UPDATE actor
SET first_name = "HARPO"
WHERE first_name = "GROUCHO" and last_name = "WILLIAMS";

UPDATE actor
SET first_name = "GROUCHO"
WHERE first_name = "HARPO";

SHOW CREATE TABLE address;

SELECT first_name, last_name, address
FROM staff s
Join address a
on (s.address_id = a.address_id);

SELECT * FROM payment;
SELECT * FROM staff;

SELECT first_name, last_name, SUM(amount) AS "Total"
FROM staff s
JOIN payment p
on (s.staff_id = p.staff_id)
WHERE p.payment_date > "2005-08-1-0:0:0"
GROUP BY p.staff_id;

SELECT * FROM film;
SELECT * FROM film_actor;

SELECT f.title, COUNT(fa.film_id) AS "Number of Actors"
FROM film f
JOIN film_actor fa
on (f.film_id = fa.film_id)
GROUP BY fa.film_id;

SELECT * FROM inventory;

SELECT title, COUNT(i.film_id) AS "number of copies"
FROM film f
JOIN inventory i
on (f.film_id = i.film_id)
WHERE f.title = "Hunchback Impossible"
GROUP BY i.film_id;

SELECT * FROM customer;
SELECT *FROM payment;

SELECT c.first_name, c.last_name, SUM(p.amount) AS "Total Amount Paid"
FROM customer c
JOIN payment p
on (c.customer_id = p.customer_id)
GROUP BY p.customer_id
ORDER BY c.last_name ASC;

SELECT * FROM film;
SELECT * FROM language;

SELECT title 
FROM film
WHERE language_id In
(
	SELECT language_id
    FROM language
    WHERE name = "English"
)
HAVING title LIKE "K%" OR title LIKE "Q%";

SELECT * FROM film;
SELECT * FROM actor;
SELECT * FROM film_actor;

SELECT first_name, last_name
FROM actor
WHERE actor_id in
(
	SELECT actor_id
    FROM film_actor
    WHERE film_id in
    (
		SELECT film_id
        FROM film
        WHERE title = "Alone Trip"
	)
);

SELECT * FROM customer;
SELECT * FROM country;
SELECT * FROM address;
SELECT * FROM city;

SELECT c.first_name, c.last_name, c.email
FROM customer c JOIN address a ON (c.address_id = a.address_id)
JOIN city ci ON (a.city_id = ci.city_id)
JOIN country co ON (ci.country_id = co.country_id)
WHERE country = "Canada";

SELECT * FROM film;
SELECT * FROM category;
SELECT * FROM film_category;

SELECT f.title 
FROM film f
JOIN film_category fa on (f.film_id = fa.film_id)
JOIN category c ON (fa.category_id = c.category_id)
WHERE c.name = "Family";

SELECT * FROM rental;
SELECT * FROM inventory;
SELECT * FROM film;

SELECT f.title, COUNT(r.inventory_id) AS "number rented"
FROM film f JOIN inventory i on (f.film_id = i.film_id)
JOIN rental r ON (i.inventory_id = r.inventory_id)
GROUP BY i.film_id
ORDER BY COUNT(r.inventory_id) DESC;

SELECT * FROM store;
SELECT * FROM payment;
SELECT * FROM customer;

SELECT s.store_id, SUM(p.amount)
FROM store s JOIN customer c ON (s.store_id = c.store_id)
JOIN payment p ON (c.customer_id = p.customer_id)
GROUP BY s.store_id;

SELECT * FROM store;
SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM address;

SELECT s.store_id, c.city, co.country
FROM store s JOIN address a ON (s.address_id = a.address_id)
JOIN city c ON (a.city_id = c.city_id)
JOIN country co ON (c.country_id = co.country_id);

SELECT * FROM category;
SELECT * FROM film_category;
SELECT * FROM inventory;
SELECT * FROM payment;
SELECT * FROM rental;

SELECT c.name, SUM(p.amount) AS "Gross Revenue"
FROM category c join film_category fc ON(c.category_id = fc.category_id)
JOIN inventory i ON (fc.film_id = i.film_id)
JOIN rental r ON (i.inventory_id = r.inventory_id)
JOIN payment p ON (r.rental_id = p.rental_id)
GROUP BY c.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;

CREATE VIEW gross_revenue AS
SELECT c.name, SUM(p.amount) AS "Gross Revenue"
FROM category c join film_category fc ON(c.category_id = fc.category_id)
JOIN inventory i ON (fc.film_id = i.film_id)
JOIN rental r ON (i.inventory_id = r.inventory_id)
JOIN payment p ON (r.rental_id = p.rental_id)
GROUP BY c.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;

SELECT * FROM gross_revenue;

DROP VIEW gross_revenue;

