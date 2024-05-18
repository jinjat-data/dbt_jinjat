-- LIST

{% macro generate_jinjat_refine_app_list(to_resource) %}
    {%- set request = jinjat.request() %}

    {%- set query = request.query %}

    SELECT
        {{ jinjat.generate_select(
            query.select
        ) }}
    FROM
    {{ to_resource }}

    {% if query.filters is defined %} 
    WHERE
        {{ jinjat.generate_where(filters) }}
    {% endif %}

    {% if query.sort is defined %}
    ORDER BY
        {% for sorting in query.sort %}
                {{ jinjat.quote_identifier(sorting.field) }}

                {% if sorting.order %}
                    ASC
                {% else %}
                    DESC
                {% endif %}
        {% endfor %}
    {% endif %}
{% endmacro %}

{% macro _generate_jinjat_refine_app_list(to_resource) %}
  {% raw %}
    {%- set request = jinjat.request() %}

    {%- set query = request.query %}

    SELECT
        {{ jinjat.generate_select(
            query.select
        ) }}
    FROM
    {% endraw %}{{ to_resource }}{% raw %}

    {% if query.filters is defined %} 
    WHERE
        {{ jinjat.generate_where(filters) }}
    {% endif %}

    {% if query.sort is defined %}
    ORDER BY
        {% for sorting in query.sort %}
                {{ jinjat.quote_identifier(sorting.field) }}

                {% if sorting.order %}
                    ASC
                {% else %}
                    DESC
                {% endif %}
        {% endfor %}
    {% endif %}
 {% endraw %}
{% endmacro %}

-- CREATE

{% macro generate_jinjat_refine_app_create(to_resource) %}
{%- set payload = jinjat.request().body %}
INSERT INTO
    {{ to_resource }}
    ({% for key, value in payload.items() %}
        {{ jinjat.quote_identifier(key) }}

        {% if not loop.last %},{% endif %}
    {% endfor %})
VALUES
    ({% for key, value in payload.items() %}
        {{ jinjat.quote_literal_value(value) }}
        {% if not loop.last %},{% endif %}
    {% endfor %})
{% endmacro %}

{% macro _generate_jinjat_refine_app_create(to_resource) %}
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

-- DELETE

{% macro _generate_jinjat_refine_app_delete(to_resource) %}
{% endmacro %}

{% macro _generate_jinjat_refine_app_patch(to_resource) %}
{% endmacro %}

-- GET

{% macro _generate_jinjat_refine_app_get(to_resource) %}
{% raw %}
{%- set request = jinjat.request() %}
SELECT
    {{ jinjat.generate_select(request.query.select) }}
FROM
    {% endraw %}{{ to_resource }}{% raw %}
WHERE
    {{ jinjat.generate_where({ "field": jinjat.get_jinjat_config('ref', 'customers').schema['x-pk'], "operator": "equals", "value": request.params.id }) }}
LIMIT
    1
{% endraw %}
{% endmacro %}
