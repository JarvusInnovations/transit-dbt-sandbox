WITH trips_src AS (
    SELECT *
    FROM {{ source('raw', 'trips') }}
),

stg_trips AS (
    SELECT 
        feed_id AS _feed_id,
        route_id,
        service_id,
        trip_id,
        trip_headsign,
        trip_short_name,
        direction_id,
        block_id,
        shape_id,
        wheelchair_accessible,
        bikes_allowed
    FROM trips_src
)

SELECT * FROM stg_trips
