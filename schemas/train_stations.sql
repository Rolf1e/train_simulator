CREATE TABLE IF NOT EXISTS train_stations (
    train_station_code INTEGER,
    name VARCHAR,
    fronton_name VARCHAR,

    postal_code INTEGER,
    city_code INTEGER,
    city_name VARCHAR, 
    county_code INTEGER,
    county_name VARCHAR,
    uic_code INTEGER,
    longitude DECIMAL,
    latitude DECIMAL,

    sncf_region VARCHAR,
    unity_gare VARCHAR,

    drg_segment CHAR, -- train station with a (national and international), b (regional) and c (local) interest.

    plateform_code VARCHAR(8),
    plateform_name VARCHAR,
    rg VARCHAR,
    platform_count INTEGER
)
