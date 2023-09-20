COPY airlines
FROM '/airlines.csv'
WITH (FORMAT CSV, HEADER true, DELIMITER ',');

COPY airports
FROM '/airports.csv'
WITH (FORMAT CSV, HEADER true, DELIMITER ',');

COPY flights
FROM '/flights_3.csv'
WITH (FORMAT CSV, HEADER true, DELIMITER ',');

SELECT * FROM flights limit 10000 ;

SELECT * FROM airports  ;

SELECT * FROM airlines ;

ALTER TABLE flights ADD COLUMN id SERIAL PRIMARY KEY;


