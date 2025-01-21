WITH calendar_dates_src AS (
    SELECT *
    FROM {{ source('raw', 'calendar_dates') }}
),

stg_calendar_dates AS (
    SELECT 
        feed_id,
        service_id,
        date,
        exception_type
    FROM calendar_dates_src
)

SELECT * FROM stg_calendar_dates
