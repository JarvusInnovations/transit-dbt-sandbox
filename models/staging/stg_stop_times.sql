WITH stop_times_src AS (
    SELECT *
    FROM {{ source('raw', 'stop_times') }}
),

stg_stop_times AS (
    SELECT 
        feed_id AS _feed_id,
        trip_id,
        arrival_time,
        departure_time,
        {{ gtfs_time_to_seconds('arrival_time') }} AS arrival_seconds,
        {{ gtfs_time_to_seconds('departure_time') }} AS departure_seconds,
        stop_id,
        stop_sequence,
        stop_headsign,
        pickup_type,
        drop_off_type,
        shape_dist_traveled,
        timepoint,
        start_pickup_drop_off_window,
        end_pickup_drop_off_window,
        continuous_pickup,
        continuous_drop_off,
        pickup_booking_rule_id,
        drop_off_booking_rule_id
    FROM stop_times_src
)

SELECT * FROM stg_stop_times
