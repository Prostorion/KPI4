

--Розрахувати сумарну затримку по містах

SELECT C.city, A.dep_delay, B.arr_delay, A.dep_delay + B.arr_delay as total_delay FROM
(SELECT flights.origin as city, sum(flights.dep_delay) as dep_delay FROM flights GROUP BY city) AS A
FULL OUTER JOIN
(SELECT flights.dest as city, sum(flights.arr_delay) as arr_delay FROM flights GROUP BY city) AS B
ON A.city = B.city  INNER JOIN airports AS C ON A.city = C.iata_code OR B.city = C.iata_code;

-- columnar: execution: 15 s 808 ms,
-- row based: execution: 28 s 806 ms


--Порахувати кількість польотів по містах

SELECT C.city, origin_count, dest_count, origin_count + dest_count FROM
(SELECT count(*) as origin_count, origin as city FROM flights GROUP BY flights.origin) AS A
FULL OUTER JOIN
(SELECT count(*) as dest_count, dest as city FROM flights GROUP BY flights.dest) AS B
ON A.city = B.city INNER JOIN airports AS C ON A.city = C.iata_code OR B.city = C.iata_code;

-- columnar: execution: 12 s 608 ms
-- row based: execution: 13 s 606 ms

--Знайти місто з найменшою і найбільшою затримкою
SELECT MIN(delay) as min_delay, B.city FROM
(SELECT MIN(arr_delay) as delay, dest as city FROM flights GROUP BY dest
UNION ALL
SELECT MIN(dep_delay) as delay, origin as city FROM flights GROUP BY origin) as A
INNER JOIN airports as B
ON A.city = B.iata_code
GROUP BY  B.city ORDER BY min_delay LIMIT 1;

-- columnar: execution: 16 s 596 ms
-- row based: execution: 23 s 334 ms

SELECT MAX(delay) as max_delay, B.city FROM
(SELECT MAX(arr_delay) as delay, dest as city FROM flights GROUP BY dest
UNION ALL
SELECT MAX(dep_delay) as delay, origin as city FROM flights GROUP BY origin) as A
INNER JOIN airports as B
ON A.city = B.iata_code
GROUP BY  B.city ORDER BY max_delay DESC LIMIT 1;

-- columnar: execution: 15 s 772 ms
-- row based: execution: 21 s 168 ms

--Знайти всі польоти з затримкою більше за середній час затримки

CREATE VIEW average_delay AS
SELECT AVG(delay) FROM
(SELECT AVG(dep_delay) as delay FROM flights
UNION ALL
SELECT AVG(arr_delay) as delay FROM flights) AS A;


SELECT * FROM flights
WHERE arr_delay > (SELECT AVG(delay) FROM
(SELECT AVG(dep_delay) as delay FROM flights
UNION ALL
SELECT AVG(arr_delay) as delay FROM flights) AS A)
OR dep_delay > (SELECT AVG(delay) FROM
(SELECT AVG(dep_delay) as delay FROM flights
UNION ALL
SELECT AVG(arr_delay) as delay FROM flights) AS A);

-- columnar: execution: 13 s 573 ms
-- row based: execution: 24 s 345 ms


SELECT pg_size_pretty(pg_database_size('columnstore_bts')) AS columnstore_size;
SELECT pg_size_pretty(pg_database_size('rowstore_flights')) as rowstore_size;


