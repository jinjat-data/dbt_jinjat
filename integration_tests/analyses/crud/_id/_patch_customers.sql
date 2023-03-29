{%- set request = jinjat.request() %}
UPDATE
    {{ ref('customers') }}
    set {% for key, value in request.body.items() %}
        {{ jinjat.quote_identifier(key) }} = {{ jinjat.quote_literal(value) }}

        {% if not loop.last %},
        {% endif %}
    {% endfor %}
WHERE
    {{ jinjat.get_jinjat_config(
        'ref',
        'customers'
    ).schema['x-pk'] }} = {{ jinjat.quote_literal(
        request.params.id
    ) }}
