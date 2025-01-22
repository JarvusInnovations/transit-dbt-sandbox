WITH long_calendar AS (
    SELECT * FROM {{ ref('int_calendar_long') }}
),

calendar_dates AS (
    SELECT * FROM {{ ref('stg_calendar_dates') }}
),

boolean_calendar_dates AS (
    SELECT 
        _feed_id,
        service_id,
        CASE DAYOFWEEK(date)
            WHEN 0 THEN 'sunday'
            WHEN 1 THEN 'monday'
            WHEN 2 THEN 'tuesday'
            WHEN 3 THEN 'wednesday'
            WHEN 4 THEN 'thursday'
            WHEN 5 THEN 'friday'
            WHEN 6 THEN 'saturday'
        END AS day_of_week,
        date AS service_date,
        CASE exception_type
            WHEN 1 THEN True
            WHEN 2 THEN False 
        END AS has_service
    FROM calendar_dates
),

combined_calendar AS (
    SELECT 
        COALESCE(boolean_calendar_dates._feed_id, long_calendar._feed_id) AS _feed_id,
        COALESCE(boolean_calendar_dates.service_id, long_calendar.service_id) AS service_id,
        COALESCE(boolean_calendar_dates.service_date, long_calendar.service_date) AS service_date,
        COALESCE(boolean_calendar_dates.day_of_week, long_calendar.day_of_week) AS day_of_week,
        -- this is the only one where order matters; calendar_dates modifies calendar 
        COALESCE(boolean_calendar_dates.has_service, long_calendar.has_service) AS has_service,
    FROM long_calendar
    FULL OUTER JOIN boolean_calendar_dates
        ON long_calendar._feed_id = boolean_calendar_dates._feed_id
        AND long_calendar.service_date = boolean_calendar_dates.service_date
        AND long_calendar.service_id = boolean_calendar_dates.service_id 
),

fct_service_calendar AS (
    SELECT 
        _feed_id,
        service_id,
        service_date,
        day_of_week
    FROM combined_calendar
    WHERE has_service
)

SELECT * FROM fct_service_calendar

