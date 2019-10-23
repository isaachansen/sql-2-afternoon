-- PRACTICE JOINS

SELECT *
FROM invoice i
JOIN invoice_line il ON il.invoice_id = i.invoice_id
WHERE il.unit_price > 0.99;

SELECT i.invoice_date, c.first_name, c.last_name, i.total
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id;

SELECT e.first_name, e.last_name, c.first_name, c.last_name
FROM employee e
JOIN customer c ON c.support_rep_id = e.employee_id;

SELECT ar.name, al.title
FROM album al
JOIN artist ar ON ar.artist_id = al.artist_id;

SELECT pt.track_id
FROM playlist_track pt
JOIN playlist p ON p.playlist_id = pt.playlist_id
WHERE p.name = 'Music';

SELECT t.name
FROM track t
JOIN playlist_track pt ON t.track_id = pt.track_id
WHERE pt.playlist_id = 5;

SELECT p.name, t.name
FROM track t
JOIN playlist_track pt ON t.track_id = pt.track_id
JOIN playlist p ON p.playlist_id = pt.playlist_id;

SELECT t.name, a.title
FROM track t
JOIN genre g ON g.genre_id = t.genre_id
JOIN album a ON a.album_id = t.album_id
WHERE g.name='Alternative & Punk';

-- PRACTICE NESTED QUERIES

SELECT *
FROM invoice
WHERE invoice_id IN ( SELECT invoice_id FROM invoice_line WHERE unit_price > 0.99 );

SELECT *
FROM playlist_track
WHERE playlist_id IN ( SELECT playlist_id FROM playlist WHERE name = 'Music' );

SELECT name
FROM track
WHERE track_id IN ( SELECT track_id FROM playlist_track WHERE playlist_id = 5 );

SELECT * 
FROM track
WHERE genre_id IN (SELECT genre_id FROM genre WHERE name='Comedy');

SELECT * 
FROM track
WHERE album_id IN (SELECT album_id FROM album WHERE name='Fireball');

SELECT * 
FROM track
WHERE album_id IN(
  SELECT album_id FROM album WHERE artist_id IN (
  	SELECT artist_id FROM artist WHERE name='Queen'));
    

-- PRACTICE UPDATES

UPDATE customer
SET fax = null
WHERE fax IS NOT null;

UPDATE customer
SET company = 'Self'
WHERE company IS NULL;

UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';

UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = ( SELECT genre_id FROM genre WHERE name = 'Metal' )
AND composer IS null;

-- GROUP BY

SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;

SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name;

SELECT ar.name, COUNT(*)
FROM album al
JOIN artist ar ON ar.artist_id = al.artist_id
GROUP BY ar.name;

-- USE DISTINCT

SELECT DISTINCT composer
FROM track;

SELECT DISTINCT billing_postal_code
FROM invoice;

SELECT DISTINCT company
FROM customer;

-- DELETE ROWS

DELETE
FROM practice_delete
WHERE type = 'bronze';

DELETE
FROM practice_delete
WHERE type = 'silver';

DELETE
FROM practice_delete
WHERE value = 150;

-- eCommerce Simulation

CREATE TABLE user_data (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(64),
    email VARCHAR(64)
    );

CREATE TABLE product (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(64),
    price NUMERIC
);

CREATE TABLE order_data (
    order_id SERIAL PRIMARY KEY
    name VARCHAR(64) REFERENCES product(name),
    price NUMERIC REFERENCES product(price)
);

INSERT INTO user (name, email)
VALUES
('Isaac', 'isaachansen2400@gmail.com'),
('Faith', 'faithnashofficial@gmail.com'),
('Christian', 'christian@gmail.com');

INSERT INTO product (name, price)
VALUES
('iPhone', 1000),
('Airpods', 200),
('Macbook Pro', 1500);

