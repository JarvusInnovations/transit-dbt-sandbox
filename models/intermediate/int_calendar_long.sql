-- get min start/end dates in our DB to define the date spine

{% set min_date_sql_statement %}
    SELECT MIN(start_date) FROM {{ ref('stg_calendar') }}
{% endset %}

{% set max_date_sql_statement %}
    SELECT MAX(end_date) FROM {{ ref('stg_calendar') }}
{% endset %}

{%- set min_start = dbt_utils.get_single_value(min_date_sql_statement, default="DATE_ADD(CURRENT_DATE(), INTERVAL (-1) YEAR)") -%}
{%- set max_end = dbt_utils.get_single_value(max_date_sql_statement, default="DATE_ADD(CURRENT_DATE(), INTERVAL 1 YEAR)") -%}

WITH calendar AS (
    SELECT * FROM {{ ref('stg_calendar') }}
),

unpivoted_calendar AS (
    UNPIVOT calendar
    ON monday, tuesday, wednesday, thursday, friday, saturday, sunday
    INTO
        NAME day_of_week
        VALUE service_ind
),

raw_date_spine AS (
    {{ dbt_date.get_base_dates(start_date=min_start, end_date=max_end) }}
),

date_spine_day_of_week AS (
    SELECT 
        date_day AS dt,
        CASE DAYOFWEEK(date_day)
            WHEN 0 THEN 'sunday'
            WHEN 1 THEN 'monday'
            WHEN 2 THEN 'tuesday'
            WHEN 3 THEN 'wednesday'
            WHEN 4 THEN 'thursday'
            WHEN 5 THEN 'friday'
            WHEN 6 THEN 'saturday'
        END AS day_of_week
    FROM raw_date_spine
),

int_calendar_long AS (
    SELECT 
        calendar._feed_id,
        calendar.service_id,
        dates.dt AS service_date,
        calendar.start_date,
        calendar.end_date, 
        calendar.day_of_week,
        calendar.service_ind AS has_service
    FROM date_spine_day_of_week dates
    LEFT JOIN unpivoted_calendar calendar
        ON dates.day_of_week = calendar.day_of_week
        AND dates.dt BETWEEN calendar.start_date and calendar.end_date
)

SELECT * FROM int_calendar_long



