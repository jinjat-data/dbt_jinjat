{%- set request = jinjat.request() %}
SELECT
    {{ jinjat.generate_select(request.query.select) }}
FROM
    {{ ref('customers') }}
WHERE
    {{ jinjat.generate_where({ "field": jinjat.get_jinjat_config('ref', 'customers').schema['x-pk'], "operator": "equals", "value": request.params.id }) }}
LIMIT
    1
