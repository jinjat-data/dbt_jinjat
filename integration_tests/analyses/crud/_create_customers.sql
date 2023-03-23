{%- set payload = jinjat.request().body %}
INSERT INTO
    {{ ref('raw_customers') }}
    ({% for key, value in payload.items() %}
        {{ jinjat.quote_identifier(key) }}

        {% if not loop.last %},{% endif %}
    {% endfor %})
VALUES
    ({% for key, value in payload.items() %}
        {{ jinjat.quote_literal_value(value) }}

        {% if not loop.last %},{% endif %}
    {% endfor %})
RETURNING *