{% macro generate_jinjat_refine_app_list(to_resource) %}

{% endmacro %}


{% macro generate_jinjat_refine_app_create(to_resource) %}
{% raw %}
{%- set payload = jinjat.request().body %}
INSERT INTO
    {% endraw %}{{ to_resource }}{% raw %}
    ({% for key, value in payload.items() %}
        {{ jinjat.quote_identifier(key) }}

        {% if not loop.last %},{% endif %}
    {% endfor %})
VALUES
    ({% for key, value in payload.items() %}
        {{ jinjat.quote_literal_value(value) }}
        {% if not loop.last %},{% endif %}
    {% endfor %})
{% endraw %}
{% endmacro %}

{% macro generate_jinjat_refine_app_delete(to_resource) %}
{% endmacro %}

{% macro generate_jinjat_refine_app_patch(to_resource) %}
{% endmacro %}

{% macro generate_jinjat_refine_app_get(to_resource) %}
{% endmacro %}
