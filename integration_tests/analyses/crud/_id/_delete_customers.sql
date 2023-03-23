{%- set request = jinjat.request() %}
DELETE FROM
    {{ ref('raw_customers') }}
WHERE
    {{ jinjat.generate_where({ "field": jinjat.get_jinjat_config('ref', 'customers').schema['x-pk'], "operator": "equals", "value": request.params.id }) }}
 