-- times in GTFS are unusual, see: https://gtfs.org/documentation/schedule/reference/#field-types
-- convert HH:MM:SS format to a count of seconds so that actual times can be calculated
{% macro gtfs_time_to_seconds(gtfs_time) %}
CAST(split_part({{ gtfs_time }}, ':', 1) AS INT) * 60 * 60 + CAST(split_part({{ gtfs_time }}, ':', 2) AS INT) * 60 + CAST(split_part({{ gtfs_time }}, ':', 3) AS INT)
{% endmacro %}