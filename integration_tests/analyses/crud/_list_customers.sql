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

{% if query.sorters is defined %}
ORDER BY
    {% for sorting in query.sorters %}
            {{ jinjat.quote_identifier(sorting.field) }}

            {% if sorting.order %}
                ASC
            {% else %}
                DESC
            {% endif %}
    {% endfor %}
{% endif %}