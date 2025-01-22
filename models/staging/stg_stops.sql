WITH stops_src AS (
    SELECT *
    FROM {{ source('raw', 'stops') }}
),

stg_stops AS (
    SELECT 
        feed_id AS _feed_id,
        stop_id,
        stop_code,
        stop_name,
        tts_stop_name,
        stop_desc,
        stop_lat,
        stop_lon,
        zone_id,
        stop_url,
        location_type,
        parent_station,
        wheelchair_boarding,
        stop_timezone,
        level_id,
        platform_code
    FROM stops_src
)

SELECT * FROM stg_stops
