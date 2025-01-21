WITH calendar_src AS (
    SELECT *
    FROM {{ source('raw', 'calendar') }}
),

stg_calendar AS (
    SELECT 
        feed_id,
        service_id,
        monday,
        tuesday,
        wednesday,
        thursday,
        friday,
        saturday,
        sunday,
        start_date,
        end_date
    FROM calendar_src
)

SELECT * FROM stg_calendar
