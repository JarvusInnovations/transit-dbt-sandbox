WITH trips AS (
    SELECT * FROM {{ ref('fct_service_trips') }}
),

stop_times AS (
    SELECT * FROM {{ ref('stg_stop_times') }}
),

stops AS (
    SELECT * FROM {{ ref('stg_stops') }}
),

fct_service_stops AS (
    SELECT
        trips._feed_id,
        trips.service_date,
        trips.service_id,
        trips.trip_id,
        trips.route_id,
        trips.direction_id,
        trips.route_short_name,
        trips.route_long_name,
        trips.route_type,
        trips.service_date,
        stop_times.stop_id,
        stops.stop_name,
        stop_times.stop_sequence,
        stops.stop_lat,
        stops.stop_lon,
        -- this is technically not quite right! 
        -- GTFS times are relative to noon minus 12 hours rather than midnight to handle daylight savings 
        -- but not implementing that here for simplicity
        trips.service_date + INTERVAL (stop_times.arrival_seconds) SECOND AS arrival_time,
        trips.service_date + INTERVAL (stop_times.departure_seconds) SECOND AS departure_time 

    FROM trips
    LEFT JOIN stop_times 
        ON trips._feed_id = stop_times._feed_id
        AND trips.trip_id = stop_times.trip_id 
    LEFT JOIN stops
        ON stop_times._feed_id = stops._feed_id
        AND stop_times.stop_id = stops.stop_id 
)

SELECT * FROM fct_service_stops