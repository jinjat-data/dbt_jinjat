{%- set request = jinjat.request() %}

{%- set query = request.query %}

SELECT
    {{ jinjat.generate_select(
        query.select
    ) }}
FROM
{{ ref('customers') }}

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