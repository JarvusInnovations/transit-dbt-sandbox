-- https://discourse.getdbt.com/t/stop-schemas-from-concatenating/15180/3
{% macro generate_schema_name(custom_schema_name, node) %}
    {{ custom_schema_name }}
{% endmacro %}