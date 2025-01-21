WITH routes_src AS (
    SELECT *
    FROM {{ source('raw', 'routes') }}
),

stg_routes AS (
    SELECT 
        feed_id AS _feed_id,
        route_id,
        agency_id,
        route_short_name,
        route_long_name,
        route_desc,
        route_type,
        route_url,
        route_color,
        route_text_color,
        route_sort_order,
        continuous_pickup,
        continuous_drop_off,
        network_id
    FROM routes_src
)

SELECT * FROM stg_routes