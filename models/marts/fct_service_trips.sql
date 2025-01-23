WITH routes AS (
    SELECT * FROM {{ ref('stg_routes') }}
),

trips AS (
    SELECT * FROM {{ ref('stg_trips') }}
),

service_calendar AS (
    SELECT * FROM {{ ref('fct_service_calendar') }}
),

fct_service_trips AS (
    SELECT 
        service_calendar._feed_id,
        service_calendar.service_date,
        service_calendar.service_id,
        trips.trip_id,
        routes.route_id,
        trips.direction_id,
        routes.route_short_name,
        routes.route_long_name,
        routes.route_type
    FROM service_calendar
    LEFT JOIN trips 
        ON service_calendar._feed_id = trips._feed_id
        AND service_calendar.service_id = trips.service_id
    LEFT JOIN routes
        ON service_calendar._feed_id = routes._feed_id
        AND trips.route_id = routes.route_id   
)

SELECT * FROM fct_service_trips