WITH calendar_src AS (
    SELECT *
    FROM {{ source('raw', 'calendar') }}
),

stg_calendar AS (
    SELECT 
        feed_id AS _feed_id,
        service_id,
        CAST(monday AS BOOLEAN) AS monday,
        CAST(tuesday AS BOOLEAN) AS tuesday,
        CAST(wednesday AS BOOLEAN) AS wednesday,
        CAST(thursday AS BOOLEAN) AS thursday,
        CAST(friday AS BOOLEAN) AS friday,
        CAST(saturday AS BOOLEAN) AS saturday,
        CAST(sunday AS BOOLEAN) AS sunday,
        STRPTIME(start_date, '%Y%m%d') as start_date,
        STRPTIME(end_date, '%Y%m%d') as end_date
    FROM calendar_src
)

SELECT * FROM stg_calendar
