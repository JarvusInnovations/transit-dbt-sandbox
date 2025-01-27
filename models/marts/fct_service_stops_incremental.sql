{{
    config(
        materialized='incremental',
        unique_key = ['service_date', 'trip_id', 'stop_sequence'],
        incremental_strategy='delete+insert',
    )
}}

WITH trips AS (
    SELECT * FROM {{ ref('fct_service_trips') }}
    {% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    WHERE service_date >= (SELECT COALESCE(MAX(service_date),'TIMESTAMP 1900-01-01') FROM {{ this }} )
    {% endif %}
),

stop_times AS (
    SELECT * FROM {{ ref('stg_stop_times') }}
),

stops AS (
    SELECT * FROM {{ ref('stg_stops') }}
),

joined_trips_stops AS (
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
        trips.service_date + INTERVAL (stop_times.departure_seconds) SECOND AS departure_time, 
        CURRENT_TIMESTAMP AS _insert_time
    FROM trips
    LEFT JOIN stop_times 
        ON trips._feed_id = stop_times._feed_id
        AND trips.trip_id = stop_times.trip_id 
    LEFT JOIN stops
        ON stop_times._feed_id = stops._feed_id
        AND stop_times.stop_id = stops.stop_id  
),

fct_service_stops AS (
    SELECT
        _feed_id,
        service_date,
        service_id,
        trip_id,
        route_id,
        direction_id,
        route_short_name,
        route_long_name,
        route_type,
        service_date,
        stop_id,
        stop_name,
        stop_sequence,
        stop_lat,
        stop_lon,
        arrival_time,
        departure_time,
        _insert_time
    FROM joined_trips_stops
    -- this is a contrived way to let people inspect the incremental behavior
    WHERE arrival_time < _insert_time
)

SELECT * FROM fct_service_stops