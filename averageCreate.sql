DROP DATABASE IF EXISTS rowstore_flights;

CREATE DATABASE rowstore_flights;

\c  rowstore_flights;

CREATE TABLE airlines
(
    iata_code varchar(2) CONSTRAINT PK_airlines PRIMARY KEY,
    airline   varchar(30)
);

CREATE TABLE airports
(
    iata_code varchar(3) CONSTRAINT PK_airports PRIMARY KEY,
    airport   varchar(80),
    city      varchar(30),
    state     varchar(2),
    country   varchar(30),
    latitude  decimal(11, 4),
    longitude decimal(11, 4)

);

CREATE TABLE flights
(
    year smallint,
    month smallint,
    day smallint,
    day_of_week smallint,
    fl_date date,
    carrier varchar(2),
    tail_num varchar(6),
    fl_num smallint,
    origin varchar(5),
    dest                varchar(5),
    crs_dep_time        varchar(4),
    dep_time            varchar(4),
    dep_delay           decimal(13, 2),
    taxi_out            decimal(13, 2),
    wheels_off          varchar(4),
    wheels_on           varchar(4),
    taxi_in             decimal(13, 2),
    crs_arr_time        varchar(4),
    arr_time            varchar(4),
    arr_delay           decimal(13, 2),
    cancelled           decimal(13, 2),
    cancellation_code   varchar(20),
    diverted            decimal(13, 2),
    crs_elapsed_time    decimal(13, 2),
    actual_elapsed_time decimal(13, 2),
    air_time            decimal(13, 2),
    distance            decimal(13, 2),
    carrier_delay       decimal(13, 2),
    weather_delay       decimal(13, 2),
    nas_delay           decimal(13, 2),
    security_delay      decimal(13, 2),
    late_aircraft_delay decimal(13, 2)

);

CREATE INDEX idx_flights_year ON flights (year);
CREATE INDEX idx_flights_carrier ON flights (carrier);
CREATE INDEX idx_flights_carrier_delay ON flights (carrier_delay);
CREATE INDEX idx_flights_weather_delay ON flights (weather_delay);
CREATE INDEX idx_flights_nas_delay ON flights (nas_delay);
CREATE INDEX idx_flights_security_delay ON flights (security_delay);
CREATE INDEX idx_flights_late_aircraft_delay ON flights (late_aircraft_delay);
CREATE INDEX idx_flights_arr_delay ON flights (arr_delay);
CREATE INDEX idx_flights_month ON flights (month);
CREATE INDEX idx_flights_dest ON flights (dest);